export TRY_HOST=*.nasa.gov
envsubst < ingress-single-with-host.yaml | kubectl apply -f -
