#!/bin/bash
if [ ! -x /usr/bin/cmus-remote ];
then
    echo "cmus is not installed."
    exit
fi

ARTIST=$( cmus-remote -Q 2>/dev/null | grep "\bartist" | cut -d " " -f 3- )
TITLE=$( cmus-remote -Q 2>/dev/null | grep "\btitle" | cut -d " " -f 3- )

if [ -z "$ARTIST" ];
then
    exit
else
    echo "   $ARTIST - $TITLE"
fi
