function colors() {

    local text='gYw'

    local fgs=('    m' '   1m' '  30m' '1;30m' '  31m' '1;31m' '  32m' \
               '1;32m' '  33m' '1;33m' '  34m' '1;34m' '  35m' '1;35m' \
               '  36m' '1;36m' '  37m' '1;37m')

    local bgs=('40m' '41m' '42m' '43m' '44m' '45m' '46m' '47m')

    local bg bge
    local fg fge

    echo -e "\n                 40m     41m     42m     43m     44m     45m     46m     47m";

    for fg in "${fgs[@]}"; do

        local fge=${fg// /}
        echo -en " ${fg} \033[${fge}  ${text}  "

        for bg in "${bgs[@]}"; do

            local bge=${bg// /}
            echo -en "$EINS \033[${fg}\033[${bg}  ${text}  \033[0m";

        done

        echo;

    done

    echo

}
