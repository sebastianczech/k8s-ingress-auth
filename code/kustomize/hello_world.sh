#!/bin/bash
DEMO_HOME=./hello_world
BASE=$DEMO_HOME/base
mkdir -p $BASE

curl -s -o "$BASE/#1.yaml" "https://raw.githubusercontent.com\
/kubernetes-sigs/kustomize\
/master/examples/helloWorld\
/{configMap,deployment,kustomization,service}.yaml"

OVERLAYS=$DEMO_HOME/overlays
mkdir -p $OVERLAYS/staging
mkdir -p $OVERLAYS/production

cat <<'EOF' >$OVERLAYS/staging/kustomization.yaml
namePrefix: staging-
commonLabels:
  variant: staging
  org: acmeCorporation
commonAnnotations:
  note: Hello, I am staging!
resources:
- ../../base
patches:
- path: map.yaml
EOF

cat <<EOF >$OVERLAYS/staging/map.yaml
apiVersion: v1
kind: ConfigMap
metadata:
  name: the-map
data:
  altGreeting: "Have a pineapple!"
  enableRisky: "true"
EOF

cat <<EOF >$OVERLAYS/production/kustomization.yaml
namePrefix: production-
commonLabels:
  variant: production
  org: acmeCorporation
commonAnnotations:
  note: Hello, I am production!
resources:
- ../../base
patches:
- path: deployment.yaml
EOF

cat <<EOF >$OVERLAYS/production/deployment.yaml
apiVersion: apps/v1
kind: Deployment
metadata:
  name: the-deployment
spec:
  replicas: 10
EOF

# diff \
#   <(kustomize build $OVERLAYS/staging) \
#   <(kustomize build $OVERLAYS/production) |\
#   more

kustomize build $OVERLAYS/staging |\
    kubectl apply -f -

kustomize build $OVERLAYS/production |\
   kubectl apply -f -

kubectl get pods,configmap,deploy,service