# This is a template script file
# for custom workspaces.
#
# To create a new custom workspace
# copy and rename this script to a *name*,
# then adapt the CONFIG section of this 
# file to your configuration.
#
# Don't forget to create a .json layout
# file in the 'layouts' dir of the same *name*.
#
# HOWTO: Create a layout file
# Create your desired layout an a workspace, e.g. 3
# then, from any ws, call 
# 'i3-save-tree --workspace $workspace > layouts/$name.json'
# This saves the basic window configuration, but
# you need to adapt the 'swallows' section of each node.
# https://i3wm.org/docs/layout-saving.html#EditingLayoutFiles
# Check out the x values with xprop.
# 
# This template produces something like: 
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

#########################
# start of config
#########################

# the workspace name
workspace=""
call=""

# adapt to workspace-specific needs.
# define as many windows as needed.
# just make sure the settings in the 'swallows' part
# of the layout file match the started programs
# (check with xprop)
# (in this example, the -name parameter of urxvt matches
#  the 'instance' value in the layout)

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
    for ((i=0;i<n;i++)) ; do
        call="$call exec --no-startup-id ${cmds[$i]};"
    done
fi

echo "opening $n windows on workspace $workspace from layout $layout"
