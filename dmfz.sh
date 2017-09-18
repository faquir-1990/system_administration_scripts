#!/bin/bash

# ================================================================================================================================
#		dmfz (in memory of singer Daktar Mahfuz of ATN Bangla) is an utility tool to monitor disk usage by the users in system
# 1.    run the script with sudo privilage that it can traverse the directories under root.
# 2.    change the `find` places according to your hdd topology
# 3.    output is colon separated for redability and it can be used with other utilities
# 4.    you can remove color outputs for more usability.
#
#       -Faquir Foysol (September 18,2017 Monday 11:30PM)
#            a product of  Shell Learning Good Days
# =================================================================================================================================



function diskuse(){

    GB=1024.00  #MB
    # cut by:       user, UId field 1, 3;        UID >= 10; pick user name  
    for usr in $(cut -d':' -f1,3 /etc/passwd | awk -F':' '$2 >=100 {print $1}')
        do
            
            # find user in followng locations,calculate space consumed
                disk=$(find / /usr /home /var -xdev -user $usr -type f -ls | \
                    awk '
                        {total += $7} END {print total/(1024*1024)}  

                        ') # end of awk script
                # two float points. bc -l calls math library. safe game huh !! 

                if_GB=$(echo "scale=3; $disk >= $GB" | bc -l )
                
                if [ "$if_GB" -eq 1 ] ; then
                    gb=$(echo "scale=2; $disk / 1024" |bc -l)  # convert to Gib
                    echo -e "\e[95m\e[1m$usr:$gb Gib\e[0m"
                else                  
                    echo -e "$usr:$disk Mb"      

                fi
        done
    
 }

echo -e "\e[1m\e[32muser:diskusage\e[0m"
diskuse

exit 0

