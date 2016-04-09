//
//  DFINetworkReachablityManager.m
//  DFINetworkManager
//
//  Created by SDH on 4/13/15.
//  Copyright (c) 2015 com.dazhongcun. All rights reserved.
//

#import "DFINetworkReachabilityManager.h"
#import "AFNetworkReachabilityManager.h"

NSString * const kDFINetworkReachabilityNotification = @"kDFINetworkReachabilityNotification";
NSString * const kDFINetworkReachabilityStatusKey = @"kDFINetworkReachabilityStatusKey";

@implementation DFINetworkReachabilityManager

+ (void)startMonitorWithDomain:(NSString *)domain {

    AFNetworkReachabilityManager *manager = [AFNetworkReachabilityManager managerForDomain:domain];
    
    [manager setReachabilityStatusChangeBlock:^(AFNetworkReachabilityStatus status) {
        [[NSNotificationCenter defaultCenter] postNotificationName:kDFINetworkReachabilityNotification
                                                            object:nil
                                                          userInfo:@{kDFINetworkReachabilityStatusKey : @(status)}];
    }];
}

@end
