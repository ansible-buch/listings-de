#!/bin/bash

ZAHL=$(( RANDOM % 3 ))

# 0 = kein Change
# 1 = Change
# 2 = Fehler

case $ZAHL in
    0) JSON='"changed": false'
       ;;
    1) JSON='"changed": true' 
       ;;
    2) JSON='"changed": false, "failed": true, "msg": "Das ging schief."'
       ;;
esac

cat <<EOF
{ 
  "zufallszahl": $ZAHL,
  $JSON
}
EOF
