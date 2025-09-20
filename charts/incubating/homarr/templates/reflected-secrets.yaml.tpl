{{- if .Values.enabled }}
{{- if .Values.oidcClient.reflectedSecret.enabled }}
---
apiVersion: v1
kind: Secret
metadata:
  name: app-homarr-oidc
  namespace: {{ .Release.Namespace | quote }}
  annotations:
    argocd.argoproj.io/sync-wave: "1"
    reflector.v1.k8s.emberstack.com/reflects: "{{ .Values.oidcClient.reflectedSecret.originNamespace }}/{{ .Values.oidcClient.reflectedSecret.originName }}"
    {{- if .Values.global.commonAnnotations }}
    # Global annotations
    {{- toYaml .Values.global.commonAnnotations | nindent 4 }}
    {{- end }}
  {{- if .Values.global.commonLabels }}
  labels:
    # Global labels
    {{- toYaml .Values.global.commonLabels | nindent 4 }}
  {{- end }}
{{ end }} 
{{- if .Values.dbCredentials.reflectedSecret.enabled }}
---
apiVersion: v1
kind: Secret
metadata:
  name: db-credentials
  namespace: {{ .Release.Namespace | quote }}
  annotations:
    argocd.argoproj.io/sync-wave: "1"
    reflector.v1.k8s.emberstack.com/reflects: "{{ .Values.dbCredentials.reflectedSecret.originNamespace }}/{{ .Values.dbCredentials.reflectedSecret.originName }}"
    {{- if .Values.global.commonAnnotations }}
    # Global annotations
    {{- toYaml .Values.global.commonAnnotations | nindent 4 }}
    {{- end }}
  {{- if .Values.global.commonLabels }}
  labels:
    # Global labels
    {{- toYaml .Values.global.commonLabels | nindent 4 }}
  {{- end }}
{{ end }}
{{ end }}