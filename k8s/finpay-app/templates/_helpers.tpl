{{- define "finpay.name" -}}
finpay-app
{{- end }}

{{- define "finpay.labels" -}}
app.kubernetes.io/name: {{ include "finpay.name" . }}
app.kubernetes.io/instance: {{ .Release.Name }}
environment: {{ .Values.global.environment }}
{{- end }}
