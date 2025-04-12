//
//  userData.h
//  SysMonitor
//
//  Created by Evan Matthew on 12/4/25.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

@interface userData : NSObject

- (double)totalCapacityForVolumePath:(NSString *)volumePath;
- (double)availableSpaceForVolumePath:(NSString *)volumePath;
- (double)totalCapacityForVolumePathFixed:(NSString *)volumePath;
- (NSString *)percentageOFHowMuchDiskSpaceIsUsed:(int)mode with:(int)usedSpace also:(int)totalSpace;
- (NSString *)isEncrypted:(NSString *)pathtoTheDrive;

@end

NS_ASSUME_NONNULL_END
