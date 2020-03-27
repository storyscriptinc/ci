#!/bin/bash

# INPUTS
workspace_dir=$(pwd)
kubeconfig_dir="${workspace_dir}/kubeconfig"
helm_dir="${workspace_dir}/helmconfig"

account_file=${workspace_dir}/account.json

cat > ${account_file} <<EOF
${GCP_CREDENTIALS_JSON}
EOF

export GOOGLE_APPLICATION_CREDENTIALS=${account_file}
export KUBECONFIG=${kubeconfig_dir}/kubeconfig.yml

helm repo add storyscript https://storyscript.github.io/storyscript-chart
helm upgrade --install -f ${helm_dir}/values.yml storyscript storyscript/storyscript --debug