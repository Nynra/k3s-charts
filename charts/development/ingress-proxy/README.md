# Ingress proxy

Simple helm chart that creates an ingress route to an external server so the backend service is not exposed directly and can use the ingress controller's features like TLS, middlewares, etc.

The helm chart supports exteral-dns entries but the external-dns controller and dns are not part of this chart.