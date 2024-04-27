# This is a script file for a common work ws
#
# This template produces something like:
# ________________________________
# |              |                |
# |              |    bash        |
# |              |                |
# |              |                |
# |  bash        |________________|
# |              |                |
# |              |                |
# |              |                |
# |              |    bash        |
# |______________|________________|
#

declare -a cmds

#########################
# start of config
#########################

# variables
default_dir="$HOME/scripts"
default_name="$(basename "$default_dir")"

ws_path="$default_dir"
ws_name="$defaut_name"

get_path() {
    # list subdirs of the default_dir path and feed that to rofi for
    # simple selection
    d="$(fd --search-path "$default_dir" --type=d --exact-depth=1 | rofi -dmenu -p "dir")"
    [[ -d "$d" ]] || return 1

    ws_path="$d"
}

get_ws_name() {
    # using basename here allows me to simply feed the given path to this function.
    # if basename is presented with a non-path, e.g. "testname", it simply returns the input
    # so this changes nothing if the function is called with the desired name directly
    name=$(basename "$1")

    # check how many workpaces exist starting with the given name
    no=$(i3-msg -t get_workspaces | jq --arg nm "$name" '.[] | select(.name|startswith($nm)).id' | wc -l)
    if [ $no -gt 0 ] ; then
        # inc number and add to name (e.g. ws "bla" exists -> new ws: "bla2")
        # btw, this is not perfect. if i have bla, bla1, bla2 and delete bla1 -> next ws will try bla2, which exists
        # but i don't care enough atm
        name="${name}$((no + 1))"
    fi

    echo "$name"
}

####################################

# fetch desired cwd from user and name workspace accordingly
if ! get_path ; then
    notify-send "invalid path"
    exit 1
fi

workspace="$(get_ws_name "$ws_path")"

cmds[0]="urxvt -name git -cd \"$ws_path\""
cmds[1]="urxvt -name misc -cd \"$ws_path\""
cmds[2]="urxvt -name container -cd \"$ws_path\""

#########################
# end of config
#########################
