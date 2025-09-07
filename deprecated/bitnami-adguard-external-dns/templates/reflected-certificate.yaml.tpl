{{ if .Values.enabled }}{{ if .Values.adguardDashboard.cert.reflectedSecret.enabled }}
apiVersion: v1
kind: Secret
metadata:
  name: adguard-dashboard-tls
  namespace: {{ .Release.Namespace | quote }}
  annotations:
    argocd.argoproj.io/sync-wave: "0"
    reflector.v1.k8s.emberstack.com/reflects: "{{ .Values.adguardDashboard.cert.reflectedSecret.originNamespace }}/{{ .Values.adguardDashboard.cert.reflectedSecret.originSecretName }}"
    # Global annotations
    {{- if .Values.global.commonAnnotations }}
      {{- toYaml .Values.global.commonAnnotations | nindent 4 }}
    {{- end }}
  {{- if .Values.global.commonLabels }}
  labels:
    # Global labels
    {{- toYaml .Values.global.commonLabels | nindent 4 }}
  {{- end }}
---
{{ end }}{{ end }}