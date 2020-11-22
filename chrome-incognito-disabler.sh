#!/bin/bash

set -e

policyFile="/etc/opt/chrome/policies/managed/test_policy.json"
incognitoValue=$(jq ".IncognitoModeAvailability" $policyFile)

echo $incognitoValue
if [ "$incognitoValue" -eq 0 ];  then
    echo "incognito is enabled"
    tmp=$(mktemp)
    jq -r ".IncognitoModeAvailability |= 1" $policyFile  > "$tmp" && /bin/cp --no-preserve=mode,ownership "$tmp" $policyFile
    chmod +r policyFile
    echo "incognito is disabled"
fi
