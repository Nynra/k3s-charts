{{ if .Values.enabled }}{{ if .Values.networkPolicy.enabled }}
apiVersion: networking.k8s.io/v1
kind: NetworkPolicy
metadata:
  name: {{ .Release.Name }}-network-policy
  namespace: {{ .Release.Namespace | quote }}
spec:
  podSelector: {}
  policyTypes:
    - Ingress
    - Egress
  ingress:
    # In namespace traffic
    - from:
        - podSelector: {}
    # Traefik pods
    - from:
        - namespaceSelector:
            matchLabels:
              namespace: {{ .Values.networkPolicy.ingress.traefikNamespace | quote }}
          podSelector: {{ toYaml .Values.networkPolicy.ingress.traefikPodSelector | nindent 12 }}
      ports:
        - port: 8000

  egress:
    # In namespace traffic
    - to:
        - podSelector: {}
    # Traefik pods
    - to:
        - namespaceSelector:
            matchLabels:
              namespace: {{ .Values.networkPolicy.ingress.traefikNamespace | quote }}
          podSelector: {{ toYaml .Values.networkPolicy.ingress.traefikPodSelector | nindent 12 }}
    # Kubernetes namespace
    - to:
        - namespaceSelector:
            matchLabels:
              kubernetes.io/metadata.name: default
      ports:
        - port: 6443
          protocol: TCP
{{ end }}{{ end }}
