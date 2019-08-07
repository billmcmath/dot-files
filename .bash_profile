if [ -f ~/.bashrc ]; then
   source ~/.bashrc
fi

export HISTCONTROL=ignorespace

alias ssh-keygen='ssh-keygen -o -a 100 -t ed25519 -C ""'

_complete_ssh_hosts ()
{
        COMPREPLY=()
        cur="${COMP_WORDS[COMP_CWORD]}"
        comp_ssh_hosts=`cat ~/.ssh/known_hosts | \
                        cut -f 1 -d ' ' | \
                        sed -e s/,.*//g | \
                        grep -v ^# | \
                        uniq | \
                        grep -v "\[" ;
                cat ~/.ssh/config | \
                        grep "^Host " | \
                        awk '{print $2}'
                `
        COMPREPLY=( $(compgen -W "${comp_ssh_hosts}" -- $cur))
        return 0
}
complete -F _complete_ssh_hosts ssh

function curltime() {
    curl -w "\ttime_namelookup:\t%{time_namelookup}\n\ttime_connect:\t\t%{time_connect}\n\ttime_appconnect:\t%{time_appconnect}\n\ttime_pretransfer:\t%{time_pretransfer}\n\ttime_redirect:\t\t%{time_redirect}\n\ttime_starttransfer:\t%{time_starttransfer}\n\t----------\n\ttime_total:\t\t%{time_total}\n"  -o /dev/null -s "$1"
}
