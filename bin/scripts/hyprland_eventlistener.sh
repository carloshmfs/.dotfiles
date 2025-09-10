#!/bin/sh

# based on: https://wiki.hyprland.org/IPC/#how-to-use-socket2-with-bash

handler=$1

print_help() {
    echo "Usage: hyprland_eventlistener.sh <handler>"
    echo -e "\nHANDLER:"
    echo -e " --help\t\tPrint this message."
    echo -e " --workspace\t\tWatch for workspace id changes."
    echo -e " --window\t\tWatch for window title changes."
}

if [[ -z $handler ]]; then
    echo "ERROR: missing argument"
    print_help
    exit
fi

if [[ $handler != "--window" && $handler != "--workspace" && $handler != "--help" ]]; then
    echo "ERROR: wrong argument handler"
    print_help
    exit
fi

if [[ $handler == "--help" ]]; then
    print_help
    exit
fi

if [[ $handler == "--workspace" ]]; then
    hyprctl activeworkspace | grep --color=never -oP '\(\K\d+(?=\))'
fi

on_workspace_change() {
    event=$1
    if [[ $handler == "--workspace" ]]; then
        echo ${event: -1}
    fi
}

on_window_change() {
    event=$1
    if [[ $handler == "--window" ]]; then
        echo "$event" | grep -oP --color=never ">>\K.*" | cut -d"," -f1
    fi
}

handle() {
  case $1 in
    "workspacev2"*) on_workspace_change $1 ;;
    "focusedmonv2"*) on_workspace_change $1 ;;
    "activewindow>>"*) on_window_change $1 ;;
  esac
}

socat -U - UNIX-CONNECT:$XDG_RUNTIME_DIR/hypr/$HYPRLAND_INSTANCE_SIGNATURE/.socket2.sock | while read -r line; do handle "$line"; done
