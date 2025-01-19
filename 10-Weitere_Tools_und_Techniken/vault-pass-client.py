#!/usr/bin/python3

import os
from argparse import ArgumentParser
import subprocess

parser = ArgumentParser()

parser.add_argument("--vault-id", dest="vault_id",
                    default="none", help="Vault-ID to use")
args = parser.parse_args()


vault_id = vars(args)['vault_id']

p = subprocess.run(['pass', f'ansible/vault/{vault_id}'])
