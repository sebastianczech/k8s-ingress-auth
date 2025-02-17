# Ingress Nginx controller with authentication

## Prerequisites

1. Create Kubernetes cluster using [`kind`](https://kind.sigs.k8s.io/docs/user/quick-start/):
```bash
task cluster-create
```
2. Configure [ingress](https://kind.sigs.k8s.io/docs/user/ingress)
```bash
task cluster-ingress-setup
```
3. Define DNS names on local machine e.g.:
```
vi /etc/hosts
```
and add 3 FQDNs for `localhost`:
```
127.0.0.1       localhost podtato.example.com podinfo.example.com foobar.example.com
```

## Bearer Token

1. Setup [Kubernetes dashboard](https://kubernetes.io/docs/tasks/access-application-cluster/web-ui-dashboard/):
```bash
task dashboard-ingress-setup
```
2. Access dashboard [https://localhost:8443](https://localhost:8443/#/workloads?namespace=_all)

## OAuth proxy

1. Configure GitHub OAuth application:
![](images/github_oauth_app.png)
2. Provision [OAuth proxy](https://kubernetes.github.io/ingress-nginx/examples/auth/oauth-external-auth/):
```bash
task oauth-proxy-setup
```
3. Create `podinfo` app:
```bash
task app-podinfo-setup
```
4. Check app [https://podinfo.example.com/](https://podinfo.example.com/)

## Basic authentication

1. Provision [Basic authentication](https://kubernetes.github.io/ingress-nginx/examples/auth/basic/)
2. Create `podtato`:
```bash
task app-podtato-setup
```
3. Access app [https://podtato.example.com/](https://podtato.example.com/)

## Client certificate authentication

1. Provision [Client certificate authentication](https://kubernetes.github.io/ingress-nginx/examples/auth/client-certs/)
2. Create `foo-bar` app:
```bash
task app-foo-bar-setup
```
3. Check app [bar](https://foobar.example.com/bar) and [foo](https://foobar.example.com/foo):
```bash
task app-foo-bar-check
```
