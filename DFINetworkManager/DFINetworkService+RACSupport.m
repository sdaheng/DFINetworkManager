//
//  DFINetworkService+RACSignalSupport.m
//  DFINetworkManager
//
//  Created by SDH on 3/15/16.
//  Copyright © 2016 com.dazhongcun. All rights reserved.
//

#import "DFINetworkService+RACSupport.h"

#import "DFINetworkServiceRACSupportProtocol.h"

#if __has_include(<ReactiveCocoa/ReactiveCocoa.h>)

#ifndef DFI_NETWORK_SERVICE_IMPLEMENT_METHOD_EXCEPTION
#   define DFI_NETWORK_SERVICE_IMPLEMENT_METHOD_EXCEPTION(sel)                                    \
        @throw [NSException exceptionWithName:@"DFINetworkService Protocol Method Not Implement"  \
                                     reason:[NSString stringWithFormat:@"%s NOT implement", #sel] \
                                   userInfo:nil];
#endif

@implementation DFINetworkService (RACSupport)

+ (RACSignal *)signalFetchDataByName:(NSString *)name
                          Paramaters:(NSDictionary *)paramaters{
    id <DFINetworkServiceRACSupportProtocol> interface = nil;
    
    id networkService = [[NSClassFromString(name) alloc] init];
    
    interface = networkService;
    
    if (interface &&
        [interface respondsToSelector:@selector(signalFetchDataWithURLParamaters:)]) {
        return [interface signalFetchDataWithURLParamaters:paramaters];
    } else {
        DFI_NETWORK_SERVICE_IMPLEMENT_METHOD_EXCEPTION(signalFetchDataWithURLParamaters:)
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
    } else {
        DFI_NETWORK_SERVICE_IMPLEMENT_METHOD_EXCEPTION(signalSendDataWithURLParamaters:)
    }
    
    return [RACSignal empty];
}

@end
#undef DFI_NETWORK_SERVICE_IMPLEMENT_METHOD_EXCEPTION
#endif
