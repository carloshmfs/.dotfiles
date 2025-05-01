#!/bin/sh

# based on: https://wiki.hyprland.org/IPC/#how-to-use-socket2-with-bash

print_workspace_id() {
    event=$1
    echo ${event: -1}
}

handle() {
  case $1 in
    workspacev2*) print_workspace_id $1 ;;
    focusedmonv2*) print_workspace_id $1 ;;
  esac
}

socat -U - UNIX-CONNECT:$XDG_RUNTIME_DIR/hypr/$HYPRLAND_INSTANCE_SIGNATURE/.socket2.sock | while read -r line; do handle "$line"; done
