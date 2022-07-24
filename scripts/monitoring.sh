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
ws_id=$(i3-msg -t get_workspaces | jq --arg nm "$workspace" '.[] | select(.name == $nm).id')

if [ "$ws_id" == "" ] ;then
    call="workspace --no-auto-back-and-forth $workspace; append_layout $layout;"
    for ((i=0;i<$n;i++)) ; do
        call="$call exec --no-startup-id ${cmds[$i]};"
    done
else
    call="workspace --no-auto-back-and-forth $workspace;"
fi
