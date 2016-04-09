//
//  DFINetworkServiceRACSignalSupportInterface.h
//  DFINetworkManager
//
//  Created by SDH on 3/15/16.
//  Copyright © 2016 com.dazhongcun. All rights reserved.
//

#import <Foundation/Foundation.h>

#if PROJECT_SUPPORT_REACTIVECOCOA && __has_include(<ReactiveCocoa/ReactiveCocoa.h>)
#import <ReactiveCocoa/ReactiveCocoa.h>
#endif

@protocol DFINetworkServiceRACSignalSupportInterface <NSObject>

#ifdef PROJECT_SUPPORT_REACTIVECOCOA

- (RACSignal *)signalFetchDataWithURLParamaters:(NSDictionary *)paramaters;

- (RACSignal *)signalSendDataWithURLParamaters:(NSDictionary *)paramaters;

#endif

@end
