#!/bin/bash

curl "http://localhost:4741/trailers" \
  --include \
  --request GET \
  --header "Authorization: Token token=${TOKEN}"

echo
