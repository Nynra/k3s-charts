{{- if .Values.enabled }}{{- if .Values.namespace.enabled }}
apiVersion: v1
kind: Namespace
metadata:
  name: {{ .Values.namespace.name | quote }}
  annotations:
    argocd.argoproj.io/sync-wave: "0"
    # Global annotations
    {{- if .Values.global.commonAnnotations }}
      {{- toYaml .Values.global.commonAnnotations | nindent 4 }}
    {{- end }}
    # Custom annotations
    {{- if .Values.namespace.commonAnnotations }}
    {{- toYaml .Values.namespace.commonAnnotations | nindent 4 }}
    {{- end }}
  labels:
    # Global labels
    {{- if .Values.global.commonLabels }}
      {{- toYaml .Values.global.commonLabels | nindent 4 }}
    {{- end }}
    # Custom labels
    {{- if .Values.namespace.commonLabels }}
    {{- toYaml .Values.namespace.commonLabels | nindent 4 }}
    {{- end }}
{{- end }}{{- end }}