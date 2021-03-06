#!/bin/bash

set -Eeuo pipefail

# INPUTS
workspace_dir=$(pwd)
terraform_dir="${workspace_dir}/platform-terraform"

name=$(cat "${terraform_dir}/name")

while [ "$(curl -s "https://auth.${name}.storyscript-ci.com/healthcheck")" != "OK" ]; do
  echo -n '.'
  sleep 1
done

curl https://api.github.com/orgs/storyscript/members -u storyscript-infra:"$STORYSCRIPT_INFRA_PASSWORD" | \
jq ".[] | .login" | \
xargs -I username curl -X PUT https://auth."${name}".storyscript-ci.com/allowlist/username -H "Authorization: $AUTH_ALLOWLIST_TOKEN"
