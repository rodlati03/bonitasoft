# bonitasoft
this is a repo after being challenged
# create namesapce bonita-ns before applying kube conponents
kubectl create namespace bonita-ns


# after applied kube conponents, check the address ingress ==> bonita.grenoble
curl --resolve "bonita.grenoble:80:$( minikube ip )" -i http://bonita.grenoble/bonita/
