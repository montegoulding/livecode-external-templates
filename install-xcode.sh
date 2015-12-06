#!/bin/bash

INSTALLPATH="$HOME/Library/Developer/Xcode/Templates/Project Templates/LiveCode"

if [[ -L "$INSTALLPATH" && -d "$INSTALLPATH" ]] ; then
  rm "$INSTALLPATH"
fi
SCRIPTPATH="$(pwd)/Xcode"
ln -sF "$SCRIPTPATH" "$INSTALLPATH"
