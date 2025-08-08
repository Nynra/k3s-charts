{{- if .Values.enabled }}{{- if .Values.rbac }}{{- if .Values.rbac.enabled -}}
# Groups manifests
{{ range .Values.rbac.groups }}
{{- $cscope := "RoleBinding" -}} 
{{- if .type }}{{- if eq .type "cluster" }}
{{- $cscope = "ClusterRoleBinding" -}} 
{{- end }}{{- end }}
---
kind: {{ $cscope | quote }}
apiVersion: rbac.authorization.k8s.io/v1
metadata:
  name: "{{ .id }}"
  {{- if ne .type "cluster" }}
  namespace: {{- .namespace }}
  {{- end }}
  labels:
    app.kubernetes.io/name: "{{ .id }}-rolebinding"
    # Rbac labels
    {{- if $.Values.rbac.labels }}
    {{- toYaml $.Values.rbac.labels | nindent 4 }}
    {{- end }}
    # Global labels
    {{- if $.Values.global.labels }}
    {{- toYaml $.Values.global.labels | nindent 4 }}
    {{- end }}{{- end }}
  annotations:
    # Rbac annotations
    {{- if $.Values.rbac.annotations }}
    {{- toYaml $.Values.rbac.annotations | nindent 4 }}
    {{- end }}
    # Global annotations
    {{- if $.Values.global.annotations }}
    {{- toYaml $.Values.global.annotations | nindent 4 }}
    {{- end }}{{- end }}
roleRef:
  apiGroup: rbac.authorization.k8s.io
  kind: ClusterRole
  name: {{ .role | default "view" | quote }}
subjects:
  - kind: Group
    apiGroup: rbac.authorization.k8s.io
    name: {{ .name | quote }}
{{ end }}
# User manifests
{{ range .Values.rbac.users }}
{{- $cscope := "RoleBinding" -}} 
{{- if .type }}{{- if eq .type "cluster" }}
{{- $cscope = "ClusterRoleBinding" -}} 
{{- end }}{{- end }}
---
kind: {{ $cscope | quote }}
apiVersion: rbac.authorization.k8s.io/v1
metadata:
  name: {{ .id | quote }}
  {{- if ne .type "cluster" }}
  namespace: {{- .namespace | quote }}
  {{- end }}
  labels:
    app.kubernetes.io/name: "{{ .id }}-rolebinding"
    # Rbac labels
    {{- if $.Values.rbac.labels }}
    {{- toYaml $.Values.rbac.labels | nindent 4 }}
    {{- end }}
    # Global labels
    {{- if $.Values.global.labels }}
    {{- toYaml $.Values.global.labels | nindent 4 }}
    {{- end }}
  annotations:
    # Rbac annotations
    {{- if $.Values.rbac.annotations }}
    {{- toYaml $.Values.rbac.annotations | nindent 4 }}
    {{- end }}
    # Global annotations
    {{- if $.Values.global.annotations }}
    {{- toYaml $.Values.global.annotations | nindent 4 }}
    {{- end }}
roleRef:
  apiGroup: rbac.authorization.k8s.io
  kind: ClusterRole
  name: {{ .role | default "view" | quote }}
subjects:
  - kind: User
    apiGroup: rbac.authorization.k8s.io
    name: {{ .name | quote }}
{{ end }}
# ServiceAccount manifests
{{ range .Values.rbac.sa }}
{{- $cscope := "RoleBinding" -}} 
{{- if .type }}{{- if eq .type "cluster" }}
{{- $cscope = "ClusterRoleBinding" -}} 
{{- end }}{{- end }}
---
kind: {{ $cscope | quote }}
apiVersion: rbac.authorization.k8s.io/v1
metadata:
  name: "{{ .id }}"
  {{- if ne .type "cluster" }}
  namespace: {{- .namespace }}
  {{- end }}
  labels:
    app.kubernetes.io/name: "{{ .id }}-rolebinding"
    # Rbac labels
    {{- if $.Values.rbac.labels }}
    {{- toYaml $.Values.rbac.labels | nindent 4 }}
    {{- end }}
    # Global labels
    {{- if $.Values.global.labels }}
    {{- toYaml $.Values.global.labels | nindent 4 }}
    {{- end }}
  annotations:
    # Rbac annotations
    {{- if $.Values.rbac.annotations }}
    {{- toYaml $.Values.rbac.annotations | nindent 4 }}
    {{- end }}{{- end }}
    # Global annotations
    {{- if $.Values.global.annotations }}
    {{- toYaml $.Values.global.annotations | nindent 4 }}
    {{- end }}{{- end }}
roleRef:
  apiGroup: rbac.authorization.k8s.io
  kind: ClusterRole
  name: {{ .role | default "view" | quote }}
subjects:
  - kind: ServiceAccount
    name: {{ .name | quote }}
    namespace: {{- .namespace }}
{{ end }}
{{- end -}}{{- end -}}{{- end }}