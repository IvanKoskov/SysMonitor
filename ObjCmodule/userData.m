//
//  userData.m
//  SysMonitor
//
//  Created by Evan Matthew on 12/4/25.
//

#import "userData.h"
#import <Foundation/Foundation.h>

@implementation userData
//error:(NSError **)error
- (double)totalCapacityForVolumePath:(NSString *)volumePath  {
    NSFileManager *fileManager = [NSFileManager defaultManager];
    NSError * __autoreleasing *error = nil;
    
        // Ensure the path exists
    if (![fileManager fileExistsAtPath:volumePath]) {
        if (error) {
            *error = [NSError errorWithDomain:NSCocoaErrorDomain
                                         code:NSFileNoSuchFileError
                                     userInfo:@{NSLocalizedDescriptionKey: [NSString stringWithFormat:@"Volume path %@ does not exist", volumePath]}];
        }
        return 0.0;
    }
    
    // Get file system attributes
    NSDictionary *attributes = [fileManager attributesOfFileSystemForPath:volumePath error:error];
    if (!attributes) {
        return 0.0; // Error is set by attributesOfFileSystemForPath
    }
    
    NSNumber *totalSize = attributes[NSFileSystemSize];
    double totalSizeInGB = totalSize.doubleValue / (1024.0 * 1024.0 * 1024.0); // Convert bytes to GB
    return totalSizeInGB;
}

- (double)availableSpaceForVolumePath:(NSString *)volumePath  {
    NSFileManager *fileManager = [NSFileManager defaultManager];
    NSError * __autoreleasing *error = nil;
    
    // Ensure the path exists
    if (![fileManager fileExistsAtPath:volumePath]) {
        if (error) {
            *error = [NSError errorWithDomain:NSCocoaErrorDomain
                                         code:NSFileNoSuchFileError
                                     userInfo:@{NSLocalizedDescriptionKey: [NSString stringWithFormat:@"Volume path %@ does not exist", volumePath]}];
        }
        return 0.0;
    }
    
    // Get file system attributes
    NSDictionary *attributes = [fileManager attributesOfFileSystemForPath:volumePath error:error];
    if (!attributes) {
        return 0.0; // Error is set by attributesOfFileSystemForPath
    }
    
    NSNumber *freeSize = attributes[NSFileSystemFreeSize];
    double freeSizeInGB = freeSize.doubleValue / (1000.0 * 1000.0 * 1000.0); // Convert bytes to GB
    return freeSizeInGB;
}

- (double)totalCapacityForVolumePathFixed:(NSString *)volumePath  {
    NSFileManager *fileManager = [NSFileManager defaultManager];
    NSError * __autoreleasing *error = nil;
    
    // Validate input path
    if (!volumePath.length) {
        if (error) {
            *error = [NSError errorWithDomain:NSCocoaErrorDomain
                                         code:NSFileReadInvalidFileNameError
                                     userInfo:@{NSLocalizedDescriptionKey: @"Volume path is empty"}];
        }
        return 0.0;
    }
    
    // Ensure the path exists
    if (![fileManager fileExistsAtPath:volumePath]) {
        if (error) {
            *error = [NSError errorWithDomain:NSCocoaErrorDomain
                                         code:NSFileNoSuchFileError
                                     userInfo:@{NSLocalizedDescriptionKey: [NSString stringWithFormat:@"Volume path %@ does not exist", volumePath]}];
        }
        return 0.0;
    }
    
    // Get file system attributes
    NSDictionary *attributes = [fileManager attributesOfFileSystemForPath:volumePath error:error];
    if (!attributes) {
        return 0.0; // Error is set by attributesOfFileSystemForPath
    }
    
    NSNumber *totalSize = attributes[NSFileSystemSize];
    // Convert bytes to GB using decimal units (to match Disk Utility)
    double totalSizeInGB = totalSize.doubleValue / (1000.0 * 1000.0 * 1000.0);
    return totalSizeInGB;
}


- (NSString *)percentageOFHowMuchDiskSpaceIsUsed:(int)mode with:(int)usedSpace also:(int)totalSpace{
    
    int percentMode = 0;
    int generalVerbalMode = 1;
    unsigned long long percentageOfHowMuchSpaceIsTaken;
    
    if (mode == percentMode) {
        
        percentageOfHowMuchSpaceIsTaken = (100 * usedSpace) / totalSpace;
        
        if (percentageOfHowMuchSpaceIsTaken < 60) {
            return @"Less than 60% used";  // Less than 60% used
        } else if (percentageOfHowMuchSpaceIsTaken >= 60 && percentageOfHowMuchSpaceIsTaken < 80) {
            return @"60% - 79% used";  // 60% - 79% used
        } else if (percentageOfHowMuchSpaceIsTaken >= 80 && percentageOfHowMuchSpaceIsTaken < 90) {
            return @"80% - 89% used";  // 80% - 89% used
        } else {
            return @"More than 90% used";  // More than 90% used
        }
        
        
    } else if (mode == generalVerbalMode) {
        
        percentageOfHowMuchSpaceIsTaken = (100 * usedSpace) / totalSpace;
        
        if (percentageOfHowMuchSpaceIsTaken < 60) {
            return @"Good";  // Less than 60% used
        } else if (percentageOfHowMuchSpaceIsTaken >= 60 && percentageOfHowMuchSpaceIsTaken < 80) {
            return @"Moderate";  // 60% - 79% used
        } else if (percentageOfHowMuchSpaceIsTaken >= 80 && percentageOfHowMuchSpaceIsTaken < 90) {
            return @"Bad";  // 80% - 89% used
        } else {
            return @"Critical";  // More than 90% used
        }
    
    }
    
    else {
        
        return @"ERROR: could not find the mode";
        
    }
}

- (NSString *)isEncrypted:(NSString *)pathtoTheDrive {
    
    if (!pathtoTheDrive || [pathtoTheDrive length] == 0) {
        NSLog(@"Invalid path provided");
        return @"ERROR";
    }

    
    NSURL *url = [NSURL fileURLWithPath:pathtoTheDrive];
    NSError *error = nil;
    NSNumber *isEncryptedValue = nil;

    // Check if the volume is encrypted
    if (![url getResourceValue:&isEncryptedValue forKey:NSURLVolumeIsEncryptedKey error:&error]) {
        NSLog(@"Failed to get encryption status: %@", error.localizedDescription);
        return @"ERROR";
    }

    // Convert the result to a boolean and return as string
    BOOL isEncrypted = [isEncryptedValue boolValue];
    NSString *result = isEncrypted ? @"ON" : @"inactive";
    NSLog(@"Drive at %@ is encrypted: %@", pathtoTheDrive, result);
    
    return result;
}

@end
