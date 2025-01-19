#!/bin/bash

NUMBER=$(( RANDOM % 3 ))

# 0 = no Change
# 1 = Change
# 2 = Error

case $NUMBER in
    0) JSON='"changed": false'
       ;;
    1) JSON='"changed": true'
       ;;
    2) JSON='"changed": false, "failed": true, "msg": "Something went wrong"'
       ;;
esac

cat <<EOF
{
  "random_number": $NUMBER,
  $JSON
}
EOF
