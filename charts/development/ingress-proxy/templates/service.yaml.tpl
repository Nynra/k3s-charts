{{- if .Values.enabled }}
apiVersion: v1
kind: Service
metadata:
  name: "{{ .Release.Name }}-service"
  namespace: {{ .Release.Namespace | quote }}
  annotations:
    argocd.argoproj.io/sync-wave: "1"
    {{- if .Values.global.commonAnnotations }}
    {{- toYaml .Values.global.commonAnnotations | nindent 4 }}
    {{- end }}
  {{- if .Values.global.commonLabels }}
  labels:
    {{- toYaml .Values.global.commonLabels | nindent 4 }}
  {{- end }}
spec:
  type: ExternalName
  externalName: {{ .Values.externalServer.url }}
{{- end }}