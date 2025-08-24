{{- if .Values.dashboard.enabled }}
apiVersion: traefik.io/v1alpha1
kind: IngressRoute
metadata:
  name: kubecost-ingress
  namespace: {{ .Release.Namespace | quote }}
  annotations:
    kubernetes.io/ingress.class: traefik-external
spec:
  entryPoints:
    - websecure
  routes:
    - match: Host(`{{ .Values.dashboard.kubeviewIngressUrl }}`)
      kind: Rule
      middlewares:
        {{- range .Values.dashboard.middlewares }}
        - name: {{ .name }}
          namespace: {{ .namespace }}
        {{- end }}
      services:
        - name: kubecost-server
          port: 443
  tls:
    secretName: kubecost-dashboard-tls
{{- end }}