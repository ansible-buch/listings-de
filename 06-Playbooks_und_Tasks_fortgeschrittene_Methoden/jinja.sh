#!/bin/bash
TARGET_HOST=$1
TEMPLATE_FILE=$2

if [ $# -ne 2 ]; then
    echo "Usage: $0 TARGET_HOST TEMPLATE_FILE" 1>&2
    exit 1
fi

ansible $TARGET_HOST -m debug \
    -a "msg={{lookup('template', '$TEMPLATE_FILE')}}" |
     sed '1s/.*=> //' | 
     jq -r '.msg'
