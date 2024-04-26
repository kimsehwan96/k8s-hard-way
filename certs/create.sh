rm -rf provisioning
mkdir provisioning
cd provisioning

# Create a CA
openssl genrsa -out ca.key 2048
openssl req -new -key ca.key -out ca.csr --config ../ca.conf
openssl x509 -req -days 365 -extensions v3_ext -extfile ../ca.conf -in ca.csr -signkey ca.key -out ca.crt


openssl genrsa -out admin.key 2048
openssl req -new -key admin.key -out admin.csr --config ../admin.conf
openssl x509 -req -days 365 -in admin.csr -days 365 -extensions v3_ext -extfile ../admin.conf -CA ./ca.crt -CAkey ./ca.key -CAcreateserial -sha256 -out admin.crt

openssl genrsa -out kubelet.key 2048
openssl req -new -key kubelet.key -out kubelet.csr --config ../kubelet.conf
openssl x509 -req -days 365 -in kubelet.csr -days 365 -extensions v3_ext -extfile ../kubelet.conf -CA ./ca.crt -CAkey ./ca.key -CAcreateserial -sha256 -out kubelet.crt

openssl genrsa -out controller-manager.key 2048
openssl req -new -key controller-manager.key -out controller-manager.csr --config ../controller-manager.conf
openssl x509 -req -days 365 -in controller-manager.csr -days 365 -extensions v3_ext -extfile ../controller-manager.conf -CA ./ca.crt -CAkey ./ca.key -CAcreateserial -sha256 -out controller-manager.crt

openssl genrsa -out scheduler.key 2048
openssl req -new -key scheduler.key -out scheduler.csr --config ../scheduler.conf
openssl x509 -req -days 365 -in scheduler.csr -days 365 -extensions v3_ext -extfile ../scheduler.conf -CA ./ca.crt -CAkey ./ca.key -CAcreateserial -sha256 -out scheduler.crt

openssl genrsa -out apiserver.key 2048
openssl req -new -key apiserver.key -out apiserver.csr --config ../apiserver.conf
openssl x509 -req -days 365 -in apiserver.csr -days 365 -extensions v3_ext -extfile ../apiserver.conf -CA ./ca.crt -CAkey ./ca.key -CAcreateserial -sha256 -out apiserver.crt

openssl genrsa -out apiserver-kubelet-client.key 2048
openssl req -new -key apiserver-kubelet-client.key -out apiserver-kubelet-client.csr --config ../apiserver-kubelet-client.conf
openssl x509 -req -days 365 -in apiserver-kubelet-client.csr -days 365 -extensions v3_ext -extfile ../apiserver-kubelet-client.conf -CA ./ca.crt -CAkey ./ca.key -CAcreateserial -sha256 -out apiserver-kubelet-client.crt

openssl genrsa -out service-accounts.key 2048
openssl req -new -key service-accounts.key -out service-accounts.csr --config ../service-accounts.conf
openssl x509 -req -days 365 -in service-accounts.csr -days 365 -extensions v3_ext -extfile ../service-accounts.conf -CA ./ca.crt -CAkey ./ca.key -CAcreateserial -sha256 -out service-accounts.crt

kubectl config set-cluster hard --certificate-authority=ca.crt --embed-certs=true --server=https://127.0.0.1:6443 --kubeconfig=./controller-manager.kubeconfig
kubectl config set-credentials system:kube-controller-manager --client-certificate=controller-manager.crt --client-key=controller-manager.key --embed-certs=true --kubeconfig=./controller-manager.kubeconfig
kubectl config set-context default --cluster=hard --user=system:kube-controller-manager --kubeconfig=./controller-manager.kubeconfig
kubectl config use-context default --kubeconfig=./controller-manager.kubeconfig

kubectl config set-cluster hard --certificate-authority=ca.crt --embed-certs=true --server=https://127.0.0.1:6443 --kubeconfig=./scheduler.kubeconfig
kubectl config set-credentials system:kube-scheduler --client-certificate=scheduler.crt --client-key=scheduler.key --embed-certs=true --kubeconfig=./scheduler.kubeconfig
kubectl config set-context default --cluster=hard --user=system:kube-scheduler --kubeconfig=./scheduler.kubeconfig
kubectl config use-context default --kubeconfig=./scheduler.kubeconfig

kubectl config set-cluster hard --certificate-authority=ca.crt --embed-certs=true --server=https://127.0.0.1:6443 --kubeconfig=./admin.kubeconfig
kubectl config set-credentials kubernetes-admin --client-certificate=admin.crt --client-key=admin.key --embed-certs=true --kubeconfig=./admin.kubeconfig
kubectl config set-context default --cluster=hard --user=kubernetes-admin --kubeconfig=./admin.kubeconfig
kubectl config use-context default --kubeconfig=./admin.kubeconfig

kubectl config set-cluster hard --certificate-authority=ca.crt --embed-certs=true --server=https://127.0.0.1:6443 --kubeconfig=./kubelet.kubeconfig
kubectl config set-credentials system:node:control1 --client-certificate=kubelet.crt --client-key=kubelet.key --embed-certs=true --kubeconfig=./kubelet.kubeconfig
kubectl config set-context default --cluster=hard --user=system:node:control1 --kubeconfig=./kubelet.kubeconfig
kubectl config use-context default --kubeconfig=./kubelet.kubeconfig
