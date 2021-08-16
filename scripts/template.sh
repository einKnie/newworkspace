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
declare -a names

#########################
# start of config
#########################

# the workspace name
workspace=""

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

call="workspace $workspace; append_layout $layout;"
for ((i=0;i<$n;i++)) ; do
    call="$call exec --no-startup-id ${cmds[$i]};"
done

echo "opening $n windows on workspace $workspace from layout $layout"
#exit 0