{{- define "appset.metadata" -}}
  metadata:
    name: {{ .name }}
    namespace: {{ .namespace }}
    labels:
      app.kubernetes.io/name: {{ .name }}
      app.kubernetes.io/instance: {{ .name }}
      app.kubernetes.io/managed-by: {{ .managedBy }}
      app.kubernetes.io/part-of: {{ .partOf }}
      app.kubernetes.io/version: {{ .version }}
{{- end -}}

{{- define ""}}