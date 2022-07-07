#!/usr/bin/env bash

disp=$(tmux show-env | sed -n 's/^DISPLAY=//p')
echo "export DISPLAY=${disp}"
