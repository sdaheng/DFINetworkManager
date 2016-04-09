//
//  DFINetworkService+RACSignalSupport.m
//  DFInfrastructure
//
//  Created by SDH on 3/15/16.
//  Copyright © 2016 com.dazhongcun. All rights reserved.
//

#import "DFINetworkService+RACSignalSupport.h"

#ifdef PROJECT_SUPPORT_REACTIVECOCOA

#import "DFINetworkServiceRACSignalSupportInterface.h"

#endif

@implementation DFINetworkService (RACSignalSupport)

#ifdef REACTIVECOCOA_SUPPORT

+ (RACSignal *)signalFetchDataByName:(NSString *)name
                          Paramaters:(NSDictionary *)paramaters{
    id <DFINetworkServiceRACSignalSupportInterface> interface = nil;
    
    id networkService = [[NSClassFromString(name) alloc] init];
    
    interface = networkService;
    
    if (interface &&
        [interface respondsToSelector:@selector(signalFetchDataWithURLParamaters:)]) {
        return [interface signalFetchDataWithURLParamaters:paramaters];
    }
    
    return [RACSignal empty];
}

+ (RACSignal *)signalSendDataByName:(NSString *)name
                         Paramaters:(NSDictionary *)paramaters {
    
    id <DFINetworkServiceRACSignalSupportInterface> interface = nil;
    
    id networkService = [[NSClassFromString(name) alloc] init];
    
    interface = networkService;
    
    if (interface &&
        [interface respondsToSelector:@selector(signalSendDataWithURLParamaters:)]) {
        
        return [interface signalSendDataWithURLParamaters:paramaters];
    }
    
    return [RACSignal empty];
}

#endif

@end
