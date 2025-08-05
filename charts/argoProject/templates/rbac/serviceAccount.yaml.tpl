{{- if .Values.enabled }}{{- if .Values.serviceAccounts }}{{- if .Values.serviceAccounts.enabled -}}
{{ range .Values.serviceAccounts.list }}
---
kind: ServiceAccount
apiVersion: v1
metadata:
  name: {{ .name | quote }}
  namespace: {{ .namespace | quote }}
  labels:
    app.kubernetes.io/name: "{{ .name }}-sa"
    # Service Account labels
    {{- if $.Values.serviceAccounts.labels }}
    {{- toYaml $.Values.serviceAccounts.labels | nindent 4 }}
    {{- end }}
    # Global labels
    {{- if $.Values.global.labels }}
    {{- toYaml $.Values.global.labels | nindent 4 }}
    {{- end }}
  annotations:
    # Service Account annotations
    {{- if $.Values.serviceAccounts.annotations }}
    {{- toYaml $.Values.serviceAccounts.annotations | nindent 4 }}
    {{- end }}
    # Global annotations
    {{- if $.Values.global.annotations }}
    {{- toYaml $.Values.global.annotations | nindent 4 }}
    {{- end }}
    # Argocd wave
    argocd.argoproj.io/sync-wave: "-15"
{{- if .imagePullSecrets }}
imagePullSecrets:
{{- range .imagePullSecrets }}
  - name: {{ .name }}
    {{- if .namespace }}
    namespace: {{ .namespace | quote }}
    {{- end }}
{{- end }}
{{- end }}

{{ end }}
{{- end -}}{{- end -}}{{- end }}