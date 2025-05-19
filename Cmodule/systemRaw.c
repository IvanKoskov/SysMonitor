//
//  systemRaw.c
//  SysMonitor
//
//  Created by Evan Matthew on 22/4/25.
//

#include "systemRaw.h"


unsigned long long ramFreeMemory(_NullPar){
    
    vm_size_t page_size;
       mach_port_t mach_port;
       mach_msg_type_number_t count;
       vm_statistics64_data_t vm_stats;

       mach_port = mach_host_self();
       count = sizeof(vm_stats) / sizeof(natural_t);
       if (KERN_SUCCESS == host_page_size(mach_port, &page_size) &&
           KERN_SUCCESS == host_statistics64(mach_port, HOST_VM_INFO,
                                           (host_info64_t)&vm_stats, &count))
       {
           long long free_memory = ((int64_t)vm_stats.free_count + (int64_t)vm_stats.inactive_count) * (int64_t)page_size;
           printf("%lld free of memory on this Mac", free_memory);
          // return free_memory; //bytes
           return free_memory / (1024 * 1024); //mb
       }

    fprintf(stderr, "Error: Failed to retrieve total memory\n");
    return 1;
}

unsigned long long ramUsedMemory(_NullPar){
    
    vm_size_t page_size;
    mach_port_t mach_port;
    mach_msg_type_number_t count;
    vm_statistics64_data_t vm_stats;

    mach_port = mach_host_self();
    count = sizeof(vm_stats) / sizeof(natural_t);
    if (KERN_SUCCESS == host_page_size(mach_port, &page_size) &&
        KERN_SUCCESS == host_statistics64(mach_port, HOST_VM_INFO,
                                        (host_info64_t)&vm_stats, &count))
    {
        long long used_memory = ((int64_t)vm_stats.active_count + (int64_t)vm_stats.wire_count) * (int64_t)page_size;
        printf("%lld MB used memory on this Mac\n", used_memory / (1024 * 1024));
        return used_memory / (1024 * 1024); // Returns used memory in MB
    }
    
    fprintf(stderr, "Error: Failed to retrieve total memory\n");
    return 1;
}


unsigned long long totalRamMemory(_NullPar){
    
        
        int mib[2] = {CTL_HW, HW_MEMSIZE};
        uint64_t total_memory = 0;
        size_t length = sizeof(total_memory);

        if (sysctl(mib, 2, &total_memory, &length, NULL, 0) == 0) {
            printf("%llu MB total memory on this Mac\n", total_memory / (1024 * 1024));
            return total_memory / (1024 * 1024); // MB
        }

    fprintf(stderr, "Error: Failed to retrieve total memory\n");
    return 1;
}



