{{- if .Values.dashboard.enabled }}
apiVersion: traefik.io/v1alpha1
kind: IngressRoute
metadata:
  name: kubecost-ingress
  namespace: {{ .Values.namespace }}
  annotations:
    kubernetes.io/ingress.class: traefik-external
spec:
  entryPoints:
    - websecure
  routes:
    - match: Host(`{{ .Values.dashboard.ingressUrl }}`)
      kind: Rule
      services:
        - name: kubecost-server
          port: 443
  tls:
    secretName: {{ .Values.dashboard.externalCert.name }}
{{- end }}