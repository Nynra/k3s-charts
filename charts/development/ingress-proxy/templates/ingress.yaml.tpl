{{- if .Values.enabled }}{{- if .Values.ingress.enabled }}
apiVersion: traefik.io/v1alpha1
kind: IngressRoute
metadata:
  name: "{{ .Release.Name }}-ingress"
  namespace: {{ .Release.Namespace | quote }}
  annotations:
    kubernetes.io/ingress.class: traefik-external
    argocd.argoproj.io/sync-wave: "3"
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
    - {{ .Values.ingress.entrypoint | quote }}
  routes:
    - match: Host(`{{ .Values.ingress.url }}`)
      kind: Rule
      {{- if .Values.ingress.middlewares }}
      middlewares:
        {{- range .Values.ingress.middlewares }}
        - name: {{ .name | quote }}
          {{- if .namespace }}
          namespace: {{ .namespace | quote }}
          {{- end }}
        {{- end }}
      {{- end }}
      services:
        - name: "{{ .Release.Name }}-service"
          port: {{ .Values.external-server.port }}
  tls:
    secretName: adguard-dashboard-tls
{{- end }}{{- end }}