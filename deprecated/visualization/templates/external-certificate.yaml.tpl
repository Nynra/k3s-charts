{{- if .Values.enabled }}{{- if .Values.dashboard.cert.externalSecret.enabled }}
apiVersion: external-secrets.io/v1
kind: ExternalSecret
metadata:
  name: kubecost-dashboard-tls
  namespace: {{ .Release.Namespace | quote }}
  annotations:
    argocd.argoproj.io/sync-wave: "-4"
    # Global annotations
    {{- if .Values.global.commonAnnotations }}
      {{- toYaml .Values.global.commonAnnotations | nindent 4 }}
    {{- end }}
  {{- if .Values.global.commonLabels }}
  labels:
    # Global labels
    {{- toYaml .Values.global.commonLabels | nindent 4 }}
  {{- end }}
spec:
  secretStoreRef:
    kind: ClusterSecretStore
    name: {{ .Values.dashboard.cert.externalCert.secretStore }}
  target:
    creationPolicy: Owner
  data:
    - secretKey: tls.crt
      remoteRef:
        key: {{ .Values.dashboard.cert.externalCert.secretName | quote }}
        property: tls_crt
        conversionStrategy: Default	
        decodingStrategy: None
        metadataPolicy: None
    - secretKey: tls.key
      remoteRef:
        key: {{ .Values.dashboard.cert.externalCert.secretName | quote }}
        property: tls_key
        conversionStrategy: Default	
        decodingStrategy: None
        metadataPolicy: None
{{- end }}{{- end }}