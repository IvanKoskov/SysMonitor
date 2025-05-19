#!/bin/sh

#  scripts.sh
#  SysMonitor
#
#  Created by Evan Matthew on 13/4/25.
#

 find /Users/evan/testjson -type f -exec basename {} \; | awk -F. '{if (NF > 1) print $NF; else print "other"}' | sort | uniq -c 
