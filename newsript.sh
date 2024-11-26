#!/bin/bash


######################################################
# Author : Sahil
# Date: 26/11/2024
#
# Ths script outputs the node health
#
# Version: V1
######################################################

set -x 		# debug mode
set -e 		# exit the script when there is an error
set -o pipefail # exit script upon pipe errors

df -h

free -g

nproc

ps -ef | grep python | awk -F" " '{print $2}' 
