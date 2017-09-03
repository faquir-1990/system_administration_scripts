#!/bin/bash

#============================================README==============================================================
# 0. Gowtom the Guradian (gtg) is a basic system monitoring cronjob tool
# 1. Under development script for logging system and hdd temperature, following auto shutdown if core temperature
#   is greater the average of high and critical
#
# 2. Macros would vary on systems and processor specs. 
#
# 3. As shell deals with integers only, use bc (bash calculator)- a tiny scripting language
#   to do direct float calculations  hassle-free. 
#   scale=2 use two digits after '.' 
# 4. And obviously you need to customise the script for better performance. 
# 5. Make sure you've installed sensors, hddtemp and bc (check your package manager)
# *** BUG:currently hdd temperature is not being logged in. delete log deletes all logs 
      rather than oly this script's one.
#
#      -Faquir Foysol on  August 24,2017, Thursday 3:51 PM (A product of Shell Learning Good Days)
#================================================================================================================
# Macros
CORE_HIGH=86.0
CORE_CRIT=100.0
CPU_HIGH=60.0
CPU_CRIT=95.0
CORE_WARN_TEMP=$(echo "scale=2;($CORE_HIGH+$CORE_CRIT)/2" | bc)
# echo $CORE_WARN_TEMP
CPU_SHUT_TEMP=$(echo "scale=2;($CPU_HIGH+$CPU_CRIT)/2" | bc)
# echo $CPU_SHUT_TEMP
LOG_FILE='/home/faquir/userlogs/temperature.log'
# ======================== Main Script ==================================
function log_temperature(){
        CPU=`sensors | grep -e 'CPU Temperature'| awk '{print $3}'| sed 's/[^0-9\.]//g'`
        # echo $CPU
        
        # `` and $() are same
        core0=`sensors | grep -e 'Core 0'| awk '{print $3}'| sed 's/[^0-9\.]//g'`
        core1=$(sensors | grep -e 'Core 1'| awk '{print $3}'| sed 's/[^0-9\.]//g')
        # echo $core1 
        
        hdisk=`hddtemp /dev/sda `
        
        fan_speed=`sensors | grep -e 'CPU FAN'| awk '{print $4}'| sed 's/[^0-9\.]//g'`
        # echo $fan_speed
        
        #=============================== Print into log file =========================
        
        printf "$(date +'%d/%m/%Y %r')[summary]: Main CPU: %.1f°C core_1: %.1f°C core_2: %.1f°C disk:%s cpu_fan: $fan_speed RPM\n" $CPU $core0 $core1 $hdisk >> $LOG_FILE
        
        # =================== Check Temperatures for Special Action ================
        
        if [ $(echo "$core0 >= $CORE_WARN_TEMP" | bc) -eq 1 ] || \
           [ $(echo "$core1 >= $CORE_WARN_TEMP" | bc) -eq 1 ]; then
                printf  "\e[31m$(date +'%d/%m/%Y %r')[WARNING] core temperature high\
                core0: $core0 core1: $core1\e[0m\n" >> $LOG_FILE
        fi
        
        
        if [ $(echo "$CPU >= $CPU_SHUT_TEMP" | bc) -eq 1 ]
            then
            printf "\e[31m$(date +'%d/%m/%Y %r') [WARNING] CPU temperature high\
            $CPU'C shutting down\e[0m\n" >> $LOG_FILE
            # shutdown box. If Debian use root user in cron job to fire up shutdown
            init 0
        fi
}
function delete_log(){
    
    # remove all logs older than 2 days [needs optimisation]
    find /home/faquir/userlog* -mtime +2 -exec rm {} \;
}
log_temperature
delete_log
