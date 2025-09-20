{{- if .Values.enabled }}{{- if .Values.dashboard.enabled }}
apiVersion: traefik.io/v1alpha1
kind: IngressRoute
metadata:
  name: {{ .Release.Name }}-ingress
  namespace: {{ .Release.Namespace | quote }}
  annotations:
    kubernetes.io/ingress.class: traefik-external
    argocd.argoproj.io/sync-wave: "2"
    {{- if .Values.global.commonAnnotations }}
    # Global annotations
    {{- toYaml .Values.global.commonAnnotations | nindent 4 }}
    {{- end }}
  {{- if .Values.global.commonLabels }}
  labels:
    # Global labels
    {{- toYaml .Values.global.commonLabels | nindent 4 }}
  {{- end }}
spec:
  entryPoints:
    - {{ .Values.dashboard.entrypoint | quote }}
  routes:
    - match: Host(`{{ .Values.dashboard.ingressUrl }}`)
      kind: Rule
      {{- if .Values.dashboard.middlewares }}
      middlewares:
        {{- range .Values.dashboard.middlewares }}
        - name: {{ .name | quote }}
          {{- if .namespace }}
          namespace: {{ .namespace | quote }}
          {{- end }}
        {{- end }}
      {{- end }}
      services:
        - name: {{ .Release.Name }}
          port: {{ .Values.jellyseerr.service.main.port }}
  tls:
    secretName: {{ .Release.Name }}-tls
{{- end }}{{- end }}
