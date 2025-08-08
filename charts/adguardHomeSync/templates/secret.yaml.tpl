{{- if .Values.enabled }}{{- if .Values.credentials.externalSecret.enabled }}
---
apiVersion: external-secrets.io/v1
kind: ExternalSecret
metadata:
  name: {{ .Values.secretName | quote }}
  namespace: {{ .Release.Namespace | quote }}
  annotations:
    argocd.argoproj.io/sync-wave: "-10"
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
    kind: {{ .Values.externalSecret.storeType | quote }}
    name: {{ .Values.externalSecret.storeName | quote }} 
  target:
    creationPolicy: Owner
  data: 
    - secretKey: ORIGIN_USERNAME
      remoteRef:
        key: {{ .Values.externalSecret.secretName | quote }}
        property: {{ .Values.externalSecret.properties.ORIGIN_USERNAME | quote }}
    - secretKey: ORIGIN_PASSWORD
      remoteRef:
        key: {{ .Values.externalSecret.secretName | quote }}
        property: {{ .Values.externalSecret.properties.ORIGIN_PASSWORD | quote }}
    - secretKey: REPLICA_USERNAME
      remoteRef:
        key: {{ .Values.externalSecret.secretName | quote }}
        property: {{ .Values.externalSecret.properties.REPLICA_USERNAME | quote }}
    - secretKey: REPLICA_PASSWORD
      remoteRef:
        key: {{ .Values.externalSecret.secretName | quote }}
        property: {{ .Values.externalSecret.properties.REPLICA_PASSWORD | quote }}
{{- end }}{{- end }}
