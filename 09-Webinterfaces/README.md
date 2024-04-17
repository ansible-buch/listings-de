# Unser erstes Ansible-Projekt

## Inventory

Das Projekt benötigt vier virtuelle Maschinen, wie in der statischen
Inventorydatei `inventory` aufgeführt.

## Playbooks

Im `playbooks`-Ordner finden Sie verschiedenste Playbooks. Starten Sie
diese mit `ansible-playbook`; z.B.:

```
ansible-playbook playbooks/hallo-ansible.yml
```

## Rollen

- `apache`: Eine Rolle, die einen Apache Webserver auf vier unterschiedlichen
Distributionen einrichtet
- `hallo`: Ein erstes, sehr simples Beispiel einer Rolle
