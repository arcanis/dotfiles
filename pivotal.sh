_pivotal()
{
    local IFS=$'\n'

    local PROJECT="${1}"
    local PIVOTAL_ISSUES="/tmp/pivotal-issues-${PROJECT}"

    if [ ! -f "${PIVOTAL_ISSUES}" ] || test $(find "${PIVOTAL_ISSUES}" -mmin +30); then

        local data="$(curl -X GET -H "X-TrackerToken: $TOKEN" "https://www.pivotaltracker.com/services/v5/my/work?sort=${PROJECT}" 2> /dev/null)"
        local issues=( $(printf "%s" "${data}" | underscore --outfmt text map "value.id+'_'+value.story_type+'_'+value.name.trim()" 2> /dev/null) )

        local branches=( )
        for issue in ${issues[@]}; do
            local id="$(printf "%s" "${issue}" | grep -Po '^[0-9]+')"
            local type="$(printf "%s" "${issue}" | grep -Po '^[0-9]+_[^_]+' | sed 's/^[0-9]\+_//g')"
            local name="$(printf "%s" "${issue}" | sed 's/^[0-9]\+_[^_]\+_//g' )"
            local slug="$(echo -n "${name}" | sed -e 's/[^[:alnum:]]/-/g' | tr -s '-' | tr A-Z a-z | sed 's/^-*//g' | sed 's/-*$//g')"
            branches+=("${type}/${slug}_${id}")
        done

        printf "%s\n" "${branches[@]}" > "${PIVOTAL_ISSUES}"

    else

        local branches=( $(cat "${PIVOTAL_ISSUES}") )

    fi

    COMPREPLY=( $(compgen -W '$(printf "%q\n" "${branches[@]}")' -- "${COMP_WORDS[COMP_CWORD]}" ) )
}
