//
//  DFINetworkService+RACSignalSupport.m
//  DFINetworkManager
//
//  Created by SDH on 3/15/16.
//  Copyright © 2016 com.dazhongcun. All rights reserved.
//

#import "DFINetworkService+RACSupport.h"

#import "DFINetworkServiceRACSupport-Protocol.h"

#if __has_include(<ReactiveCocoa/ReactiveCocoa.h>)

@implementation DFINetworkService (RACSupport)

+ (RACSignal *)signalFetchDataByName:(NSString *)name
                          Paramaters:(NSDictionary *)paramaters{
    id <DFINetworkServiceRACSupportProtocol> interface = nil;
    
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
    
    id <DFINetworkServiceRACSupportProtocol> interface = nil;
    
    id networkService = [[NSClassFromString(name) alloc] init];
    
    interface = networkService;
    
    if (interface &&
        [interface respondsToSelector:@selector(signalSendDataWithURLParamaters:)]) {
        
        return [interface signalSendDataWithURLParamaters:paramaters];
    }
    
    return [RACSignal empty];
}

@end
#endif
