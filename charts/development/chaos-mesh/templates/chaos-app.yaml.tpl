{{- if .Values.enabled }}{{- if .Values.enableChaosMesh }}
apiVersion: argoproj.io/v1alpha1
kind: Application
metadata:
  name: kubecost-app
  namespace: {{ .Values.argocd.namespace | quote }}
  annotations:
    argocd.argoproj.io/sync-wave: "1"
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
  destination:
    namespace: {{ .Values.namespace.name | quote }}
    server: https://kubernetes.default.svc
  project: {{ .Values.project.name | quote }}
  sources:
    - repoURL: https://charts.chaos-mesh.org
      targetRevision: {{ .Values.chaosMeshTargetRevision | quote }}
      chart: chaos-mesh
      helm:
        values: |
          {{- toYaml .Values.chaos-mesh | nindent 10 -}}
  syncPolicy:
    syncOptions:
      - CreateNamespace=false
    automated:
      prune: true
      selfHeal: true
{{- end }}{{- end }}