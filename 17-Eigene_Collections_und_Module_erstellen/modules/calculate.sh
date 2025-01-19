#!/bin/bash

# Load module parameters:
source $1

# In case of missing operator we choose "+":
operator=${operator:-+}

# Bash does the job:
result=$(( $number1 $operator $number2 ))

if [ $? -eq 0 ]; then
    JSON='"result": "'$result'"'
else
    # Something went wrong
    JSON='"msg": "Syntax error", "failed": true'
fi

# Generate JSON-output:
cat <<EOF
{
  "changed": false,
  $JSON
}
EOF
