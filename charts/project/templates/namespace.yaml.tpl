{{- if .Values.enabled }}{{- if .Values.namespace.enabled }}
kind: Namespace
apiVersion: v1
metadata:
  name: {{ .Values.namespace.name | default .Chart.Name | quote }}
  labels: 
    # Namespace labels
    {{- if .Values.namespace.commonLabels }}
    {{- toYaml .Values.namespace.commonLabels | nindent 4 }}
    {{- end }}
    # Global labels
    {{- if .Values.global.commonLabels }}
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
    # Namespace annotations
    {{- if .Values.namespace.commonAnnotations }}
    {{- toYaml .Values.namespace.commonAnnotations | nindent 4 }}
    {{- end }}
    # Global annotations
    {{- if .Values.global.commonAnnotations }}
    {{- toYaml .Values.global.commonAnnotations | nindent 4 }}
    {{- end }}
{{- end }}{{- end }}