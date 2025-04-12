//
//  Userfinder.c
//  SysMonitor
//
//  Created by Evan Matthew on 3/4/25.
//

#include "Userfinder.h"
#include "stdlib.h"
#include "string.h"
#include <sys/statvfs.h>
#include <sys/sysctl.h>


long long get_used_disk_space(void) {
    const char *path = "/";
    struct statvfs stat;
    
    // Get filesystem statistics
    if (statvfs(path, &stat) != 0) {
        perror("statvfs failed");
        return -1;  // Error occurred
    }

    // Calculate total space and free space in bytes
    long long total_space = stat.f_blocks * stat.f_frsize;
    long long free_space = stat.f_bfree * stat.f_frsize;
    
    // Calculate used space (total space - free space)
    long long used_space = total_space - free_space;

    // Convert used space to GB
  //  double used_space_gb = (double) used_space / (1024.0 * 1024.0 * 1024.0);
    double used_space_gb = (double) used_space / (1000.0 * 1000.0 * 1000.0);
    // Debugging: Print total, free, and used space
    printf("Total space: %lld GB, Free space: %lld GB, Used space: %f GB\n",
           total_space / (1024 * 1024 * 1024), free_space / (1024 * 1024 * 1024), used_space_gb);

    return used_space_gb;
}




const char * userOnTheMac(void) {
    
    system("ls"); //for debug
    
    struct passwd *pw = getpwuid(getuid());
    
    if (pw == NULL) { return NULL; }
    
    return pw->pw_gecos; }


const char * modelOfTheMac(void) {
    static char model[256];
    size_t len = sizeof(model);
    
    // Query the hw.model property
    if (sysctlbyname("hw.model", model, &len, NULL, 0) == -1) {
        return NULL; // Return NULL if the query fails
    }
    
    
    
    return model;
    
}


double getTheTotalSpace(void){
   
    struct statfs buf;

    // Get information about the root file system
    if (statfs("/", &buf) == -1) {
        perror("statfs");
        return 1;
    }

    // Calculate total storage capacity in GB
    long long total_space = (long long)buf.f_blocks * buf.f_bsize;
    //double total_space_gb = total_space / (1024.0 * 1024 * 1024);
    double total_space_gb = total_space / (1000.0 * 1000 * 1000);
    int result = (int) total_space_gb;
    return result;

}

const char* getTheMount(void) {
    static char buffer[256];
    struct statfs *mntbuf;
    int count = getmntinfo(&mntbuf, MNT_WAIT);
    
    if (count > 0) {
        // Find the root filesystem
        for (int i = 0; i < count; i++) {
            if (strcmp(mntbuf[i].f_mntonname, "/") == 0) {
                strncpy(buffer, mntbuf[i].f_mntfromname, sizeof(buffer)-1);
                buffer[sizeof(buffer)-1] = '\0';
                return buffer;
            }
        }
    }
    
    perror("Error getting drive name");
    return "ERROR GETTING DRIVE";
}

const char * stateOfTheDisk(void){
    // This will measure how much space is available
    const char *path = "/";
    unsigned long long percentageOfHowMuchSpaceIsTaken;
    struct statvfs stat;
    
    // Get filesystem statistics
    if (statvfs(path, &stat) != 0) {
        perror("statvfs failed");
        return "ERROR";  // Error occurred
    }

    // Calculate total space and free space in bytes
    long long total_space = stat.f_blocks * stat.f_frsize;
    long long free_space = stat.f_bfree * stat.f_frsize;
    
    // Calculate used space (total space - free space)
    long long used_space = total_space - free_space;

    // Convert used space to GB
    double used_space_gb = (double) used_space / (1024.0 * 1024.0 * 1024.0);
    
    // Calculate percentage of used space
    percentageOfHowMuchSpaceIsTaken = (100 * used_space) / total_space;
    
    // Classify the disk space usage based on percentage
    if (percentageOfHowMuchSpaceIsTaken < 60) {
        return "Good";  // Less than 60% used
    } else if (percentageOfHowMuchSpaceIsTaken >= 60 && percentageOfHowMuchSpaceIsTaken < 80) {
        return "Moderate";  // 60% - 79% used
    } else if (percentageOfHowMuchSpaceIsTaken >= 80 && percentageOfHowMuchSpaceIsTaken < 90) {
        return "Bad";  // 80% - 89% used
    } else {
        return "Critical";  // More than 90% used
    }
}



const char * stateOfTheDiskInPercents(void){
    // This will measure how much space is available
    const char *path = "/";
    unsigned long long percentageOfHowMuchSpaceIsTaken;
    struct statvfs stat;
    
    // Get filesystem statistics
    if (statvfs(path, &stat) != 0) {
        perror("statvfs failed");
        return "ERROR";  // Error occurred
    }

    // Calculate total space and free space in bytes
    long long total_space = stat.f_blocks * stat.f_frsize;
    long long free_space = stat.f_bfree * stat.f_frsize;
    
    // Calculate used space (total space - free space)
    long long used_space = total_space - free_space;

    // Convert used space to GB
    double used_space_gb = (double) used_space / (1024.0 * 1024.0 * 1024.0);
    
    // Calculate percentage of used space
    percentageOfHowMuchSpaceIsTaken = (100 * used_space) / total_space;
    
    // Classify the disk space usage based on percentage
    if (percentageOfHowMuchSpaceIsTaken < 60) {
        return "Less than 60% used";  // Less than 60% used
    } else if (percentageOfHowMuchSpaceIsTaken >= 60 && percentageOfHowMuchSpaceIsTaken < 80) {
        return "60% - 79% used";  // 60% - 79% used
    } else if (percentageOfHowMuchSpaceIsTaken >= 80 && percentageOfHowMuchSpaceIsTaken < 90) {
        return "80% - 89% used";  // 80% - 89% used
    } else {
        return "More than 90% used";  // More than 90% used
    }
}


const char * usersAll(void) {
    static char usersBuffer[4000];
    char line[256];                 // Temporary buffer for reading lines
    
    FILE *fp = popen("dscl . list /Users | grep -vE '^_|daemon|nobody|root'", "r");
    
    if (fp == NULL) {
        printf("Failed to run command\n");
        exit(1);
    }

    // Clear the buffer
    usersBuffer[0] = '\0';
    
    // Read the output a line at a time and concatenate
    while (fgets(line, sizeof(line), fp) != NULL) {
        strncat(usersBuffer, line, sizeof(usersBuffer) - strlen(usersBuffer) - 1);
    }

    // close the pipe
    pclose(fp);
 
    return usersBuffer;
}

int usersAllSize(void) {
    static char usersBuffer[4000];
    char line[256];                 // Temporary buffer for reading lines
    
    FILE *fp = popen("dscl . list /Users | grep -vE '^_|daemon|nobody|root'", "r");
    
    if (fp == NULL) {
        printf("Failed to run command\n");
        exit(1);
    }

    // Clear the buffer
    usersBuffer[0] = '\0';
    
    // Read the output a line at a time and concatenate
    while (fgets(line, sizeof(line), fp) != NULL) {
        strncat(usersBuffer, line, sizeof(usersBuffer) - strlen(usersBuffer) - 1);
    }

    // close the pipe
    pclose(fp);
 
    return sizeof(usersBuffer);
}
