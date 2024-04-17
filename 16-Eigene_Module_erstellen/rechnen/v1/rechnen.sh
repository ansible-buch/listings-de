#!/bin/bash

# Modul-Parameter aus Datei einlesen:
source $1

# Falls Rechenart nicht gesetzt ist, nehmen wir "+":
rechenart=${rechenart:-+}

# Die Bash-Arithmetik-Umgebung erledigt die Arbeit:
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
