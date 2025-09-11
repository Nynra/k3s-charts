{{- if .Values.enabled }}{{- if .Values.dnsRecord.enabled }}
apiVersion: externaldns.k8s.io/v1alpha1
kind: DNSEndpoint
metadata:
  name: "{{ .Release.Name }}-dns-record"
  annotations:
    argocd.argoproj.io/sync-wave: "0"
    {{- if .Values.global.commonAnnotations }} 
    {{- toYaml .Values.global.commonAnnotations | nindent 4 }} 
    {{- end }}
    {{- if .Values.dnsRecord.annotations }}
    {{- toYaml .Values.dnsRecord.annotations | nindent 4 }}
    {{- end }}
  {{- if or .Values.dnsRecord.labels .Values.global.commonLabels }}
  labels:
    {{- if .Values.global.commonLabels }} 
    {{- toYaml .Values.global.commonLabels | nindent 4 }} 
    {{- end }}
    {{- if .Values.dnsRecord.labels }}
    {{- toYaml .Values.dnsRecord.labels | nindent 4 }}
    {{- end }}
  {{- end }}
spec:
  endpoints:
  - dnsName: {{ .Values.externalServer.url | quote }}
    recordTTL: {{ .Values.dnsRecord.recordTTL | quote }}
    recordType: A
    targets:
    - {{ .Values.dnsRecord.ip | quote }}
{{- end }}{{- end }}