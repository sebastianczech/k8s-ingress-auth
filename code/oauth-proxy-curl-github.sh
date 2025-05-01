#!/bin/bash

# Step 1: Set up variables
GITHUB_CLIENT_ID=$(cat oauth_id.txt)
GITHUB_CLIENT_SECRET=$(cat oauth_secret.txt)
REDIRECT_URI="https://podinfo.example.com/oauth2/callback"
STATE="1234"

### web flow

# Step 2a: Redirect to GitHub's Authorization Endpoint
AUTH_URL="https://github.com/login/oauth/authorize?client_id=${GITHUB_CLIENT_ID}&redirect_uri=${REDIRECT_URI}&scope=repo&response_type=code&state=${STATE}"
echo "Open the following URL in your browser to authorize the application:"
echo "${AUTH_URL}"

# Step 3a: Extract the Authorization Code from the Redirect URL
echo "Enter the authorization code from the redirect URL (you can take from URL in web browser, even if you have an error 500):"
read AUTHORIZATION_CODE

TOKEN_RESPONSE=$(curl -s -X POST https://github.com/login/oauth/access_token \
  -H "Accept: application/json" \
  -d "client_id=${GITHUB_CLIENT_ID}" \
  -d "client_secret=${GITHUB_CLIENT_SECRET}" \
  -d "code=${AUTHORIZATION_CODE}" \
  -d "redirect_uri=${REDIRECT_URI}" \
  -d "state=${STATE}")

echo "Token response: ${TOKEN_RESPONSE}"

### device flow

# # Step 2b: Request a Device Code
# DEVICE_CODE_RESPONSE=$(curl -s -X POST https://github.com/login/device/code \
#   -H "Accept: application/json" \
#   -d "client_id=${GITHUB_CLIENT_ID}" \
#   -d "scope=repo")

# echo "Device code: ${DEVICE_CODE_RESPONSE}"

# DEVICE_CODE=$(echo ${DEVICE_CODE_RESPONSE} | jq -r '.device_code')
# USER_CODE=$(echo ${DEVICE_CODE_RESPONSE} | jq -r '.user_code')

# echo "Enter in web browser https://github.com/login/device user code: ${USER_CODE}"
# read WAIT_FOR_USER

# # Step 3b: Exchange the Authorization Code for an Access Token
# TOKEN_RESPONSE=$(curl -s -X POST https://github.com/login/oauth/access_token \
#   -H "Accept: application/json" \
#   -d "client_id=${GITHUB_CLIENT_ID}" \
#   -d "device_code=${DEVICE_CODE}" \
#   -d "grant_type=urn:ietf:params:oauth:grant-type:device_code"
# )

# echo "Token response: ${TOKEN_RESPONSE}"

# Step 5: Use the Access Token with `curl` to get user information
ACCESS_TOKEN=$(echo ${TOKEN_RESPONSE} | jq -r '.access_token')

# HEADER=$(echo $ACCESS_TOKEN | cut -d '.' -f1)
# PAYLOAD=$(echo $ACCESS_TOKEN | cut -d '.' -f2)
# echo "Header and Payload of the Access Token:"
# echo $HEADER | base64 -d
# echo $PAYLOAD | base64 -d

if [ -z "${ACCESS_TOKEN}" ] || [ "${ACCESS_TOKEN}" == "null" ]; then
  echo "Failed to obtain access token"
  echo "Response: ${TOKEN_RESPONSE}"
  exit 1
fi

echo "Access token: ${ACCESS_TOKEN}"

echo "Fetching user information from GitHub API"
curl -H "Authorization: Bearer ${ACCESS_TOKEN}" https://api.github.com/user

# Step 6: Use the Access Token with `curl` to access the protected resource
echo "Accessing protected resource at https://podinfo.example.com"
curl -k -s -L -H "Authorization: Bearer ${ACCESS_TOKEN}" https://podinfo.example.com/ | head -n 20
