export URL=$(yq '.buildservice.kp_default_repository' tap-sandbox-decoded.yaml)
export REG=${URL%%/*}

echo $(yq '.buildservice.kp_default_repository_password' tap-sandbox-decoded.yaml) | docker login -u _json_key_base64 --password-stdin https://$REG

#9.13.0
# imgpkg copy -i registry.tanzu.vmware.com/tanzu-java-azure-buildpack/java-azure@sha256:4e677d8bfa9ffc0ddc2b4ae11b718b5b2d9f64b06867088ac2be7ed6708ef80d \
# --to-repo $URL/java-azure \
# --include-non-distributable-layers

#9.14.0
imgpkg copy -i registry.tanzu.vmware.com/tanzu-java-azure-buildpack/java-azure@sha256:1b2cabe3290a15928d541e16738d4f7bf85dbd903baa500d833bb14d7e08f082 \
--to-repo $URL/java-azure \
--include-non-distributable-layers

#0.1.66
imgpkg copy -i registry.tanzu.vmware.com/tanzu-tiny-ubuntu-2204-stack/run@sha256:31b28e324950867bcab844bed6b900ad2c92adf27d7e581513b0ff0045a2d229 \
--to-repo $URL/tiny-jammy-run-0.1.66 
--include-non-distributable-layers

imgpkg copy -i registry.tanzu.vmware.com/tanzu-tiny-ubuntu-2204-stack/build@sha256:5da8db6f735aad7fc10c616ba0e4e1a54254f1beeb0f3a8f1a5346edccde9a96 \
--to-repo $URL/tiny-jammy-build-0.1.66 \
--include-non-distributable-layers

#0.1.65
imgpkg copy -i registry.tanzu.vmware.com/tanzu-tiny-ubuntu-2204-stack/run@sha256:4b16594e4bbb9e3ced98e2b846bad9964ef4e2ace77934d5bce1a15cac9b0bc8 \
--to-repo $URL/tiny-jammy-run-0.1.65 \
--include-non-distributable-layers

imgpkg copy -i registry.tanzu.vmware.com/tanzu-tiny-ubuntu-2204-stack/build@sha256:b020931822972b01f7b1a49ede270f0d4763f0bdceaea41a1986662e68cf6427 \
--to-repo $URL/tiny-jammy-build-0.1.65 \
--include-non-distributable-layers