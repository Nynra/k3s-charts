{{- if .Values.enabled }}{{- if .Values.appProject.enabled }}
{{- $defaultns := .Values.namespace.name | quote }}
apiVersion: argoproj.io/v1alpha1
kind: AppProject
metadata:
  name: {{ .Values.appProject.name | quote }}
  annotations:
    argocd.argoproj.io/sync-wave: "1"
    {{-  if .Values.appProject.hooked }}
    argocd.argoproj.io/hook: PreSync
    argocd.argoproj.io/hook-delete-policy: HookFailed
    {{- end }}
    # Global annotations
    {{- if .Values.global.commonAnnotations }}
    {{- toYaml .Values.global.commonAnnotations | nindent 4 }}
    {{- end }}
  {{- if .Values.global.commonLabels }}
  labels:
    # Global labels
    {{- toYaml .Values.global.commonLabels | nindent 4 }}
  {{- end }}
  finalizers:
    - resources-finalizer.argocd.argoproj.io
spec:
  {{- if .Values.appProject.description }}
  description: {{ .Values.appProject.description | quote }}
  {{- else }}
  description: "Project for {{ .Values.appProject.name }}"
  {{- end }}
  {{- if .Values.appProject.sourceRepos }}
  sourceRepos:
    {{- range .Values.appProject.sourceRepos }}
    - {{ . | quote }}
    {{- end }}
  {{- else }}
  sourceRepos: []
  {{- end }}
  destinations:
    {{- if .Values.appProject.destinations }}
    {{- range .Values.appProject.destinations }}
    - namespace: {{ .Values.namespace | default $defaultns | quote }}
      server: {{ .Values.appProject.server | default "https://kubernetes.default.svc" | quote }}
    {{- end }}
    {{- end }}
  clusterResourceWhitelist:
    {{- if .Values.appProject.resourceWhitelist }}
    {{- range .Values.appProject.resourceWhitelist }}
    - group: {{ .group | quote }}
      kind: {{ .kind | quote }}
    {{- end }}
    {{- else }}
    # Deny all cluster-scoped resources from being created, except for Namespace
    - group: ''
      kind: Namespace
    {{- end }}
  namespaceResourceBlacklist:
    {{- if .Values.appProject.namespaceResourceBlacklist }}
    {{- range .Values.appProject.namespaceResourceBlacklist }}
    - group: {{ .group | quote }}
      kind: {{ .kind | quote }}
    {{- end }}
    {{- else }}
    # Allow all namespaced-scoped resources to be created, except for ResourceQuota, LimitRange, NetworkPolicy
    - group: ''
      kind: ResourceQuota
    - group: ''
      kind: LimitRange
    - group: ''
      kind: NetworkPolicy
    {{- end }}
  {{- if .Values.bootstrapProject.warnOrphanedResources }}
  orphanedResources:
    warn: true
  {{- end }}
{{- end }}{{- end }}
