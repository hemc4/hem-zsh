# -=-=-=- TERMINALFRED -=-=-=-
#
# ** a few zshell plugins I use:
# encode64: encode and decode base64 with e64 or d64
# extract: to extract compressed files
# sublime
# colored-man-pages
# web-search
# z

# -=-=-=- OPEN GUI APPLICATIONS -=-=-=-
# Use `o spotify` for example
# See: http://stackoverflow.com/questions/13384139/elegant-and-efficient-way-to-start-gui-programs-from-terminal-without-spamming-i
o() {
    if [ $# -gt 0 ] ; then
        # Expand if $1 is an alias
        if [ $(alias | awk -F "[ =]" '{print $2}' | grep -x $1) > 0 ] ; then
            set -- $(alias $1 | awk -F "['']" '{print $2}') "${@:2}"
        fi
        ($@ &) &>/dev/null
    else
        echo "missing argument"
    fi
}

# -=-=-=- OPEN WEB PAGE OR SEARCH -=-=-=-
# see zshell web-search plugin plus add any custom here

alias urban='terminalfred urban'
alias regex='terminalfred regex'
alias shell='terminalfred shell'
alias jsonb='terminalfred jsonb'
alias aur='terminalfred aur'

function terminalfred() {
  emulate -L zsh

  # define search engine URLS
  typeset -A urls
  urls=(
    urban      "http://www.urbandictionary.com/define.php?term="
    regex      "https://regex101.com/library?orderBy=RELEVANCE&search="
    shell      "http://explainshell.com/explain?cmd="
    jsonb      "http://codebeautify.org/jsonviewer"
    aur        "https://www.archlinux.org/packages/?q="
  )

  if [[ -z "$urls[$1]" ]]; then
    echo "Available searches: \ngoogle, ddg, github, wiki, youtube, map, image, urban, ducky, regex, shell"
    return 1
  fi
  if [[ $# -gt 1 ]]; then
    url="${urls[$1]}${(j:+:)@[2,-1]}"
  else
    url="${(j://:)${(s:/:)urls[$1]}[1,2]}"
  fi
  open_command "$url"
}


# -=-=-=- FINDING [IN] FILES -=-=-=-
# Use locate or find for files. ack to search inside files
# See https://help.ubuntu.com/community/FindingFiles
alias fd='find . -type d -name'
alias ff='find . -type f -name'


# -=-=-=- DICTIONARY -=-=-=-
# See: https://www.unixmen.com/look-dictionary-definitions-via-terminal/
alias define='dict -d gcide' #English dictionary
alias dicts='dict -d moby-thesaurus' #Thesaurus
alias dictpe='dict -d fd-por-eng'
alias dictep='dict -d fd-eng-por'
alias dictpd='dict -d fd-por-deu'
alias dictdp='dict -d fd-deu-por'
alias dictde='dict -d fd-deu-eng'
alias dicted='dict -d fd-eng-deu'


# -=-=-=- TIMEZONES -=-=-=-
# Use tzselect to know how to configure a timezone
# For date related inquires, use also cal tool

alias tz="\
printf 'local: ';\
date;\
printf 'Berlin: ';\
TZ='Europe/Berlin' date;\
printf 'London: ';\
TZ='Europe/London' date;\
printf 'Sao Paulo: ';\
TZ='America/Sao_Paulo' date;\
printf 'Santiago: ';\
TZ='America/Santiago' date;\
printf 'New York: ';\
TZ='America/New_York' date;\
printf 'San Francisco: ';\
TZ='America/Los_Angeles' date;\
"

# -=-=-=- CALCULATOR -=-=-=-
# See: http://www.isthe.com/chongo/tech/comp/calc/
# Example: calc 42*4 or just calc to enter interactive mode

# -=-=-=- OTHER ALIASES -=-=-=-
alias -g H='| head'
alias -g T='| tail'
alias -g L="| less"
alias -g G="| grep"

# -=-=-=- TRANSLATION -=-=-=-
# See: https://github.com/soimort/translate-shell
# Install antigen: https://github.com/zsh-users/antigen#installation
# Use trans something
alias tre='trans -b'
alias trep='trans -b :pt'
alias tres='trans -shell -brief'
alias trev='trans -v'

# -=-=-=- TRELLO TASKS -=-=-=-
alias tasks='curl -s -X GET -H "Cache-Control: no-cache" -H "Terminalfred" "https://api.trello.com/1/lists/569623d6blablablac4d301?cards=open&card_fields=name&fields=cards&key=`cat ~/.trello/key.secret`&token=`cat ~/.trello/token.secret`" | jq ".cards[].name"'
function taskadd {
    str="$*"
    if [ -z "$str" ]; then
        echo usage: $0 task
    else
        curl -s -X POST -H "Cache-Control: no-cache" --data-urlencode "name=${str}" -H "Terminalfred" "https://api.trello.com/1/cards/?idList=569623d660blabla09c4d301&key=`cat ~/.trello/key.secret`&token=`cat ~/.trello/token.secret`" | jq ".url"
    fi
}


#json beutify cmd

alias jsonp='pbpaste | python -m json.tool'
