#!/bin/sh

VOLUME=`pamixer --get-volume-human`

# Icons
# 
# 
# 󰖀
# 
# 
# 

ICON=""

if [ $VOLUME == 'muted' ]
then
    VOLUME="M"
    ICON=""
fi

echo "<box type=Bottom width=2 color=#f7b374><fc=#f7b374><hspace=5/><fn=1>$ICON</fn><hspace=5/>$VOLUME<hspace=5/></fc></box>"
