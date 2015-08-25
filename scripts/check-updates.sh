#!/bin/bash
sudo yaourt -Sy
updates=$(yaourt -Qu)
color="color='cyan'"
if [ -z "$updates" ]; then
    echo -e 'updates:set_markup("<span '$color'>   0 </span>")' | awesome-client
else
    number_updates=$(echo "$updates" | wc -l)
    echo -e 'updates:set_markup("<span '$color'>  '$number_updates' </span>")' | awesome-client
fi
