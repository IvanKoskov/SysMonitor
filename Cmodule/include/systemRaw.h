//
//  systemRaw.h
//  SysMonitor
//
//  Created by Evan Matthew on 22/4/25.
//

#ifndef systemRaw_h
#define systemRaw_h

#include <stdio.h>
#include <mach/vm_statistics.h>
#include <mach/mach_types.h>
#include <mach/mach_init.h>
#include <mach/mach_host.h>
#include "sys/sysctl.h"
#include <IOKit/IOKitLib.h>
#define _NullPar void
#define COMPLETED 0.001


unsigned long long ramFreeMemory(_NullPar);
unsigned long long ramUsedMemory(_NullPar);
unsigned long long totalRamMemory(_NullPar);

#endif
