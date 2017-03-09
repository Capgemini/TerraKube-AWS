## Prereq: add these flags to your kube-apiserver pod
#--oidc-issuer-url=https://dex.capgemini-demo.com # No port required as using type LoadBalancer
#--oidc-client-id=example-app
#--oidc-ca-file=/etc/ssl/kubernetes/ca.pem
#--oidc-username-claim=email
#--oidc-groups-claim=groups

GITHUB_CLIENT_ID=BAR
GITHUB_CLIENT_SECRET=BAZ

kubectl create secret tls dex.capgemini-demo.com.tls --cert=Certs/dex.pem --key=Certs/dexkey.pem

kubectl create secret \
    generic github-client \
    --from-literal=client-id=$GITHUB_CLIENT_ID \
    --from-literal=client-secret=$GITHUB_CLIENT_SECRET

kubectl create -f Kubedemo/Dex/dex.yaml
