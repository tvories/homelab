#!/bin/bash

# helm commands to setup nginx-ingress - internal and external
kubectl create namespace nginx-ingress
helm install nginx-ingress-external -f nginx-ingress-external.yml --namespace nginx-ingress stable/nginx-ingress
helm install nginx-ingress-internal -f nginx-ingress-internal.yml --namespace nginx-ingress stable/nginx-ingress