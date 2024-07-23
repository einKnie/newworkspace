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

#########################
# start of config
#########################

# the workspace name
workspace=""

# commands
cmds[0]="urxvt -name journal -e bash -c \"journalctl -p6 -fn 100\""
cmds[1]="urxvt -name htop -e bash -c \"htop\""
cmds[2]="urxvt -name vnstat -e bash -c \"vnstat --live\""
cmds[3]="urxvt -name bash -e bash -c \"bash\""

#########################
# end of config
#########################
