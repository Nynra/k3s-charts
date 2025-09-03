# Adguard External DNS

This chart contains the external-dns subchart with the adguard provider. The chart is configured to use traefik proxy instead of ingress.

## CRD usage

<https://dev.to/suin/automated-dns-record-management-for-kubernetes-resources-using-external-dns-and-aws-route53-cnm>

```yaml
apiVersion: externaldns.k8s.io/v1alpha1
kind: DNSEndpoint
metadata:
  name: test.example-tutorial.com
  # annotations: # Annotation filters
  # labels: # Label filters
spec:
  endpoints:
  - dnsName: test.example-tutorial.com
    recordTTL: 180
    recordType: A
    targets:
    - 127.0.0.1
```
