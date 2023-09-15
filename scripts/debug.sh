#!/bin/bash

PROVIDENTIA_TOKEN=your-api-token
PROVIDENTIA_FQDN=providentia-fqdn
PROVIDENTIA_PROJECT=exercise-name-here

# Get all hosts from the API
ALL_HOSTS=$(curl -k -H "Authorization: Token ${PROVIDENTIA_TOKEN}" https://${PROVIDENTIA_FQDN}/api/v3/${PROVIDENTIA_PROJECT}/hosts)

# Parse the JSON array and loop over each item, making an API call per host to get the HTTP status code
for host in $(echo $ALL_HOSTS | jq -r '.result[]'); do
    curl -k -s -o /dev/null -I -w "${host} %{http_code}\n" -H "Authorization: Token ${PROVIDENTIA_TOKEN}" "https://${PROVIDENTIA_FQDN}/api/v3/dcm3/hosts/$host"
done
