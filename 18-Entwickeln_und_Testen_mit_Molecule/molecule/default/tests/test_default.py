import testinfra.utils.ansible_runner
import os
import re

testinfra_hosts = testinfra.utils.ansible_runner.AnsibleRunner(
    os.environ['MOLECULE_INVENTORY_FILE']).get_hosts('all')

def test_pg_apt_key_in_key_list(host):
    command = host.run("apt-key list PostgreSQL")
    assert 'PostgreSQL' in command.stdout

def test_sources_listd_content(host):
    content = host.file("/etc/apt/sources.list.d/postgresql.list") \
                  .content_string
    assert re.search("^deb http://apt.postgresql.org/pub/repos/apt.*main",
                     content)

def test_postgresql_is_running_and_enabled(host):
    pg = host.service("postgresql")
    assert pg.is_running
    assert pg.is_enabled
    assert host.socket('tcp://127.0.0.1:5432').is_listening
