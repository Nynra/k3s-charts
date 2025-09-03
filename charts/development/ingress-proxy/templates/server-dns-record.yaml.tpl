{{- if .Values.enabled }}{{- if .Values.dns-record.enabled }}
apiVersion: externaldns.k8s.io/v1alpha1
kind: DNSEndpoint
metadata:
  name: "{{ .Release.Name }}-dns-record"
  annotations:
    argocd.argoproj.io/sync-wave: "0"
    {{- if .Values.global.commonAnnotations }} 
    {{- toYaml .Values.global.commonAnnotations | nindent 4 }} 
    {{- end }}
    {{- if .Values.dns-record.annotations }}
    {{- toYaml .Values.dns-record.annotations | nindent 4 }}
    {{- end }}
  {{- if or .Values.dns-record.labels .Values.global.commonLabels }}
  labels:
    {{- if .Values.global.commonLabels }} 
    {{- toYaml .Values.global.commonLabels | nindent 4 }} 
    {{- end }}
    {{- if .Values.dns-record.labels }}
    {{- toYaml .Values.dns-record.labels | nindent 4 }}
    {{- end }}
  {{- end }}
spec:
  endpoints:
  - dnsName: {{ .Values.dns-record.url | quote }}
    recordTTL: {{ .Values.dns-record.recordTTL | quote }}
    recordType: A
    targets:
    - {{ .Values.external-server.ip | quote }}
{{- end }}{{- end }}