# Kubecost

<http://bluelight.co/blog/kubecost-installation-guide>

## Prometheus scraping config

Prometheus needs to be configured to scrape the cost model metrics otherwise kubecost has nothing to display.

<https://medium.com/@lordz.md/running-kubecost-with-custom-prometheus-in-aws-eks-e2f96b88b924>

```yaml
- job_name: kubecost
      honor_labels: true
      scrape_interval: 1m
      scrape_timeout: 10s
      metrics_path: /metrics
      scheme: http
      dns_sd_configs:
      - names:
        - kubecost-cost-analyzer.<namespace-of-your-kubecost>
        type: 'A'
        port: 9003
```
