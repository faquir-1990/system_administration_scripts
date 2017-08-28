#!/bin/bash

# =======================================================
# "dim footani" is a simple bash script to automate
# uncompressing various archived files.
# I've added only the archives I need frequently. 
# install your favourite ones and edit the script. 
#    - Faquir Foysol 
#      August 27, 2017 Sunday (3:07PM) 
# A product of Shell Scripting Week [newbie scripts]  <3    
#=========================================================

function check_tools(){

    # check for installed archive utilities
    echo "checking for installed archive utilities...."
    for tool in tar unzip gunzip bunzip2 7za rar xz
        do
        # if binary -f(ile) is not in path
        if [ ! -f "/bin/$tool" ]  ; then
            echo -e "\e[31m$tool isn't installed "
        fi
        done
        echo -e "\e[0mchecking complete."
        echo
    return 0
    
    }




function unarchiving(){
    
    case $1 in
        # tar family
        *.tar)
                echo -e "\e[32muntarring $1\e[0m"
                tar -xvf  $1 
        ;;
        
        *.tbz2) 
                echo -e "\e[32muntarring $1\e[0m"
                tar -xvjf $1
        ;;
        
        *.tar.bz2)  
                echo -e "\e[32muntarring $1\e[0m"
                tar -xvjf $1
        ;;
        
        *.tar.gz)   
                echo -e "\e[32muntarring $1\e[0m"
                tar -xvzf $1
        ;;
        
        *.tgz)  
                echo -e "\e[32muntarring $1\e[0m"
                 tar -xvzf $1
        ;;

        # (bg)unzip family
        *.gz)   
                echo -e "\e[32m(bg)unzipping $1\e[0m"
                gunzip $1
        ;;
        
        *.bz2)  
                 echo -e "\e[32buntarring $1\e[0m"
                 bunzip2 $1
        ;;

        # zip family
        *.zip)  
                echo -e "\e[32munzipping $1\e[0m"
                unzip $1
        ;;

        .Z)     
            echo -e "\e[32munzipping $1\e[0m"
            uncompress $1
        ;;
        
        .7z)    
            echo -e "\e[32munzipping $1\e[0m"
            7za x $1
        ;;
        
        *)  echo "edit with your own utility tools."
      esac
      
    return 0
    
    }

if [ -f $1  ]; then
    unarchiving $1
else
    # might be the tool isn't installed or the path/file is invalid
    check_tools
    echo "or may be $1 does not exist.Check path or file"
fi



