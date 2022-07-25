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
    echo "available configs in $layoutpath:"
    for script in $(ls $scriptpath/*.sh) ; do
        name="$(basename "$script")"
        echo -e "\t${name%\.sh}"
    done
}

# $1 should be a config name, e.g. monitoring -> scripts/monitoring.sh, layouts/monitoring.json
err=0
[ -z "$1" ] && { print_help; exit 1; }
[ -f "${scriptpath}/${1}.sh"   ] || { echo "error: ${1}.sh not found.";   ((err++)); }
[ -f "${layoutpath}/${1}.json" ] || { echo "error: ${1}.json not found."; ((err++)); }
[ $err -gt 0 ] && { print_help; exit 1; }

# source script and call
. "${scriptpath}/${1}.sh" 
i3-msg "$call"

