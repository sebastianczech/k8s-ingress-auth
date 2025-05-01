#!/bin/bash

CLIENT_ID=$(cat ../infra/client_id.txt)
CLIENT_SECRET=$(cat ../infra/client_secret.txt)
TENANT_ID=$(cat ../infra/tenant_id.txt)
REDIRECT_URI="https://podinfo.example.com/oauth2/callback"
PODINFO_URL="https://podinfo.example.com/"
AUTH_URL="https://login.microsoftonline.com/${TENANT_ID}/oauth2/v2.0/authorize"
TOKEN_URL="https://login.microsoftonline.com/${TENANT_ID}/oauth2/v2.0/token"
SCOPE="$(cat ../infra/sp_id.txt)/.default"
GRANT_TYPE="client_credentials"

BODY="grant_type=${GRANT_TYPE}&client_id=${CLIENT_ID}&client_secret=${CLIENT_SECRET}&scope=${SCOPE}"
HEADERS="Content-Type: application/x-www-form-urlencoded"

ACCESS_TOKEN_RESPONSE=$(curl -s -X POST ${TOKEN_URL} -H "${HEADERS}" -d "${BODY}")
echo "Access token response: ${ACCESS_TOKEN_RESPONSE}"

ACCESS_TOKEN=$(echo ${ACCESS_TOKEN_RESPONSE} | jq -r '.access_token' | tr -d '"')
echo "Access token: ${ACCESS_TOKEN}"

RESPONSE=$(curl -k -s -L -H "Authorization: Bearer ${ACCESS_TOKEN}" ${PODINFO_URL})
echo "Response from podinfo app: ${RESPONSE}"