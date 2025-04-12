//
//  Userfinder.h
//  SysMonitor
//
//  Created by Evan Matthew on 3/4/25.
//

#ifndef Userfinder_h
#define Userfinder_h

#include <stdio.h>
#include <pwd.h>
#include <unistd.h>
#include <sys/types.h>
#include <sys/mount.h>
#include "Userfinder.h"
#include "stdlib.h"
#include "string.h"
#include <sys/statvfs.h>
#include <sys/sysctl.h>

const char * userOnTheMac(void);
const char * modelOfTheMac(void);
double getTheTotalSpace(void);
const char * getTheMount(void);
long long get_used_disk_space(void);
const char * stateOfTheDisk(void);
const char * stateOfTheDiskInPercents(void);
const char * usersAll(void);
int usersAllSize(void);
#endif /* Userfinder_h */
