apiVersion: argoproj.io/v1alpha1
kind: Application
metadata:
  name: kubecost-app
  namespace: {{ .Values.argocd.namespace }}
  annotations:
    argocd.argoproj.io/sync-wave: "1"
spec:
  destination:
    namespace: {{ .Values.namespace }}
    server: https://kubernetes.default.svc
  project: {{ .Values.project }}
  sources:
    - repoURL: https://charts.chaos-mesh.org
      targetRevision: {{ .Values.targetRevision }}
      chart: chaos-mesh
      helm:
        values: |
          {{- toYaml .Values.chaos-mesh | nindent 10 -}}
  syncPolicy:
    automated:
      prune: true
      selfHeal: true