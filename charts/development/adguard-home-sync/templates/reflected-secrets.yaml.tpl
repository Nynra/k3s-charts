{{ if .Values.enabled }}
{{ if .Values.origin.reflectedSecret.enabled }}
apiVersion: v1
kind: Secret
metadata:
  name: {{ .Values.origin.secretName | quote }}
  namespace: {{ .Release.Namespace | quote }}
  annotations:
    argocd.argoproj.io/sync-wave: "1"
    reflector.v1.k8s.emberstack.com/reflects: "{{ .Values.origin.reflectedSecret.originNamespace }}/{{ .Values.origin.reflectedSecret.originSecretName }}"
    # Global annotations
    {{- if .Values.global.commonAnnotations }}
      {{- toYaml .Values.global.commonAnnotations | nindent 4 }}
    {{- end }}
  {{- if .Values.global.commonLabels }}
  labels:
    # Global labels
    {{- toYaml .Values.global.commonLabels | nindent 4 }}
  {{- end }}
---
{{ end }}
{{ if .Values.origin.reflectedSecret.enabled }}
apiVersion: v1
kind: Secret
metadata:
  name: {{ .Values.replica.secretName | quote }}
  namespace: {{ .Release.Namespace | quote }}
  annotations:
    argocd.argoproj.io/sync-wave: "0"
    reflector.v1.k8s.emberstack.com/reflects: "{{ .Values.replica.reflectedSecret.originNamespace }}/{{ .Values.replica.reflectedSecret.originSecretName }}"
    # Global annotations
    {{- if .Values.global.commonAnnotations }}
      {{- toYaml .Values.global.commonAnnotations | nindent 4 }}
    {{- end }}
  {{- if .Values.global.commonLabels }}
  labels:
    # Global labels
    {{- toYaml .Values.global.commonLabels | nindent 4 }}
  {{- end }}
---
{{ end }}
{{ end }}