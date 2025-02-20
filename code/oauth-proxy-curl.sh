#!/bin/bash

# Step 1: Set up variables
GITHUB_CLIENT_ID=$(cat oauth_id.txt)
GITHUB_CLIENT_SECRET=$(cat oauth_secret.txt)
REDIRECT_URI="https://podinfo.example.com/oauth2/callback"

# Step 2: Redirect to GitHub's Authorization Endpoint
AUTH_URL="https://github.com/login/oauth/authorize?client_id=${GITHUB_CLIENT_ID}&redirect_uri=${REDIRECT_URI}&scope=repo&response_type=code"
echo "Open the following URL in your browser to authorize the application:"
echo "${AUTH_URL}"

# Step 3: Extract the Authorization Code from the Redirect URL
echo "Enter the authorization code from the redirect URL:"
read AUTHORIZATION_CODE

# Step 4: Exchange the Authorization Code for an Access Token
TOKEN_RESPONSE=$(curl -s -X POST https://github.com/login/oauth/access_token \
  -H "Accept: application/json" \
  -d "client_id=${GITHUB_CLIENT_ID}" \
  -d "client_secret=${GITHUB_CLIENT_SECRET}" \
  -d "code=${AUTHORIZATION_CODE}" \
  -d "redirect_uri=${REDIRECT_URI}")

ACCESS_TOKEN=$(echo ${TOKEN_RESPONSE} | jq -r '.access_token')

if [ -z "${ACCESS_TOKEN}" ] || [ "${ACCESS_TOKEN}" == "null" ]; then
  echo "Failed to obtain access token"
  echo "Response: ${TOKEN_RESPONSE}"
  exit 1
fi

echo "Access token: ${ACCESS_TOKEN}"

# Step 5: Use the Access Token with `curl` to get user information
echo "Check https://api.github.com/user"
curl -H "Authorization: Bearer ${ACCESS_TOKEN}" https://api.github.com/user

echo "Check https://podinfo.example.com"
curl -k -L -H "Authorization: Bearer ${ACCESS_TOKEN}" https://podinfo.example.com/