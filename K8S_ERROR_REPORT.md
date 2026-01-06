# Kubernetes Configuration Error Report
**FinPay Payment Platform - K8s Deployment Analysis**
**Date:** 2026-01-06
**Namespace:** prod
**Helm Chart:** finpay-app v1.0.0

---

## Executive Summary

The FinPay payment platform deployment is currently **non-functional** with all payment-api pods failing to start and payment-worker pods in CrashLoopBackOff state. This report identifies **8 critical and high-priority errors** that must be resolved for the application to function.

**Current Cluster State:**
- payment-api: 0/2 pods ready (CreateContainerConfigError)
- payment-worker: 0/2 pods ready (CrashLoopBackOff / Running but not ready)
- Multiple ReplicaSets indicating failed rollout attempts

---

## Critical Errors (P0 - Blocks Deployment)

### 1. Missing DB_URL Key in ConfigMap
**Severity:** CRITICAL
**Impact:** payment-api pods cannot start
**Status:** CreateContainerConfigError on all payment-api pods

**Error Message:**
```
couldn't find key DB_URL in ConfigMap prod/finpay-config
```

**Root Cause:**
- File: `k8s/finpay-app/templates/configmap.yaml:11`
- The ConfigMap template defines: `DB_URL: {{ .Values.config.dbUrl }}`
- In `values.yaml:66`, dbUrl is set to empty string: `dbUrl: ""`
- In `values-prod.yaml:13`, dbUrl is properly set to the RDS endpoint
- However, the **deployed ConfigMap in the cluster is missing the DB_URL key entirely**

**Current Deployed ConfigMap:**
```yaml
data:
  APP_ENV: production
  LOG_LEVEL: INFO
  # DB_URL: MISSING!
```

**Expected ConfigMap:**
```yaml
data:
  APP_ENV: production
  LOG_LEVEL: INFO
  DB_URL: jdbc:postgresql://finpay-db.c144aqq2u663.eu-central-1.rds.amazonaws.com:5432/paymentdb
```

**Fix Required:**
1. Redeploy the Helm chart with proper values-prod.yaml to ensure DB_URL is included
2. Verify the ConfigMap contains the DB_URL key after deployment
3. Payment-api pods should automatically restart and pick up the corrected ConfigMap

---

### 2. Payment-Worker Pods Crashing (Java Reflection Error)
**Severity:** CRITICAL
**Impact:** payment-worker pods crash on startup
**Status:** CrashLoopBackOff (some pods) / Running but failing readiness probes

**Error Message:**
```
java.lang.reflect.InaccessibleObjectException: Unable to make field static final boolean
java.io.FileSystem.useCanonCaches accessible: module java.base does not "opens java.io"
to unnamed module
```

**Root Cause:**
The JAVA_OPTS environment variable in the deployment contains the correct flags BUT there appears to be an issue with how they're being parsed or applied. The current JAVA_OPTS includes:
```
-Djava.io.tmpdir=/tmp --add-opens java.base/java.io=ALL-UNNAMED --add-opens
java.base/java.lang=ALL-UNNAMED --add-opens java.rmi/sun.rmi.transport=ALL-UNNAMED
```

**Potential Issues:**
1. The YAML formatting might be causing the value to split across lines incorrectly
2. The container image might not be properly using the JAVA_OPTS environment variable
3. Verify the Dockerfile CMD/ENTRYPOINT properly references $JAVA_OPTS

**Fix Required:**
1. Verify `app/payment-worker/Dockerfile` uses JAVA_OPTS correctly
2. Ensure the entrypoint script passes JAVA_OPTS to the java command
3. Test the container locally with the same JAVA_OPTS

---

### 3. Payment-Worker Readiness Probe Failures
**Severity:** HIGH
**Impact:** Pods run but marked as not ready, no traffic routed
**Status:** One pod showing "Readiness probe failed: HTTP probe failed with statuscode: 404"

**Error Message:**
```
Readiness probe failed: HTTP probe failed with statuscode: 404
```

**Probe Configuration:**
- Path: `/actuator/ready`
- Port: 8090
- Returns: 404 Not Found

**Root Cause:**
The application might be exposing `/actuator/health` but not `/actuator/ready`. This could be:
1. Missing Spring Boot Actuator endpoint configuration
2. Incorrect endpoint name (should be `/actuator/health/readiness`)
3. Application not fully starting due to error #2

**Fix Required:**
1. Verify Spring Boot Actuator endpoints in payment-worker application
2. Check if the endpoint should be `/actuator/health/readiness` instead of `/actuator/ready`
3. Update the readiness probe path in `k8s/finpay-app/templates/payment-worker-deployment.yaml:78`

---

## High Priority Errors (P1 - Security/Best Practices)

### 4. Incorrect IAM Role Annotation Placement
**Severity:** HIGH
**Impact:** IAM roles for service accounts (IRSA) will not work
**File:** `k8s/finpay-app/templates/payment-api-deployment.yaml:10`

**Current Configuration (WRONG):**
```yaml
apiVersion: apps/v1
kind: Deployment
metadata:
  name: payment-api
  annotations:
    eks.amazonaws.com/role-arn: arn:aws:iam::408502715963:role/finpay-payment-api-role
```

**Issue:**
The IAM role annotation is placed on the Deployment metadata. In EKS, IRSA (IAM Roles for Service Accounts) requires the annotation on a **ServiceAccount** resource, not on the Deployment.

**Correct Implementation:**
```yaml
# serviceaccount.yaml
apiVersion: v1
kind: ServiceAccount
metadata:
  name: payment-api
  namespace: prod
  annotations:
    eks.amazonaws.com/role-arn: arn:aws:iam::408502715963:role/finpay-payment-api-role
---
# deployment.yaml
spec:
  template:
    spec:
      serviceAccountName: payment-api  # Reference the ServiceAccount
```

**Fix Required:**
1. Create `k8s/finpay-app/templates/serviceaccount.yaml` with ServiceAccount resources
2. Add annotation to ServiceAccount metadata
3. Remove annotation from Deployment metadata
4. Add `serviceAccountName` field to Deployment pod spec

**Affected Files:**
- `payment-api-deployment.yaml:10`
- `payment-worker-deployment.yaml` (same issue)

---

### 5. Missing ServiceAccount Resources
**Severity:** HIGH
**Impact:** Cannot use IAM roles, pods use default ServiceAccount
**File:** Missing `k8s/finpay-app/templates/serviceaccount.yaml`

**Issue:**
No ServiceAccount resources are defined in the Helm chart templates. The deployments reference IAM role ARNs but don't create the required ServiceAccount objects to use IRSA.

**Required ServiceAccounts:**
1. `payment-api` - for payment-api deployment
2. `payment-worker` - for payment-worker deployment

**Fix Required:**
Create `k8s/finpay-app/templates/serviceaccount.yaml` with:
```yaml
apiVersion: v1
kind: ServiceAccount
metadata:
  name: payment-api
  namespace: {{ .Values.global.namespace }}
  labels:
    {{- include "finpay.labels" . | nindent 4 }}
  annotations:
    eks.amazonaws.com/role-arn: {{ .Values.iam.paymentApiRoleArn }}
---
apiVersion: v1
kind: ServiceAccount
metadata:
  name: payment-worker
  namespace: {{ .Values.global.namespace }}
  labels:
    {{- include "finpay.labels" . | nindent 4 }}
  annotations:
    eks.amazonaws.com/role-arn: {{ .Values.iam.paymentWorkerRoleArn }}
```

---

## Medium Priority Issues (P2 - Inconsistencies)

### 6. Missing startupProbe for payment-worker
**Severity:** MEDIUM
**Impact:** Slow startup may cause premature health check failures
**File:** `k8s/finpay-app/templates/payment-worker-deployment.yaml`

**Issue:**
The payment-api deployment includes a `startupProbe` (lines 98-104) but payment-worker does not. This creates an inconsistency and payment-worker may be killed by readiness/liveness probes during slow startup.

**Current payment-api configuration:**
```yaml
startupProbe:
  httpGet:
    path: /actuator/health
    port: 8080
  periodSeconds: 5
  timeoutSeconds: 3
  failureThreshold: 30  # Allows up to 150 seconds for startup
```

**Fix Required:**
Add startupProbe to payment-worker-deployment.yaml after the readinessProbe section:
```yaml
startupProbe:
  httpGet:
    path: /actuator/health
    port: 8090
  periodSeconds: 5
  timeoutSeconds: 3
  failureThreshold: 30
```

---

### 7. Empty Database Credentials in values.yaml
**Severity:** MEDIUM (INFO)
**Impact:** Deployment will fail without --set overrides
**File:** `k8s/finpay-app/values.yaml:70-71`

**Current Configuration:**
```yaml
secret:
  dbUser: ""
  dbPassword: ""
```

**Issue:**
While the deployed secret in the cluster contains proper credentials (they were likely set via `--set` or external secrets), the default values.yaml has empty strings which would cause failures if deployed as-is.

**Note:** The deployed secret contains:
- DB_USER: `dbadmin` (base64 encoded)
- DB_PASSWORD: (base64 encoded value present)

**Best Practice:**
1. Document that these values MUST be provided via `--set` during deployment
2. Consider using AWS Secrets Manager or External Secrets Operator for production
3. Add validation to require these values or fail explicitly with helpful error message

**Fix Required (Documentation):**
Add comment in values.yaml:
```yaml
# Secret Configuration
# REQUIRED: Set via --set secret.dbUser=xxx --set secret.dbPassword=xxx
# Or use AWS Secrets Manager / External Secrets Operator
secret:
  dbUser: ""
  dbPassword: ""
```

---

## Low Priority Issues (P3 - Future Improvements)

### 8. Empty Certificate ARN for HTTPS
**Severity:** LOW
**Impact:** Ingress will not have HTTPS/TLS enabled
**File:** `k8s/finpay-app/values.yaml:59`

**Current Configuration:**
```yaml
ingress:
  host: api.finpay.com
  certificateArn: ""  # Empty
  subnets: ""
```

**Deployed Ingress:**
The ingress has:
- `alb.ingress.kubernetes.io/certificate-arn:` (empty value)
- `alb.ingress.kubernetes.io/listen-ports: '[{"HTTP": 80}, {"HTTPS": 443}]'`
- `alb.ingress.kubernetes.io/ssl-redirect: '443'`

**Issue:**
Without a certificate ARN, the ALB will not be able to terminate HTTPS traffic. The SSL redirect will also fail.

**Fix Required:**
1. Create ACM certificate for `api.finpay.com` in AWS Certificate Manager
2. Update `values-prod.yaml` with the certificate ARN
3. Redeploy the ingress

**Note:** The values-prod.yaml already has subnets configured, just needs certificate ARN.

---

## Deployment Timeline Issues

**Multiple ReplicaSets Detected:**
```
replicaset.apps/payment-api-5784f87875      0  0  0  49m  (original)
replicaset.apps/payment-api-868fd5d5d7      1  1  0  44m  (rollout attempt 1)
replicaset.apps/payment-api-58887dcb46      1  1  0  14m  (rollout attempt 2)
replicaset.apps/payment-api-64654999db      1  1  0  9m   (rollout attempt 3)
```

**Observation:**
Multiple failed rollout attempts suggest the deployment has been updated several times trying to fix issues. The HPA shows "unknown" metrics, likely because no pods are ready to report metrics.

---

## Recommended Fix Order

1. **IMMEDIATE (Fix Critical Errors):**
   - [ ] Fix ConfigMap DB_URL issue (redeploy with correct values)
   - [ ] Verify payment-worker Dockerfile uses JAVA_OPTS correctly
   - [ ] Fix readiness probe path for payment-worker

2. **HIGH PRIORITY (Security):**
   - [ ] Create ServiceAccount resources
   - [ ] Move IAM role annotations to ServiceAccounts
   - [ ] Update deployments to use ServiceAccounts

3. **MEDIUM PRIORITY (Consistency):**
   - [ ] Add startupProbe to payment-worker
   - [ ] Document secret management approach

4. **LOW PRIORITY (Future):**
   - [ ] Add ACM certificate for HTTPS
   - [ ] Clean up old ReplicaSets

---

## Validation Commands

After fixes, run these commands to validate:

```bash
# Check ConfigMap has DB_URL
kubectl get configmap -n prod finpay-config -o yaml | grep DB_URL

# Check pods are running
kubectl get pods -n prod

# Check pod logs
kubectl logs -n prod -l app=payment-api --tail=50
kubectl logs -n prod -l app=payment-worker --tail=50

# Check endpoints are healthy
kubectl get pods -n prod -o wide
# Then exec into a pod and curl:
# curl http://payment-api:8080/actuator/health
# curl http://payment-worker:8090/actuator/health

# Verify IRSA is working (after ServiceAccount fix)
kubectl get sa -n prod payment-api -o yaml | grep eks.amazonaws.com/role-arn
```

---

## Summary

**Total Issues Found:** 8
- Critical (P0): 3
- High (P1): 2
- Medium (P2): 2
- Low (P3): 1

**Primary Blockers:**
1. Missing DB_URL in ConfigMap → payment-api cannot start
2. Java reflection errors → payment-worker crashes
3. Readiness probe failures → no pods ready for traffic

**Estimated Time to Fix:** 2-4 hours (assuming no additional issues in application code/Dockerfiles)
