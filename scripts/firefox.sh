
# pretty useless, but just to show how to 
# start other programs than urxvt
# This produces something like: 
# ________________________________
# |              |                |
# |              |    youtube     |
# |              |                |
# |  reddit      |                |
# |              |                |
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
workspace="firefox"

# commands
cmds[0]="firefox --new-window "https://reddit.com""
cmds[1]="firefox --new-window "https://youtube.com""
cmds[2]="urxvt -name bash -e bash -c \"bash\""

#########################
# end of config
#########################
