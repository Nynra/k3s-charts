kind: Namespace
apiVersion: v1
metadata:
  name: {{ .Release.Namespace | quote }}
  {{- if .Values.global.commonLabels }}
  labels:
    # Global labels
    {{- toYaml .Values.global.commonLabels | nindent 4 }}
  {{- end }}
  annotations:
    # Argocd wave
    argocd.argoproj.io/sync-wave: "-10"
    # Helm hook annotations to prevent deletion
    {{- if .Values.namespace.hooked }}
    helm.sh/hook: pre-install,post-delete
    helm.sh/hook-weight: "-10"
    helm.sh/hook-delete-policy: hook-failed
    argocd.argoproj.io/hook: PreSync
    argocd.argoproj.io/hook-delete-policy: HookFailed
    {{- end }}
    # Global annotations
    {{- if .Values.global.commonAnnotations }}
    {{- toYaml .Values.global.commonAnnotations | nindent 4 }}
    {{- end }}
