{{- if .Values.enabled }}{{- if .Values.quotas }}{{- if .Values.quotas.enabled -}}
kind: ResourceQuota
apiVersion: v1
metadata:
  name: "{{- .Values.namespace.name | default .Chart.Name -}}-quotas"
  namespace: {{- .Values.namespace.name | default .Chart.Name | quote }}
  {{- if .Values.global.commonLabels }}
  labels:
    # Global labels
    {{- toYaml .Values.global.commonLabels | nindent 4 }}
  {{- end }}
  annotations:
    # Global annotations
    {{- if .Values.global.annotations }}
    {{- toYaml .Values.global.annotations | nindent 4 }}
    {{- end }}
spec: 
  {{- .Values.quotas.rules | nindent 2 }}
{{- end }}{{- end }}{{- end }}