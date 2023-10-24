> **&#9432; IMPORTANT**
> 
> Before you follow any of these procedures, make sure to take a backup copy of the TAP install values secret so that you can reset everything to defaults if something gets misconfigured.  You can do this with the following command:
```shell
kubectl get secret tap-tap-install-values -n tap-install -o yaml > tap-sandbox-backup.yaml
```

## Test the Overlay
Before applying, you can review the overlayed values with the following command to make sure everthing looks ok:

```shell
kubectl create secret generic tap-tap-install-values -n tap-install --dry-run=client -o yaml --from-file=values.yaml=<(kubectl get secret tap-tap-install-values -n tap-install -o jsonpath='{.data.values\.yaml}' | base64 -d | ytt -f- -f values-overlay.yaml)
```

Once you are happy with the results, you can apply the overlay with the following command:

```shell
kubectl create secret generic tap-tap-install-values -n tap-install --dry-run=client -o yaml --from-file=values.yaml=<(kubectl get secret tap-tap-install-values -n tap-install -o jsonpath='{.data.values\.yaml}' | base64 -d | ytt -f- -f values-overlay.yaml) | kubectl apply -f-
```
