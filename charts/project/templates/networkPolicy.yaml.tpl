{{- if .Values.enabled }}{{- if .Values.networkpolicy }}{{- if .Values.networkpolicy.enabled -}}
{{ range .Values.networkpolicy.rules }} 
---
kind: NetworkPolicy
apiVersion: networking.k8s.io/v1
metadata:
  name: {{ .id | quote }}
  namespace: {{- .Values.namespace.name | default .Chart.Name | quote }}
  labels:
    app.kubernetes.io/name: "{{ .id }}-networkpolicy"
    # NetworkPolicy labels
    {{- if $.Values.networkpolicy.labels }}
    {{- toYaml $.Values.networkpolicy.labels | nindent 4 }}
    {{- end }}
    # Global labels
    {{- if $.Values.global.labels }}
    {{- toYaml $.Values.global.labels | nindent 4 }}
    {{- end }}
  annotations:
    {{- if $.Values.networkpolicy.annotations }}
    {{- toYaml $.Values.networkpolicy.annotations | nindent 4 }}
    {{- end }}
    # Global annotations
    {{- if $.Values.global.annotations }}
    {{- toYaml $.Values.global.annotations | nindent 4 }}
    {{- end }}
spec: 
  {{- .spec | nindent 2 }}
{{ end }}
{{- end }}{{- end }}{{- end }}