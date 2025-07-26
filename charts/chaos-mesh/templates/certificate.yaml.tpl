{{- if .Values.dashboard.enabled }}
apiVersion: external-secrets.io/v1
kind: ExternalSecret
metadata:
  name: {{ .Values.dashboard.externalCert.name }}
  namespace: {{ .Values.namespace }}
  annotations:
    argocd.argoproj.io/sync-wave: "1"
spec:
  secretStoreRef:
    kind: ClusterSecretStore
    name: {{ .Values.dashboard.externalCert.remoteSecretStore }}
  target:
    creationPolicy: Owner
  data:
    - secretKey: tls.crt
      remoteRef:
        key: {{ .Values.dashboard.externalCert.remoteSecretName | quote }}
        property: tls_crt
        conversionStrategy: Default	
        decodingStrategy: None
        metadataPolicy: None
    - secretKey: tls.key
      remoteRef:
        key: {{ .Values.dashboard.externalCert.remoteSecretName | quote }}
        property: tls_key
        conversionStrategy: Default	
        decodingStrategy: None
        metadataPolicy: None
{{- end }}