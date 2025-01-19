import testinfra.utils.ansible_runner
import os
import re

testinfra_hosts = testinfra.utils.ansible_runner.AnsibleRunner(
    os.environ['MOLECULE_INVENTORY_FILE']).get_hosts('all')


def test_key_file(host):
    key_filename = "/etc/apt/keyrings/pgdg-archive-keyring.asc"
    key_file = host.file(key_filename)
    assert key_file.exists

    command = host.run("apt install -y file")
    assert command.succeeded

    command = host.run(f"file {key_filename}")
    assert 'PGP public key block Public-Key' in command.stdout


def test_sources_list_content(host):
    content = host.file("/etc/apt/sources.list.d/pgdg.list") \
        .content_string

    assert re.search(
        "^deb.*https://apt\\.postgresql\\.org/pub/repos/apt.*main",
        content
    )


def test_postgresql_is_running_and_enabled(host):
    pg = host.service("postgresql")
    assert pg.is_running
    assert pg.is_enabled
    assert host.socket('tcp://127.0.0.1:5432').is_listening
