{{- .Values.enabled }}{{- if .Values.externalsecrets.enabled }}{{- if .Values.externalSecrets.enableCertificates }}
{{- range .Values.externalsecrets.certificates }}
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
    {{- if $.Values.externalCertificates.annotations }}
    {{ toYaml $.Values.externalCertificates.annotations | indent 4 }}
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
    {{- if $.Values.externalCertificates.labels }}
    {{ toYaml $.Values.externalCertificates.labels | indent 4 }}
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
    - secretKey: tls.crt
      remoteRef:
        key: {{ .remoteSecret.name | quote }}
        property: {{ .remoteSecret.crtField | default "tls_crt" | quote }}
        conversionStrategy: Default	
        decodingStrategy: None
        metadataPolicy: None
    - secretKey: tls.key
      remoteRef:
        key: {{ .remoteSecret.name | quote }}
        property: {{ .remoteSecret.keyField | default "tls_key" | quote }}
        conversionStrategy: Default	
        decodingStrategy: None
        metadataPolicy: None
{{- end }}
{{- end }}{{- end }}{{- end }}