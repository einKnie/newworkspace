# This produces something like: 
# ________________________________
# |              |                |
# |              |    htop        |
# |              |                |
# |  journal     |________________|
# |              |    vnstat      |
# |              |________________|
# |              |                |
# |              |    bash        |
# |______________|________________|
#

declare -a cmds
declare -a names

#########################
# start of config
#########################

# the workspace name
workspace=""
call=""

# commands
cmds[0]="urxvt -name journal -e bash -c \"journalctl -fn 50\""
cmds[1]="urxvt -name htop -e bash -c \"htop\""
cmds[2]="urxvt -name vnstat -e bash -c \"vnstat --live\""
cmds[3]="urxvt -name bash -e bash -c \"bash\""

#########################
# end of config
#########################

n="${#cmds[@]}"
ownname="$(basename "${BASH_SOURCE[0]}")"
layout="$(cd "$(dirname "${BASH_SOURCE[0]}")/.."; pwd -P)/layouts/${ownname%\.sh}.json"

# check if the workspace already exists and has any children
ws_id=$(i3-msg -t get_workspaces | jq --arg nm "$workspace" '.[] | select(.name == $nm).id')
if [ "$ws_id" != "" ] &&
   [ "$(i3-msg -t get_tree | jq --arg wsid "$ws_id" '.. |
            select(.type? == "workspace" and .id? == ($wsid | tonumber)).nodes |
            .. | select(.window?).window')" != "" ]; then
    # workspace exists and has at least one container
    # -> only switch to it
    call="workspace --no-auto-back-and-forth $workspace;"
else
    # workspace either
    #   * does not exist
    #   * exists but is empty
    # -> switch to it and populate
    call="workspace --no-auto-back-and-forth $workspace; append_layout $layout;"
    for ((i=0;i<$n;i++)) ; do
        call="$call exec --no-startup-id ${cmds[$i]};"
    done
fi
