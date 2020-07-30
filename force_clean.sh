#!/bin/bash

PACKAGE=krishchow/provider-aws:latest
NAME=provider-aws
oc delete -f aws_provider.yaml
kubectl crossplane package uninstall --cluster --namespace crossplane-system ${NAME}
helm uninstall crossplane --namespace crossplane-system
oc get crds -o name | grep crossplane | sed 's/.*\///' | xargs -n1 oc get -n crossplane-system -o name | xargs oc patch -n crossplane-system -p '{"metadata":{"finalizers":[]}}' --type=merge
oc get crds -o name | grep crossplane | xargs oc delete
oc get crds -o name | grep oam | xargs oc delete 
kind delete cluster