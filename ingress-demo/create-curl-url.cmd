export HTTP_NODE_PORT=80
export EXT_IP=$(kubectl get nodes -o wide | awk '/control-plane/ {print$6}')
export INGRESS_URL=http://$EXT_IP:$HTTP_NODE_PORT
