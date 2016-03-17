#!/bin/bash

####################  THIS SCRIPT WILL INSTALL THE JAVA IN LINUX MACHINE WHEN EXECUTED 

###REQUIRED VAIRABLES 
installPath="/tmp/local/java"
jdkVer=""
sourceFile=$1

## this function is just used to return the basic colors 

function getColor {

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
        *             ) color="0m";;

  esac

  echo ${code}${color}
}


## HERE java -version command's status code is compared if the system has java installed or not
function isJavaInstalled() {

	java -version > /dev/null 2>&1
	if (( $? == 0 ))
	then
     		echo "true"  
      	else
      	 	echo "false"
	fi
}


########################### FINDING THE JAVA VERSION #######################################

function getJdkVer() {
	
	jdkVer=`ls -1 $installPath`
}


######################### THIS WILL BEGIN TO WRITE CHANGES ON THE SYSTEM ######################################

function begin() {
	
	echo "making directory $installPath"
 	mkdir -p $installPath
	
	cd $installPath
	echo "extracting jdk tar.gz into $installPath"
	tar -xvf $sourceFile

	getJdkVer
	
	###EDITING PROFILE REMAINING
	###ACKNOWLEDGING THE SYSTEM OF THE CURRENT JAVA 	
}



######################################################  MAIN CODE STARTS FROM HERE ###########################################
echo -e "CHECKING THE SYSTEM!!!"
sleep 1

if(( $(isJavaInstalled) == "true" ))
then
	echo "Java Found. Do you want to replace current one?[Y/N]:"
	read choice
	echo "choice is $choice"

	if(( ${choice} == "Y" ))
	then 
		echo "removing the current java"	
		apt-get purge openjdk-\*
		begin;
		
	fi
else
	echo "No java found"
	begin;
fi 




