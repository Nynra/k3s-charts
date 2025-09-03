{{- if .Values.enabled }}{{- if .Values.adguardCredentials.externalSecret.enabled }}
---
apiVersion: external-secrets.io/v1
kind: ExternalSecret
metadata:
  name: adguard-configuration
  namespace: {{ .Release.Namespace | quote }}
  annotations:
    argocd.argoproj.io/sync-wave: "-2"
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
    kind: {{ .Values.adguardCredentials.externalSecret.storeType | quote }}
    name: {{ .Values.adguardCredentials.externalSecret.storeName | quote }} 
  target:
    creationPolicy: Owner
  data: 
    - secretKey: url
      remoteRef:
        key: {{ .Values.adguardCredentials.externalSecret.secretName | quote }}
        property: {{ .Values.adguardCredentials.externalSecret.properties.url | quote }}
    - secretKey: password
      remoteRef:
        key: {{ .Values.adguardCredentials.externalSecret.secretName | quote }}
        property: {{ .Values.adguardCredentials.externalSecret.properties.password | quote }}
    - secretKey: user
      remoteRef:
        key: {{ .Values.adguardCredentials.externalSecret.secretName | quote }}
        property: {{ .Values.adguardCredentials.externalSecret.properties.user | quote }}
{{- end }}{{- end }}