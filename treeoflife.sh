#/bin/bash

########### This is a program that tries to simulate a human, like borning, going to school, getting adult, aging with time ########
alive=true;
name="Setve Wozniak"
make="./colors.sh"
normal="\033[0m"


while $alive
do
	echo -e "`$make green`A new child is born and his name is `$make blue`$name${normal}"
	echo -e "``cries!! cries!! cires!!"
	sleep 2
	echo -e "mother holds `$make blue`$name $normal"
	sleep 1


	alive=false;
done
