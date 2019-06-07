#!/bin/bash

curl "http://localhost:4741/trailers/" \
  --include \
  --request POST \
  --header "Content-Type: application/json" \
<<<<<<< HEAD
  --data '{
    "trailer": {
      "make": "'"${MAKE}"'",
      "model": "'"${MODEL}"'",
      "user_id": "'"${USER}"'"
=======
  --header "Authorization: Token token=${TOKEN}" \
  --data '{
    "trailer": {
      "make": "'"${MAKE}"'",
      "model": "'"${MODEL}"'"
>>>>>>> dev
    }
  }'

echo
