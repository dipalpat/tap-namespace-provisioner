NAMESPACES=$(yq '.namespaces[].name' testing-scanning/namespaces/desired-namespaces.yaml)


for ns in $NAMESPACES
do
    kubectx tap-sandbox-$ns

    tanzu apps workload apply staged-workload-for-build-update-$ns \
    --git-repo https://github.com/spring-projects/spring-petclinic \
    --git-branch main \
    --build-env BP_JVM_VERSION=17 \
    --type web \
    --annotation autoscaling.knative.dev/minScale=1 \
    --label app.kubernetes.io/part-of=petclinic \
    --label apps.tanzu.vmware.com/has-tests="true" \
    --param clusterBuilder=tiny-jammy \
    --yes

    # tanzu apps workload delete staged-workload-for-build-update-$ns --yes

done