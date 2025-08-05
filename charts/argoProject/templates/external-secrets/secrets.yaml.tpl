{{- .Values.enabled }}{{- if .Values.externalsecrets.enabled }}{{- if .Values.externalSecrets.enableSecrets }}
{{- $remoteSecretName := .Values.externalsecrets.remoteSecretName | quote }}
{{- range .Values.externalsecrets.secrets }}
apiVersion: external-secrets.io/v1
kind: ExternalSecret
metadata:
  name: {{ .name }}
  namespace: {{ .namespace | default $.Values.namespace.name }}
  annotations:
    argocd.argoproj.io/sync-wave: "1"
    # Individual annotations for the secret
    {{- if .annotations }}
    {{- toYaml .annotations | indent 4 }}
    {{- end }}
    # Cert annotations
    {{- if $.Values.externalSecrets.annotations }}
    {{ toYaml $.Values.externalSecrets.annotations | indent 4 }}
    {{- end }}
    # Global annotations
    {{- if $.Values.global.annotations }}
    {{ toYaml $.Values.global.annotations | indent 4 }}
    {{- end }}
  labels:
    # Individual labels for the secret
    {{- if .labels }}
    {{- toYaml .labels | indent 4 }}
    {{- end }}
    # Cert labels
    {{- if $.Values.externalSecrets.labels }}
    {{ toYaml $.Values.externalSecrets.labels | indent 4 }}
    {{- end }}
    # Global labels
    {{- if $.Values.global.labels }}
    {{ toYaml $.Values.global.labels | indent 4 }}
    {{- end }}
spec:
  secretStoreRef:
    kind: {{ .secretstore.kind | default "SecretStore" }}
    name: {{ .secretstore.name | quote }}
  target:
    creationPolicy: Owner
  data:
    {{- range .fieldMappings}}
    - secretKey: {{ .secretKey | quote }}
      remoteRef:
        key: {{ $remoteSecretName | quote }}
        property: {{ .remoteField | default "password" | quote }}
        conversionStrategy: Default	
        decodingStrategy: None
        metadataPolicy: None
    {{- end }}
{{- end }}
{{- end }}{{- end }}{{- end }}