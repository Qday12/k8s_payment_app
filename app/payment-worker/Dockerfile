# Build
FROM eclipse-temurin:17-jdk-alpine AS builder
WORKDIR /build
RUN apk add --no-cache maven
#   Install Maven
#   eclipse-temurin = official OpenJDK distribution (trusted, maintained by Adoptium)
#   17-jdk = Java 17 with full JDK (needed for compilation)
#   alpine = minimal Linux (~5MB vs ~200MB for Debian)
#   AS builder = names this stage for reference later



# Layered build for faster rebuilds
COPY pom.xml .
#Copy only pom.xml first to leverage Docker layer caching
RUN mvn dependency:go-offline -B
# Download dependencies only (cached)
COPY src ./src
# Now copy the source code


RUN mvn clean package -DskipTests -B && \
    java -Djarmode=layertools -jar target/payment-worker-1.0.0.jar extract --destination extracted
#Build JAR and extract layers
#-DskipTests = tests run in CI, not in Docker build
#-B = batch mode (no interactive prompts)

#java -Djarmode=layertools ... extract = Spring Boot feature that splits JAR into layers:
#dependencies/ - third-party libs (rarely change)
#spring-boot-loader/ - Spring loader (rarely change)
#snapshot-dependencies/ - snapshot libs
#application/ - app code (changes most often)


###############################
#############Runtime###########
###############################
FROM eclipse-temurin:17-jre-alpine AS runtime
#Final image uses JRE not JDK to reduce size (JRE - only runtime)

LABEL org.opencontainers.image.title="payment-worker" \
      org.opencontainers.image.version="1.0.0"

RUN apk upgrade --no-cache && \
    apk add --no-cache curl dumb-init && \
    rm -rf /var/cache/apk/*
#apk upgrade = install security patches
#curl = needed for healthcheck
#dumb-init = proper signal handling (explained below)
#rm -rf /var/cache/apk/* = remove package cache

# Create non-root user
RUN addgroup -g 1001 -S appgroup && \
    adduser -u 1001 -S appuser -G appgroup

WORKDIR /app
COPY --from=builder /build/extracted/dependencies/ ./
COPY --from=builder /build/extracted/spring-boot-loader/ ./
COPY --from=builder /build/extracted/snapshot-dependencies/ ./
COPY --from=builder /build/extracted/application/ ./
#copy all layers from build stage
#dependencies/ - third-party libs  → cached
#spring-boot-loader/ - Spring loader  → cached
#snapshot-dependencies/ - snapshots
#application/ - app code → changes most often


RUN chown -R appuser:appgroup /app

USER appuser:appgroup
#switch to non-root user

EXPOSE 8090

#-XX:+UseContainerSupport = JVM respects container memory limits (not host memory)
#-XX:MaxRAMPercentage=75.0 = use 75% of container's memory limit for heap
#-XX:+ExitOnOutOfMemoryError = crash cleanly on OOM (Kubernetes will restart)
ENV JAVA_OPTS="-XX:+UseContainerSupport -XX:MaxRAMPercentage=75.0 -XX:+ExitOnOutOfMemoryError" \
    PAYMENT_WORKER_PORT="8090" \
    PAYMENT_API_BASE_URL="http://payment-api:8080" \
    WORKER_CPU_LOAD_MS="300"

HEALTHCHECK --interval=30s --timeout=10s --start-period=60s --retries=3 \
    CMD curl -f http://localhost:8090/actuator/health || exit 1

ENTRYPOINT ["dumb-init", "--"]
CMD ["sh", "-c", "exec java $JAVA_OPTS org.springframework.boot.loader.launch.JarLauncher"]
#In Linux, PID 1 has special behavior - ignores signals by default
#dumb-init runs as PID 1 and forwards signals to Java process
#exec replaces shell with Java process
