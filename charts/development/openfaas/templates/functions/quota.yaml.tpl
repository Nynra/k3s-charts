{{- if .Values.enabled }}{{- if .Values.functionsQuota.enabled }}
kind: ResourceQuota
apiVersion: v1
metadata:
  name: "{{ .Release.Name }}-functions-quotas"
  namespace: {{ .Values.openfaas.functionNamespace | quote }}
  annotations:
    argocd.argoproj.io/sync-wave: "1"
    {{- if .Values.global.commonAnnotations }}
    # Global annotations
    {{- toYaml .Values.global.commonAnnotations | nindent 4 }}
    {{- end }}
  {{- if .Values.global.commonLabels }}
  labels:
    # Global labels
    {{- toYaml .Values.global.commonLabels | nindent 4 }}
  {{- end }}
spec: 
  {{- .Values.functionsQuota.rules | nindent 2 }}
{{- end }}{{- end }}