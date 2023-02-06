VERSION=4.2.0
EXT_IP=$(kubectl get nodes -o wide | awk '/control-plane/ {print$6}')
helm install  my-ingresser ingress-nginx/ingress-nginx \
   --version ${VERSION} \
   --set controller.service.externalIPs=\{${EXT_IP}\}

