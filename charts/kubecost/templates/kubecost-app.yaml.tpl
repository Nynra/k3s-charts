apiVersion: argoproj.io/v1alpha1
kind: Application
metadata:
  name: kubecost-app
  namespace: {{ .Values.argocd.namespace }}
  annotations:
    argocd.argoproj.io/sync-wave: "1"
spec:
  destination:
    namespace: {{ .Values.namespace }}
    server: https://kubernetes.default.svc
  project: {{ .Values.project }}
  sources:
    - repoURL: https://github.com/Nynra/k3s-charts
      targetRevision: HEAD
      path: charts/kubecost
      helm:
        values: |
          global:
            thanos:
              enabled: false  # Set to true to enable Thanos for long-term storage.
            grafana:
              # We assume kubeprometheusstack is installed, so we disable Grafana here.
              enabled: false
              # Should be http://<grafana-service-name>.<grafana-namespace>.svc
              domainName: {{ .Values.grafana.fqdn }}
              # If kubecost should act as a proxy for grafana (route via internal grafana service)
              proxy: {{ .Values.grafana.proxy }}

            prometheus:
              # We assume kubeprometheusstack is installed, so we disable Prometheus here.
              enabled: false
              # Should be http://<prometheus-service-name>.<prometheus-namespace>.svc:9090
              fqdn: {{ .Values.prometheus.fqdn }}
            platforms:
              ## Set options for deploying with CI/CD tools like Argo CD.
              cicd:
                enabled: false  # Set to true when using affected CI/CD tools for access to the below configuration options.
                skipSanityChecks: false  # If true, skip all sanity/existence checks for resources like Secrets.
            savedReports:
              enabled: {{ .Values.provisionReports.enabled }}
              {{- if .Values.provisionReports.enabled }}
              reports:
                {{- if .Values.provisionReports.dailyReport }}
                - title: "Daily Cost Report"
                  window: "today"
                  aggregateBy: "namespace"
                  chartDisplay: "category"
                  idle: "separate"
                  rate: "cumulative"
                  accumulate: false   # daily resolution
                  filters:            # Ref: https://www.ibm.com/docs/en/kubecost/self-hosted/2.x?topic=filter-parameters-v2
                    - key: "cluster"
                      operator: ":"
                      value: "dev"
                {{- end }}
                {{- if .Values.provisionReports.monthlyReport }}
                - title: "Monthly Cost Report"
                  window: "month"
                  aggregateBy: "controllerKind"
                  chartDisplay: "category"
                  idle: "share"
                  rate: "monthly"
                  accumulate: false
                  filters:              # Ref: https://www.ibm.com/docs/en/kubecost/self-hosted/2.x?topic=filter-parameters-v2
                    - key: "namespace"
                      operator: "!:"
                      value: "kubecost"
                {{- end }}
                {{- if .Values.provisionReports.yearlyReports }}
                - title: "Yearly Cost Report"
                  window: "year"
                  aggregateBy: "service"
                  chartDisplay: "category"
                  idle: "hide"
                  rate: "daily"
                  accumulate: true  # entire window resolution
                  filters: []       # if no filters, specify empty array
                {{- end }}
              {{- else }}
              reports: []  # If no reports are provisioned, specify an empty array.
              {{- end }}

          upgrade:
            toV3: true  # Set to true to upgrade to v3 of Kubecost.

          ingress:
            # Disable chart ingress as we are using TraefikIngress
            enabled: false
          
          reporting:
            productAnalytics: false

          persistentVolume:
            enabled: {{ .Values.persistentVolume.enabled }}
            size: {{ .Values.persistentVolume.size }}
          
          networkCost:
            enabled: {{ .Values.networkCost.enabled }}

          prometheus:
            # We are assuming kubeprometheusstack is installed, so we disable Prometheus here.
            serviceAccounts:
              alertmanager: 
                create: false
              nodeExporter:
                create: false
              server:
                create: false

          # kubecostProductConfigs:
          #   clusterName: {{ .Values.clusterName }}
          #   projectID: {{ .Values.projectID }}  
      
          kubecostFrondend:
            enabled: true
            deployMethod: singlepod  # Ha not supported without enterprise license

            # set to true to set all upstreams to use <service>.<namespace>.svc.cluster.local instead of just <service>.<namespace>
            useDefaultFqdn: true

          kubecostModel:
            # The total number of hours the ETL pipelines will build
            # Set to 0 to disable hourly ETL (recommended for large environments)
            # Must be < prometheus server retention, otherwise empty data may overwrite
            # known-good data
            etlHourlyStoreDurationHours: 49
            # For deploying kubecost in a cluster that does not self-monitor
            etlReadOnlyMode: false

          # grafana:
          #   sidecar:
          #     dashboards:
          #       enabled: {{ .Values.grafana.dashboards.enabled }}
          #       label: {{ .Values.grafana.dashboards.discoveryLabel }} 
  syncPolicy:
    automated:
      prune: true
      selfHeal: true