NAMESPACES=$(yq '.namespaces[].name' desired-namespaces.yaml)

for ns in $NAMESPACES
do
    kubectl -n $ns delete sa $ns-sa
    kubectl -n $ns delete rolebinding $ns-app-operator
    kubectl -n $ns delete rolebinding $ns-app-editor
    kubectl -n $ns delete rolebinding $ns-dev-spring-service-access
    kubectl delete clusterrolebinding $ns-build-service-admin
    kubectl delete secret $ns-sa-secret -n $ns
done