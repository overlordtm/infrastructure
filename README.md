# sledilnik infrastructure

## Obtain KUBECONFIG

```
scp -o StrictHostKeyChecking=no -o UserKnownHostsFile=/dev/null root@sledilnik.rtfm.si:/etc/rancher/k3s/k3s.yaml sledilnik-k8s.yml
sed -i 's/127\.0\.0\.1/sledilnik\.rtfm\.si/' sledilnik-k8s.yml
export KUBECONFIG=$(pwd)/sledilnik-k8s.yml
kubectl get nodes
```

## Get kubernetes dashboard

Get auth token
```
kubectl -n kubernetes-dashboard describe secret admin-user-token | grep ^token
```

Run proxy
```
kubectl proxy
```

Open
http://localhost:8001/api/v1/namespaces/kubernetes-dashboard/services/https:kubernetes-dashboard:/proxy/

## Get treafik dashboard

```
kubectl port-forward $(kubectl get pods --selector "app.kubernetes.io/name=traefik" --output=name) 9000:9000
```

Open

http://localhost:9000/dashboard/