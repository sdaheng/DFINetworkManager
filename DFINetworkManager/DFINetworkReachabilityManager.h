//
//  DFINetworkReachablityManager.h
//  DFInfrastructure
//
//  Created by SDH on 4/13/15.
//  Copyright (c) 2015 com.dazhongcun. All rights reserved.
//

#import <Foundation/Foundation.h>

#import "DFINetworkManagerDefines.h"

DFI_NM_EXPORT NSString * const kDFINetworkReachabilityNotification;
DFI_NM_EXPORT NSString * const kDFINetworkReachabilityStatusKey;

typedef NS_ENUM(NSInteger, DFINetworkReachabilityStatus) {
    DFINetworkReachabilityStatusUnknown          = -1,
    DFINetworkReachabilityStatusNotReachable     = 0,
    DFINetworkReachabilityStatusReachableViaWWAN = 1,
    DFINetworkReachabilityStatusReachableViaWiFi = 2,
};

@interface DFINetworkReachabilityManager : NSObject

+ (void)startMonitorWithDomain:(NSString *)domain;

@end
