#!/usr/bin/env bash

# This is wrapper script for starting
# i3 workspaces from templates.
# For more info see scripts/template.sh

dir="$(cd "$(dirname "$0")"; pwd -P)"
scriptpath="${dir}/scripts"
layoutpath="${dir}/layouts"

print_help() {
    echo "$(basename "$0") - setup a predefined workspace"
    echo "usage:"
    echo "> $(basename "$0") <config>"
    echo
    echo "available configs in $scriptpath:"
    for script in $(ls $scriptpath/*.sh) ; do
        name="$(basename "$script")"
        if [ -f  "${layoutpath}/${name%\.sh}.json" ]; then
            echo -e "\t${name%\.sh}"
        else
            echo -e "\t${name%\.sh} (invalid: layout missing)"
        fi
    done
}

# $1 should be a config name
# e.g. monitoring -> scripts/monitoring.sh, layouts/monitoring.json
err=0
[ -z "$1" ] && { print_help; exit 1; }
[ -f "${scriptpath}/${1}.sh"   ] || { echo "error: ${1}.sh not found.";   ((err++)); }
[ -f "${layoutpath}/${1}.json" ] || { echo "error: ${1}.json not found."; ((err++)); }
[ $err -gt 0 ] && { print_help; exit 1; }

# generate i3-msg call to open and populate workspace
# by sourcing the values from the corresponding script
. "${scriptpath}/${1}.sh"
n="${#cmds[@]}"

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
    call="workspace --no-auto-back-and-forth $workspace; append_layout ${layoutpath}/${1}.json;"
    for ((i=0;i<n;i++)) ; do
        call="$call exec --no-startup-id ${cmds[$i]};"
    done
fi

i3-msg "$call"
