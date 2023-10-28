> **&#9432; IMPORTANT**
> 
> Before you follow any of these procedures, make sure to take a backup copy of the TAP install values secret so that you can reset everything to defaults if something gets misconfigured.  You can do this with the following command:

Download Developer and Admin Kubeconfig from TAP Sandbox Portal and ensure they are in Downloads folder
```shell
cp ~/Downloads/config ~/.kube/config
kubectx tap-sandbox
./backup-tap-values.sh
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
## Assign Build Service Admin Role
To assign build service admin role to developer scoped service account, follow the steps in this section. The addtional role will allow users to create/edit/delete stacks and builders for both cluster and namespace scope.

Once TAP install is reconciled, run the setup.sh script to create rolebindings, service accounts, secrets and kubeconfigs for attendees. Kubeconfigs are created within the ./kubeconfigs folder. 

```shell
./setup.sh
```
## Install TBS Full Dependencies
To install TBS Full Dependencies, set environment variables before running ./install-tbs-full-deps.sh. In the values-overlay.yaml, set the exclude_dependencies to true if installing TBS Full dependencies and applying the overlay before running these steps.
```shell
export REGISTRY_URL=
export REGISTRY_USER=
export REGISTRY_PASSWORD=
export TBS_FULLDEP_VERSION=1.6.3
./install-tbs-full-deps.sh
```