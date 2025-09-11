{{- if .Values.enabled }}{{- if .Values.gateway.enabled }}
apiVersion: traefik.io/v1alpha1
kind: IngressRoute
metadata:
  name: {{ .Release.Name }}-gateway-ingress
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
    - {{ .Values.gateway.entrypoint | quote }}
  routes:
    - match: Host(`{{ .Values.gateway.ingressUrl }}`)
      kind: Rule
      {{- if .Values.gateway.middlewares }}
      middlewares:
        {{- range .Values.gateway.middlewares }}
        - name: {{ .name | quote }}
          {{- if .namespace }}
          namespace: {{ .namespace | quote }}
          {{- end }}
        {{- end }}
      {{- end }}
      services:
        - name: gateway
          port: 8080
  tls:
    secretName: {{ .Release.Name }}-tls
{{- end }}{{- end }}
