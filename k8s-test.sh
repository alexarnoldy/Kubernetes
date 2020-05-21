#!/bin/bash

## Test the successful, automatic formation of a CaaS Platform cluster
## Includes testing a default storage class

. /home/sles/.bashrc

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
    - mountPath: /mnt/rbdvol
      name: rbdvol
  volumes:
  - name: rbdvol
    persistentVolumeClaim:
      claimName: manual-pvc
*EOF*

kubectl exec -it manual-pod -- mount | grep rbd >> /tmp/k8s.txt

sles@hol1289-base:~/tst1/files> vim k8s-test.sh
sles@hol1289-base:~/tst1/files> cat k8s-test.sh
#!/bin/bash

## Test the successful, automatic formation of a CaaS Platform cluster

. /home/sles/.bashrc

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
    - mountPath: /mnt/rbdvol
      name: rbdvol
  volumes:
  - name: rbdvol
    persistentVolumeClaim:
      claimName: manual-pvc
*EOF*

kubectl exec -it manual-pod -- mount | grep rbd >> /tmp/k8s.txt
