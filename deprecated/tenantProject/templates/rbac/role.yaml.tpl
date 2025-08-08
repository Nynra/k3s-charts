{{- if .Values.enabled }}{{- if .Values.rbac }}{{- if .Values.rbac.enabled -}}
{{ range .Values.rbac.roles }}
{{- $cscope := "Role" -}} 
{{- if .type }}{{- if eq .type "cluster" }}
{{- $cscope = "ClusterRole" -}} 
{{- end }}{{- end }}
--- 
kind: {{ $cscope | quote }}
apiVersion: rbac.authorization.k8s.io/v1
metadata:
  name: {{ .id | quote }}
  {{- if ne .type "cluster" }}
  namespace: {{- .namespace | default .Chart.Name | quote }}
  {{- end }}
  labels:
    app.kubernetes.io/name: "{{ .id }}-role"
    # Global labels
    {{- if $.Values.global.labels }}
    {{- toYaml $.Values.global.labels | nindent 4 }}
    {{- end }}
  annotations:
    # Global annotations
    {{- if $.Values.global.annotations }}
    {{- toYaml $.Values.global.annotations | nindent 4 }}
    {{- end }}
rules:
  {{- toYaml .rules | nindent 2 }}
{{ end }}
{{- end -}}{{- end -}}{{- end }}