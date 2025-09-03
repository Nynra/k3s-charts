# Adguard DNS sync

A helm chart for syncing Adguard DNS settings between primary and replica instances. The chart expects a secret with the following attributes to be either reflected using the resources in this chart or created manually:

```yaml
ORIGIN_USERNAME
ORIGIN_PASSWORD
ORIGIN_URL
REPLICA_USERNAME
REPLICA_PASSWORD
REPLICA_URL
```
