#!/bin/bash



#### This script takes the color name as returns its respective color code

code='\033['

case $1 in

black | BLACK ) color="0;30m";;
red   | RED   ) color="0;31m";;
green | GREEN ) color="0;32m";;
yellow| YELLOW) color="0;33m";;
blue  | BLUE  ) color="1;34m";;
purple| PURPLE) color="1;35m";;
cyan  | CYAN  ) color="1;36m";;
grey  | GREY  ) color="0;37m";;
normal|NORMAL ) color="0m";;
*	      ) color="0m";;

esac


echo ${code}${color}	
