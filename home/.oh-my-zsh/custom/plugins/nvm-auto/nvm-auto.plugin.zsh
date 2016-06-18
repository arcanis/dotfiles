chpwd_functions+=("nvm_auto_use")
typeset -U chpwd_functions

function nvm_auto_use() {

    nvm_rc_version >& /dev/null

    if [[ $NVM_RC_VERSION == '' ]]; then
        NVM_RC_VERSION=node
    fi

    local version_target=$(nvm_version $NVM_RC_VERSION)
    local version_current=$(nvm_version)

    if [[ $version_target != $version_current ]]; then
        nvm use $version_target
    fi

    true

}

nvm_auto_use
