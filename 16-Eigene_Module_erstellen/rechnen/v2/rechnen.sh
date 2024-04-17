#!/bin/bash
# WANT_JSON

# Test, ob jq installiert ist:
if ! type jq >/dev/null 2>&1; then
    echo '{ "failed": true, "msg": "Please install jq" }'
    exit 1
fi

# Modul-Parameter aus Datei einlesen:
zahl1=$( jq -r .zahl1 < $1 )
zahl2=$( jq -r .zahl2 < $1 )
rechenart=$( jq -r .rechenart < $1 )

# Falls Rechenart nicht gesetzt ist, nehmen wir "+":
[[ $rechenart = "null" ]] && rechenart=+

########## Ab hier geht es weiter wie bereits gezeigt ##########

ergebnis=$(( zahl1 $rechenart $zahl2 ))

if [ $? -eq 0 ]; then
    JSON='"ergebnis": "'$ergebnis'"'
else
    # Da ging wohl was schief
    JSON='"msg": "Syntax error", "failed": true'
fi

# JSON-Output generieren:
cat <<EOF
{ 
  "changed": false,
  $JSON
}
EOF
