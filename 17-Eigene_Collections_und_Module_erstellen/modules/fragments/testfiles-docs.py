# [...]

DOCUMENTATION = '''
---
module: testfiles
short_description: Create an amount of testfiles
description:
  - This module can create or remove an amount of testfiles.
  - Number, name format and destination path can be chosen.
version_added: "1.0.0"
options:
  path:
    description:
      - The destination folder. 
        It must exist, otherwise this module will fail.
    type: path
    default: /tmp
  number:
    description:
      - Number of files
    type: int
    default: 10
  format:
    description:
      - Format in printf-style (like 'test%02g.txt')
    type: str
    required: true
  state:
    description:
      - Whether the files should be created or removed.
    type: str
    choices: [ absent, present ]
    default: present

author:
  - Some User (user1@example.org)
'''

EXAMPLES = '''
- name: Create 20 testfiles test01.txt .. test20.txt in /tmp
  testfiles:
    number: 20
    format: test%02g.txt

- name: Remove 30 testfiles test01.jpg .. test30.jpg in /opt
  testfiles:
    number: 30
    format: test%02g.jpg
    path: /opt
    state: absent
'''
