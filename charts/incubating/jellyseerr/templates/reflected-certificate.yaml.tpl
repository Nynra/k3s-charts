{{- if .Values.enabled }}{{- if .Values.dashboard.cert.reflectedSecret.enabled }}
apiVersion: v1
kind: Secret
metadata:
  name: {{ .Release.Name }}-tls
  namespace: {{ .Release.Namespace | quote }}
  annotations:
    argocd.argoproj.io/sync-wave: "1"
    reflector.v1.k8s.emberstack.com/reflects: "{{ .Values.dashboard.cert.reflectedSecret.originNamespace }}/{{ .Values.dashboard.cert.reflectedSecret.originName }}"
    {{- if .Values.global.commonAnnotations }}
    # Global annotations
    {{- toYaml .Values.global.commonAnnotations | nindent 4 }}
    {{- end }}
  {{- if .Values.global.commonLabels }}
  labels:
    # Global labels
    {{- toYaml .Values.global.commonLabels | nindent 4 }}
  {{- end }}
---
{{ end }}{{ end }}