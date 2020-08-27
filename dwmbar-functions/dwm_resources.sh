#!/bin/sh

# A dwm_bar function to display information regarding system memory, CPU temperature, and storage
# Joe Standring <git@joestandring.com>
# GNU GPLv3

dwm_resources () {
    # Used and total memory
    MEMUSED=$(free -h | awk '(NR == 2) {print $3}')
  #  STOUSED=$(df -h | grep '/$' | awk '{print $3}')
  #  STOTOT=$(df -h | grep '/$' | awk '{print $2}')
  #  STOPER=$(df -h | grep '/$' | awk '{print $5}')



#    printf "%s" "$SEP1"
#    if [ "$IDENTIFIER" = "unicode" ]; then
#        printf "MEM %s STO %s/%s: %s" "$MEMUSED" "$STOUSED" "$STOTOT" "$STOPER"
#    else
#        printf "STA|MEM %s|STO %s/%s: %s" "$MEMUSED" "$STOUSED" "$STOTOT" "$STOPER"
#    fi
#    printf "%s\n" "$SEP2"
    printf "%s" "$SEP1"
    if [ "$IDENTIFIER" = "unicode" ]; then
        printf "MEM %s" "$MEMUSED"
    else
        printf "MEM %s" "$MEMUSED"
    fi
    printf "%s\n" "$SEP2"

}


dwm_resources
