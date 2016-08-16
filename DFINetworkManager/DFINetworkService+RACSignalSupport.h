//
//  DFINetworkService+RACSignalSupport.h
//  DFINetworkManager
//
//  Created by SDH on 3/15/16.
//  Copyright © 2016 com.dazhongcun. All rights reserved.
//

#import "DFINetworkService.h"

#if __has_include(<ReactiveCocoa/ReactiveCocoa.h>)
#import <ReactiveCocoa/ReactiveCocoa.h>

@interface DFINetworkService (RACSignalSupport)

/**
 *  使用RACSignal的GET请求
 *
 *  @param name       具体的网络请求类的类名.
 *  @param paramaters 网络请求参数.
 *
 *  @return 带有返回结果的signal
 */
+ (RACSignal *)signalFetchDataByName:(NSString *)name
                          Paramaters:(NSDictionary *)paramaters;

/**
 *  使用RACSignal的POST请求
 *
 *  @param name       具体的网络请求类的类名.
 *  @param paramaters 网络请求参数.
 *
 *  @return 带有返回结果的signal
 */
+ (RACSignal *)signalSendDataByName:(NSString *)name
                         Paramaters:(NSDictionary *)paramaters;

@end
#endif

