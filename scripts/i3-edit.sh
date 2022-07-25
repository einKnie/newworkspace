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
files="~/.config/i3/config ~/.config/i3status/config ~/.config/i3status/config_secondary"

cmds[0]="urxvt -name shell1 -e bash -c \"bash\""
cmds[1]="urxvt -name shell2 -e bash -c \"bash\""
cmds[2]="urxvt -name vim -e bash -c \"vim -p $files\""

#########################
# end of config
#########################
