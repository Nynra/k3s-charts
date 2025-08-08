{{- if .Values.enabled }}{{- if .Values.limits }}{{- if .Values.limits.enabled -}}
kind: LimitRange
apiVersion: v1
metadata:
  name: "{{- .Values.appProject.name | default .Chart.Name -}}-limits"
  namespace: {{- .Values.namespace.name | default .Chart.Name | quote }}
  labels:
    app.kubernetes.io/name: "{{- .Values.appProject.name | default .Chart.Name -}}-limits"
    # Global labels
    {{- if .Values.global.labels }}
    {{- toYaml .Values.global.labels | nindent 4 }}
    {{- end }}
  annotations:
    # Global annotations
    {{- if .Values.global.annotations }}
    {{- toYaml .Values.global.annotations | nindent 4 }}
    {{- end }}
spec: 
  {{- .Values.limits.rules | nindent 2 }}
{{- end }}{{- end }}{{- end }}