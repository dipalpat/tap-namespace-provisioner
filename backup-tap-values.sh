kubectl get secret tap-tap-install-values -n tap-install -o yaml > tap-sandbox-backup.yaml
kubectl get secret tap-tap-install-values -n tap-install -o jsonpath='{.data.values\.yaml}' | base64 -d > tap-sandbox-decoded.yaml