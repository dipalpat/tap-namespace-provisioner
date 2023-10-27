tanzu secret registry add tbs-full-dependency --username ${REGISTRY_USER} --server ${REGISTRY_URL} --password ${REGISTRY_PASSWORD} -n tap-install --yes --export-to-all-namespaces

tanzu package repository add tanzu-tbs-fulldep --url  ${REGISTRY_URL}/tanzu-application-platform/full-deps-package-repo:${TBS_FULLDEP_VERSION} -n tap-install

tanzu package install full-deps -p full-deps.buildservice.tanzu.vmware.com -v "> 0.0.0" -n tap-install --values-file tap-sandbox-decoded.yaml