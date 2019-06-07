#!/bin/bash

curl "http://localhost:4741/examples/${ID}" \
  --include \
  --request GET \
  --header "Authorization: Token token=${TOKEN}"

echo
