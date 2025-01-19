# Ansible-Rolle: apache

Eine einfache Apache-Installation auf verschiedenen Linux-Systemen

## Voraussetzungen

Die Firewall muss deaktiviert sein, oder Port 80 muss anderweitig
geöffnet werden.

## Geeignet für

Debian 12, Rocky 9, openSUSE 15, Ubuntu 24.04

## Parameter mit Default-Werten

    apache_color: LightBlue
    apache_google_redirect: /go
    apache_admin_user: boss
    apache_admin_pass: # no default

## Beschreibung

Diese Rolle wurde rein zu Demonstrationszwecken erstellt. Sie installiert
auf verschiedenen Linux-Systemen einen Apache-Webserver, startet ihn
und richtet eine einfache Startseite ein. Eine Weiterleitungsregel
nach Google wird ebenfalls konfiguriert.

Mit dem Parameter `apache_color` kann die Hintergrundfarbe der Startseite
bestimmt werden. Alle anderen Parameter sind nur zur internen Verwendung.

## Beispiel-Playbook

```
- hosts: all

  roles:
    - name: apache
```

## Autor

John Doe <john@example.org>
