#!/bin/sh

[ -p "$FIFO_UEBERZUG" ] && printf '{"action":"remove","identifier":"preview"}\n' >"$FIFO_UEBERZUG"
