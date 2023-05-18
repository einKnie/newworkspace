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

get_path_from_dir() {
    # use rofi for directory listing
    # return 1 on invalid path
    d="$(fd --search-path "$default_dir" --type=d --exact-depth=1 | rofi -dmenu -p "dir")"
    echo "$d"
    [[ -d "$d" ]] || return 1

    ws_path="$d"
}


if ! get_path_from_dir ; then
    notify-send "invalid path"
    exit 1
fi
ws_name=$(basename "$ws_path")

# set variables to use by caller
workspace="$ws_name"

cmds[0]="urxvt -name git -cd \"$ws_path\""
cmds[1]="urxvt -name misc -cd \"$ws_path\""
cmds[2]="urxvt -name container -cd \"$ws_path\""

#########################
# end of config
#########################
