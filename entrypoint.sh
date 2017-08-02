#!/bin/sh

mkdir -p ~/.kube
>~/.kube/config cat <<EOF
apiVersion: v1
kind: Config
clusters:
- cluster:
    api-version: v1
    server: $KUBECFG_SERVER
  name: "dev"
contexts:
- context:
    cluster: "dev"
    user: "dev"
  name: "dev"
current-context: "dev"
users:
- name: "dev"
  user:
    username: $KUBECFG_USERNAME
    password: $KUBECFG_PASSWORD
