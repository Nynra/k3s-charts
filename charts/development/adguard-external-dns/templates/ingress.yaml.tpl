{{- if .Values.enabled }}{{- if .Values.adguardDashboard.enabled }}
apiVersion: traefik.io/v1alpha1
kind: IngressRoute
metadata:
  name: adguard-dashboard
  namespace: {{ .Release.Namespace | quote }}
  annotations:
    kubernetes.io/ingress.class: traefik-external
    argocd.argoproj.io/sync-wave: "3"
    # Global annotations
    {{- if .Values.global.commonAnnotations }}
    {{- toYaml .Values.global.commonAnnotations | nindent 4 }}
    {{- end }}
  {{- if .Values.global.commonLabels }}
  labels:
    # Global labels
    {{- toYaml .Values.global.commonLabels | nindent 4 }}
  {{- end }}
spec:
  entryPoints:
    - {{ .Values.adguardDashboard.entrypoint | quote }}
  routes:
    - match: Host(`{{ .Values.adguardDashboard.ingressUrl }}`)
      kind: Rule
      {{- if .Values.adguardDashboard.middlewares }}
      middlewares:
        {{- range .Values.adguardDashboard.middlewares }}
        - name: {{ .name | quote }}
          {{- if .namespace }}
          namespace: {{ .namespace | quote }}
          {{- end }}
        {{- end }}
      {{- end }}
      services:
        - name: "main"
          port: 10232
  tls:
    secretName: adguard-dashboard-tls
{{- end }}{{- end }}