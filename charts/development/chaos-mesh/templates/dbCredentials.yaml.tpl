{{- if .Values.enabled }}{{- if .Values.enableExternalSecrets }}
apiVersion: external-secrets.io/v1
kind: ExternalSecret
metadata:
  name: {{ .Values.chaos-mesh.dashboard.databaseSecretName | quote }}
  namespace: {{ .Values.namespace.name | quote }}
  annotations:
    argocd.argoproj.io/sync-wave: "-10"
    # Global annotations
    {{- if .Values.global.commonAnnotations }}
      {{- toYaml .Values.global.commonAnnotations | nindent 4 }}
    {{- end }}
  labels:
    # Global labels
    {{- if .Values.global.commonLabels }}
      {{- toYaml .Values.global.commonLabels | nindent 4 }}
    {{- end }}
spec:
  secretStoreRef:
    kind: {{ .Values.chaosMeshDbExternalSecret.secretStoreType | quote }}
    name: {{ .Values.chaosMeshDbExternalSecret.secretStore | quote }}
  target:
    creationPolicy: Owner
  data:
    - secretKey: data
      remoteRef:
        key: {{ .Values.chaosMeshDbExternalSecret.secretName | quote }}
        property: {{ .Values.chaosMeshDbExternalSecret.passwordPropertyName | quote }}
{{- end }}{{- end }}
