#!/bin/bash
valid=true
for envname in proxy_host_port proxy_user proxy_pwd; do
    value=$(eval echo '$'${envname})
    if [ -z "$value" ]; then
        echo "Variable $envname must be defined"
        valid=false
    fi
done
if ! $valid; then
    exit
fi
stone ${proxy_host_port}/proxy 3128 "Proxy-Authorization: Basic $(echo -n ${proxy_user}:${proxy_pwd} | base64)"
