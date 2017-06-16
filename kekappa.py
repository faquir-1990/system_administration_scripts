#!/usr/bin/env python
'''
Reinvent the wheel to feel how the inventor felt
'''


__author__="AlauddinRover @facebook.com/SyedAlauddinAhmedRover, Faquir Foysol"

import nmap   # for test purpose
import subprocess
import argparse # add commandline options in later versions
import time
import sys

 # decorative class and banners for colored console options. Bhung Bhang

class Color:
    HEADER = '\033[95m'
    BLUE = '\033[94m'
    GREEN = '\033[92m'
    YELLOW = '\033[93m'
    RED = '\033[91m'
    END = '\033[0m'
    BOLD = '\033[1m'
    UNDERLINE = '\033[4m'

header = Color.HEADER+'\033[1m'+\
'''*~*~*~*~*~*~*~*~*~*~*~*~*~*~*~**~*~**~*~*~*~*~*~*~*~*~*~*~*~*~*~*~*~\n\
Kekappa 0.1 ... An nmap automation  lauding Keka Ferdousy\n\
*~*~*~*~*~*~*~*~*~*~*~*~*~*~*~**~*~**~*~*~*~*~*~*~*~*~*~*~*~*~*~*~*~\
'''+Color.END

options = Color.BLUE+'\033[1m'+'''
    Make sure you run the script with root privilege\n
    Option             Scan Details\n\
      1.        Quick LAN scan for live hosts -sn[nonroot]\n\
      2.        Ping scan  -n -sP -PE -PA 21,23,80,3389[root, less time]\n\
      3.        Live hosts version scan -sV -A T4 [root, TAKES time]\n\
      4.        Live hosts OS scan -O [root, takes time, a LOT of time ]\n

'''+Color.END

# ---------------- Check if nmap in system ----------------------------

def check_nmap():
    # if on linux fire "$whereis nmap" else on nt fire "C:/>where nmap"
    # a python oneliner kung foo :P

    command = 'whereis' if sys.platform.startswith('linux') else 'where'
    try:
	subprocess.check_call([command, 'nmap'])
    except OSError as e:
	print e




# -------------- Automated nmap Scanning  Routines ----------------------




def ping_scan(ip, maP):

    print Color.GREEN+'\033[1m'+"running ping scan...."+Color.END

    start = time.time()
    result = maP.scan(hosts=ip+'/24', arguments='-n -sP -PE -PA21,23,80,3389')
    end = time.time()
    print "[+]scan time: %s seconds" %(end-start)
    return result



def quick_scan(ip):
    print Color.BLUE+'\033[1m'+"running quick scan........."+Color.END

    try:
        start = time.time()
        result = subprocess.check_output(['nmap', '-sn', '-T4', ip+'/24'])
        end = time.time()
        print "[+]scan time: %s seconds\n"%(end-start)
        return result.decode('utf-8')
    except subprocess.CalledProcessError as e:
        return e



def version_scan(ip):
    print Color.YELLOW+'\033[1m'+"version detection takes LONG LONG time... enjoy a Keka Tutorial"+Color.END

    try:
        start = time.time()
        result = subprocess.check_output(['nmap',ip+'/24','-sV', '-A', '-T4'])
        end = time.time()
        print "[+]scan time: %s seconds\n"%(end-start)
        return result.decode('utf-8')
    except subprocess.CalledProcessError as e:
        return e




def OS_scan(ip):
    print Color.RED+'\033[1m'+"OS scan needs LONG LONG LONG time.. Cook a Keka recipe"+Color.END
    try:
	start = time.time()
	result= subprocess.check_output(['nmap', '-O', ip+'/24'])
	end = time.time()
	print "[+]scan time: %s seconds" %(end-start)
    	return  result.decode('utf-8')
    except subprocess.CalledProcessError as e:
	return e

# a recursive print utility function
def print_details(dic):
    for key, val in dic.iteritems():
        if type(val) is dict:
            print_details(val)
        else:
#            print '{0}:{1}'.format(key,val)

            print   '{0}:{1}'.format(key,val).translate(None, '{}[]\'')




if __name__== "__main__":

    check_nmap()

    print  header
    print options
    res=[]

    ip = raw_input(Color.GREEN+"enter router/access point interface ip: ")
    opt = raw_input("scan option > "+Color.END)


    if opt == '1':
        res = quick_scan(ip)

    elif opt == '2':
        maP = nmap.PortScanner()
        result = ping_scan(ip, maP)
        print_details(result)

    elif opt == '3':
        res = version_scan(ip)

    elif opt == '4':
        res = OS_scan(ip)

    else:
        print "enter options between 1 to 4"

    print res
