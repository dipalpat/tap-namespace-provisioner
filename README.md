## Test the Overlay
Before applying, you can review the overlayed values with the following command to make sure everthing looks ok:

```shell
kubectl create secret generic tap-tap-install-values -n tap-install --dry-run=client -o yaml --from-file=values.yaml=<(kubectl get secret tap-tap-install-values -n tap-install -o jsonpath='{.data.values\.yaml}' | base64 -d | ytt -f- -f values-overlay.yaml)
```

Once you are happy with the results, you can apply the overlay with the following command:

```shell
kubectl create secret generic tap-tap-install-values -n tap-install --dry-run=client -o yaml --from-file=values.yaml=<(kubectl get secret tap-tap-install-values -n tap-install -o jsonpath='{.data.values\.yaml}' | base64 -d | ytt -f- -f values-overlay.yaml) | kubectl apply -f-
```
