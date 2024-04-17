ansible-playbook() {
    LOCKFILE="/tmp/ansible-playbook.lock"
    
    flock --verbose $LOCKFILE ansible-playbook "$@"
}
