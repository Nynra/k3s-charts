{{- if .Values.enabled }}{{- if .Values.quotas }}{{- if .Values.quotas.enabled -}}
kind: ResourceQuota
apiVersion: v1
metadata:
  name: "{{- .Values.namespace.name | default .Chart.Name -}}-quotas"
  namespace: {{- .Values.namespace.name | default .Chart.Name | quote }}
  labels:
    # ResourceQuota labels
    {{- if .Values.quotas.labels }}
    {{- toYaml .Values.quotas.labels | nindent 4 }}
    {{- end }}
    # Global labels
    {{- if .Values.global.labels }}
    {{- toYaml .Values.global.labels | nindent 4 }}
    {{- end }}
  annotations:
    # ResourceQuota annotations
    {{- if .Values.quotas.annotations }}
    {{- toYaml .Values.quotas.annotations | nindent 4 }}
    {{- end }}
    # Global annotations
    {{- if .Values.global.annotations }}
    {{- toYaml .Values.global.annotations | nindent 4 }}
    {{- end }}
spec: 
  {{- .Values.quotas.rules | nindent 2 }}
{{- end }}{{- end }}{{- end }}