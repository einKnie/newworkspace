# This is a template script file
# for custom workspaces.
#
# To create a new custom workspace
# copy and rename this script to a *name*,
# then adapt only the CONFIG section of this 
# file to your configuration.
#
# Don't forget to create a .json layout
# file in the 'layouts' dir of the same *name*.
#
# HOWTO: Create a layout file
# Create your desired layout an a workspace, e.g. 3
# then, from any ws, call 
# 'i3-save-tree --workspace 3 > layouts/$name.json'
# This saves the basic window configuration, but
# you need to adapt the 'swallows' section of each node.
# https://i3wm.org/docs/layout-saving.html#EditingLayoutFiles
# Check out the x values with xprop.
# 
# This template produces something like: 
# ________________________________
# |              |                |
# |   bash 1     |                |
# |              |                |
# | _____________|                |
# |              |      vim       |
# |              |                |
# |   bash 2     |                |
# |______________|________________|
#

declare -a cmds

#########################
# start of config
#########################

# the workspace name
workspace="i3"

# adapt to workspace-specific needs.
# define as many windows as needed. (next one would be cmds[4])
# just make sure the settings in the 'swallows' part
# of the layout file match the started programs
# (check with xprop)
# (in this example, the -name parameter of urxvt matches
#  the 'instance' value in the layout)

files="~/.config/i3/config ~/.config/i3status/config ~/.config/i3status/config_secondary"

cmds[0]="urxvt -name shell1 -e bash -c \"bash\""
cmds[1]="urxvt -name shell2 -e bash -c \"bash\""
cmds[2]="urxvt -name vim -e bash -c \"vim -p $files\""

#########################
# end of config
#########################
