#!/usr/bin/python3

import os
from argparse import ArgumentParser

parser = ArgumentParser()

parser.add_argument("--vault-id", dest="vault_id",
                    default="none", help="Vault-ID to use")
args = parser.parse_args()


vault_id = vars(args)['vault_id']

envar = 'VAULT_PASSWORD_' + vault_id.upper()

if envar in os.environ:
    print(os.environ[envar])
