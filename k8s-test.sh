
#!/bin/bash

## Test the successful, automatic formation of a Kubernetes cluster

source ${HOME}/.bashrc

kubectl get nodes -o wide > /tmp/k8s.txt
kubectl get pods -A -o wide >> /tmp/k8s.txt
kubectl get sc -o wide >> /tmp/k8s.txt

kubectl apply -f - << *EOF*
kind: PersistentVolumeClaim
apiVersion: v1
metadata:
  name: manual-pvc
spec:
  accessModes:
  - ReadWriteOnce
  resources:
    requests:
      storage: 1Gi
*EOF*

kubectl apply -f - <<*EOF*
apiVersion: v1
kind: Pod
metadata:
  name: manual-pod
spec:
  containers:
  - name: alpine
    image: alpine
    command: ["sleep","3600"]
    volumeMounts:
    - mountPath: /mnt/pvcvol
      name: pvcvol
  volumes:
  - name: pvcvol
    persistentVolumeClaim:
      claimName: manual-pvc
*EOF*

kubectl wait --for=condition=Ready --timeout=30s pod/manual-pod
kubectl exec -it manual-pod -- mount | grep pvcvol >> /tmp/k8s.txt
