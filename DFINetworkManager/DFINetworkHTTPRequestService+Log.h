//
//  DFINetworkHTTPRequestService+Log.h
//  DFINetworkManager
//
//  Created by sdaheng on 16/8/22.
//  Copyright © 2016年 sdaheng. All rights reserved.
//

#import "DFINetworkHTTPRequestService.h"

@interface DFINetworkHTTPRequestService (Log)

+ (void)setEnableLogRequest:(BOOL)enableLog;
+ (void)setEnableLogResult:(BOOL)enableLog;

@end
