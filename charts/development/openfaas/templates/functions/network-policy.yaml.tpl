{{ if .Values.enabled }}{{ if .Values.networkPolicy.enabled }}
apiVersion: networking.k8s.io/v1
kind: NetworkPolicy
metadata:
  name: {{ .Release.Name }}-functions-network-policy
  namespace: {{ .Values.openfaas.functionNamespace | quote }}
  annotations:
    argocd.argoproj.io/sync-wave: "1"
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
  podSelector: {}
  policyTypes:
    - Ingress
  ingress:
    - from:
        - podSelector: {}
    - from:
        - namespaceSelector:
            matchLabels:
              namespace: {{ .Values.networkPolicy.traefikNamespace | quote }}
          podSelector:
            {{ toYaml .Values.networkPolicy.traefikPodSelector | nindent 12 }}
    - from:
        - namespaceSelector:
            matchLabels:
              namespace: {{ .Release.Namespace }}
          podSelector: {}
  egress:
    - to:
        - namespaceSelector: {}
          podSelector:
            matchLabels:
              k8s-app: kube-dns
      ports:
        - port: 53
          protocol: UDP
    - to:
        - namespaceSelector:
            matchLabels:
              namespace: {{ .Values.networkPolicy.traefikNamespace | quote }}
          podSelector:
            {{ toYaml .Values.networkPolicy.traefikPodSelector | nindent 12 }}
    - to:
        - namespaceSelector:
            matchLabels:
              namespace: {{ .Release.Namespace }}
          podSelector: {}
    - to:
        - podSelector: {}
{{ end }}{{ end }}