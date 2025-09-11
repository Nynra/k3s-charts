{{- if .Values.enabled }}{{- if .Values.coreQuota.enabled }}
kind: ResourceQuota
apiVersion: v1
metadata:
  name: "{{ .Release.Name }}-core-quotas"
  namespace: {{ .Release.Namespace | quote }}
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
  {{- .Values.coreQuota.rules | nindent 2 }}
{{- end }}{{- end }}