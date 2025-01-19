#!/usr/bin/env python3

import csv
import json
import sys
from collections import defaultdict

CSV_FILE = 'hosts.csv'

def main():
    inventory = defaultdict(lambda: {"hosts": [], "vars": {}})
    hostvars = {}

    # Parse CSV data:
    with open(CSV_FILE, newline='') as csvfile:
        reader = csv.DictReader(csvfile)
        for row in reader:
            host   = row["host"]
            ip     = row["ip"]
            group  = row["group"]
            user   = row["user"]
            become = row["become"]

            # Add host to group:
            inventory[group]["hosts"].append(host)

            # Save ip, user, become as host vars:
            hostvars[host] = {
                "ansible_host": ip,
                "ansible_user": user,
                "ansible_become": become
            }

    # Add hostvars as _meta:
    inventory["_meta"] = {"hostvars": hostvars}

    # Called with --list ?
    if len(sys.argv) == 2 and sys.argv[1] == '--list':
        print(json.dumps(inventory, indent=2))
    else:
        print(json.dumps({}))


if __name__ == '__main__':
    main()
