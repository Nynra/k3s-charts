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
    # Global labels
    {{- if $.Values.global.commonLabels }}
    {{- toYaml $.Values.global.commonLabels | nindent 4 }}
    {{- end }}
  annotations:
    {{- if $.Values.networkpolicy.commonAnnotations }}
    {{- toYaml $.Values.networkpolicy.commonAnnotations | nindent 4 }}
    {{- end }}
    # Global annotations
    {{- if $.Values.global.commonAnnotations }}
    {{- toYaml $.Values.global.commonAnnotations | nindent 4 }}
    {{- end }}
spec: 
  {{- .spec | nindent 2 }}
{{ end }}
{{- end }}{{- end }}{{- end }}