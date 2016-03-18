#!/bin/bash

####################  THIS SCRIPT WILL INSTALL THE JAVA IN LINUX MACHINE WHEN EXECUTED 

###REQUIRED VAIRABLES 
installPath="/usr/local/java"
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


######################### WRITING CHANGES IN CONFIGURATION FILE /etc/profile #################################

function editFile() {

	configFile="/etc/profile"

	echo "################ Changes done by the jdk installing Script ######################################" >> $configFile
	echo "JAVA_HOME=$installPath/$jdkVer"		 >> $configFile
	echo 'JRE_HOME=$JAVA_HOME/jre'		 	 >> $configFile
	echo 'PATH=$PATH:$JAVA_HOME/bin:$JRE_HOME/bin' 	 >> $configFile
	echo "export JAVA_HOME"				 >> $configFile
	echo "export JRE_HOME"				 >> $configFile
	echo "export PATH"				 >> $configFile
}

##################### Informs your system where the java is installed in the system ##########################

function informLocation() {

	sudo update-alternatives --install "/usr/bin/java" "java" "$installPath/$jdkVer/jre/bin/java" 1
	sudo update-alternatives --install "/usr/bin/java" "java" "$installPath/$jdkVer/bin/java" 1
	sudo update-alternatives --install "/usr/bin/javac" "javac" "$installPath/$jdkVer/bin/javac" 1
	sudo update-alternatives --install "/usr/bin/javaws" "javaws" "$installPath/$jdkVer/bin/javaws" 1
}

########################## THIS FUNCTION WILL MAKE THE JAVA DEFAULT ##############
function makeDefault() {

	 echo "Making java default"
        update-alternatives --set java "$installPath/$jdkVer/jre/bin/java"
        update-alternatives --set javac "$installPath/$jdkVer/bin/javac"
        update-alternatives --set javaws "$installPath/$jdkVer/bin/javaws"

}
######################### THIS WILL BEGIN TO WRITE CHANGES ON THE SYSTEM ######################################

function begin() {
	
	echo "making directory $installPath"
 	mkdir -p $installPath
	
	cd $installPath
	echo "extracting jdk tar.gz into $installPath"
	tar -xvf $sourceFile

	getJdkVer
	
	###EDITING PROFILE CONFIG FILE
	
	echo "editing /etc/profile"
	editFile

	
	###Inform  Ubuntu Linux system where your Oracle Java JDK/JRE is Instaled
	
	echo "Informing the location of the jdk path to the system"
	informLocation




	#### MAING JAVA  DEFAULT  ##################
	makeDefault
	source /etc/profile
 
	if (( $(isJavaInstalled) == "true" ))
	then
		echo "java installed successfully"
		sleep 1
		java -version
	else
		echo "java failed to install"
	
	fi	
	  	
}



######################################################  MAIN CODE STARTS FROM HERE ###########################################
echo -e "CHECKING THE SYSTEM!!!"
sleep 1

if (( $(isJavaInstalled) == "true" ))
then
	echo "Java Found. Do you want to replace current one?[Y/N]:"
	read choice
	echo "choice is $choice"

	if (( ${choice} == "Y" ))
	then 
		echo "removing the current java"	
		apt-get purge openjdk-\*
		begin;
		
	fi
else
	echo "No java found"
	begin;
fi 




