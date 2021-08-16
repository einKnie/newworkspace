
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
declare -a names

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

n="${#cmds[@]}"
ownname="$(basename "${BASH_SOURCE[0]}")"
layout="$(cd "$(dirname "${BASH_SOURCE[0]}")/.."; pwd -P)/layouts/${ownname%\.sh}.json"

call="workspace $workspace; append_layout $layout;"
for ((i=0;i<$n;i++)) ; do
    call="$call exec --no-startup-id ${cmds[$i]};"
done