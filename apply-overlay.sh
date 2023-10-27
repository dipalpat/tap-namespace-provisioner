cp ~/Downloads/config ~/.kube/config
kubectx tap-sandbox
kubectl get secret tap-tap-install-values -n tap-install -o yaml > tap-sandbox-backup.yaml
kubectl get secret tap-tap-install-values -n tap-install -o jsonpath='{.data.values\.yaml}' | base64 -d > tap-sandbox-decoded.yaml


$(kubectl create secret generic tap-tap-install-values -n tap-install --dry-run=client -o yaml --from-file=values.yaml=<(kubectl get secret tap-tap-install-values -n tap-install -o jsonpath='{.data.values\.yaml}' | base64 -d | ytt -f- -f testing-scanning/values-overlay.yaml) | kubectl apply -f-)