{{- if .Values.enabled }}{{- if .Values.rbac }}{{- if .Values.rbac.enabled -}}
{{ range .Values.rbac.rolesbinding }}
{{- $cscope := "Role" -}} 
{{- $cbscope := "RoleBinding" -}} 
{{- if .type }}{{- if eq .type "cluster" }}
{{- $cscope = "ClusterRole" -}} 
{{- $cbscope = "ClusterRoleBinding" -}} 
{{- end }}{{- end }}
{{- if .typeRole }}{{- if eq .typeRole "cluster" }}
{{- $cscope = "ClusterRole" -}} 
{{- end }}{{- end }}
---
kind: {{ $cbscope | quote }}
apiVersion: rbac.authorization.k8s.io/v1
metadata:
  name: {{ .id | quote }}
  {{- if ne .type "cluster" }}
  namespace: {{- .namespace | default $.Values.namespace.name | quote }}
  {{- end }}
  labels:
    app.kubernetes.io/name: "{{ .id }}-role"
    # Rbac labels
    {{- if $.Values.rbac.labels }}
    {{- toYaml $.Values.rbac.labels | nindent 4 }}
    {{- end }}
    # Global labels
    {{- if $.Values.global.labels }}
    {{- toYaml $.Values.global.labels | nindent 4 }}
    {{- end }}
  annotations:
    {{- if $.Values.rbac.annotations }}
    {{- toYaml $.Values.rbac.annotations | nindent 4 }}
    {{- end }}
    # Global annotations
    {{- if $.Values.global.annotations }}
    {{- toYaml $.Values.global.annotations | nindent 4 }}
    {{- end }}
roleRef:
  apiGroup: rbac.authorization.k8s.io
  kind: {{ $cscope | quote }}
  name: {{ .role | default "view" | quote }}
subjects:
  {{- toYaml .subjects | nindent 2 }}
{{ end }}
{{- end -}}{{- end -}}{{- end }}