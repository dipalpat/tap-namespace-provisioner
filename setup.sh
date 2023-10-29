
NAMESPACES=$(yq '.namespaces[].name' testing-scanning/namespaces/desired-namespaces.yaml)


for ns in $NAMESPACES
do

    kubectl -n $ns create sa $ns-sa
    kubectl -n $ns create rolebinding $ns-app-operator --clusterrole=app-operator --serviceaccount=$ns:$ns-sa
    kubectl -n $ns create rolebinding $ns-app-editor --clusterrole=app-editor --serviceaccount=$ns:$ns-sa
    kubectl -n $ns create rolebinding $ns-dev-spring-service-access --clusterrole=dev-spring-service-access --serviceaccount=$ns:$ns-sa
    kubectl create clusterrolebinding $ns-build-service-admin --clusterrole=build-service-admin-role --serviceaccount=$ns:$ns-sa

    export NS=$ns
    export SA_NAME=$NS-sa
    export NAME=$NS-sa-secret
    yq e -i '.metadata.namespace = env(NS)' token.yaml 
    yq e -i '.metadata.name = env(NAME)' token.yaml 
    yq e -i '.metadata.annotations."kubernetes.io/service-account.name" = env(SA_NAME)' token.yaml 

    kubectl apply -f token.yaml

    rm kubeconfigs/$ns.yaml
    export TOKEN=$(kubectl -n $ns get secret $NAME -o jsonpath='{.data.token}' | base64 -d)
    cat ~/Downloads/developer_tenant_kubeconfig.yml | sed -e "s/tap-sandbox/tap-sandbox-${NS}/" > kubeconfigs/$NS.yaml
    yq e -i '.users[].user.token = env(TOKEN)' kubeconfigs/$NS.yaml
    yq e -i '.contexts[].context.namespace = env(NS)' kubeconfigs/$NS.yaml 
    
    # echo "CONFIG FOR ATTENDEE - $ns--------------------------------------------------\n\n"
    # echo "CONTEXT_NAME="${CONTEXT_NAME:-developer-sandbox}""
    # echo 'kubectl config set "clusters.${CONTEXT_NAME}.server"' '"'$SERVER'"'
    # echo 'kubectl config set "clusters.${CONTEXT_NAME}.certificate-authority-data"' '"'$CERT'"'
    # echo 'kubectl config set "users.${CONTEXT_NAME}.token"' '"'$TOKEN'"'
    # echo 'kubectl config set "contexts.${CONTEXT_NAME}.user" "${CONTEXT_NAME}"'
    # echo 'kubectl config set "contexts.${CONTEXT_NAME}.cluster" "${CONTEXT_NAME}"'
    # echo 'kubectl config set "contexts.${CONTEXT_NAME}.namespace"' '"'$ns'"'
    # echo 'kubectl config use-context "${CONTEXT_NAME}"'
    # echo "\n\nEND CONFIG FOR ATTENDEE - $ns--------------------------------------------------\n\n"

done
