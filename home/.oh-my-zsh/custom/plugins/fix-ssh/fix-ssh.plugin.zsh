function fixssh() {

    for x in /tmp/ssh-*/agent.*; do
        if SSH_AUTH_SOCK="$x" ssh-add -l >& /dev/null; then
            ln -sf "$x" ~/.ssh/ssh_auth_sock
            return
        fi
    done

    echo "Your environment doesn't seem to have a working running agent"

}
