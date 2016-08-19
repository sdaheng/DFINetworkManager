//
//  NetworkService.m
//  DFINetworkManager
//
//  Created by SDH on 14/6/23.
//  Copyright (c) 2014年 SDH. All rights reserved.
//

#import "DFINetworkService.h"
#import "DFINetworkService-Protocol.h"
#import "DFINetworkAPIRequest.h"

@implementation DFINetworkService

+ (void)fetchDataByName:(NSString *)name Paramaters:(NSDictionary *)paramaters{
    
    id <DFINetworkServiceProtocol> interface = nil;
    
    id networkService = [[NSClassFromString(name) alloc] init];
    
    interface = networkService;
    
    if (interface && [interface respondsToSelector:@selector(fetchDataWithURLParamaters:)]) {
        [interface fetchDataWithURLParamaters:paramaters];
    }
}

+ (void)fetchDataByName:(NSString *)name
             Paramaters:(NSDictionary *)paramaters
               delegate:(id<DFINetworkServiceAPIRequestDelegate>)delegate{
    
    id <DFINetworkServiceProtocol> interface = nil;
    
    id networkService = [[NSClassFromString(name) alloc] init];
    
    interface = networkService;
    
    if (interface &&
        [interface respondsToSelector:@selector(fetchDataByName:Paramaters:delegate:)]) {
        
        [interface fetchDataWithURLParamaters:paramaters
                                     delegate:delegate];
    }
}

+ (void)fetchDataByName:(NSString *)name
             Paramaters:(NSDictionary *)paramaters
            resultBlock:(DFIAPIRequestResultBlock)result{
    
    id <DFINetworkServiceProtocol> interface = nil;
    
    id networkService = [[NSClassFromString(name) alloc] init];
    
    interface = networkService;
    
    if (interface &&
        [interface respondsToSelector:@selector(fetchDataWithURLParamaters:resultBlock:)]) {
        
        [interface fetchDataWithURLParamaters:paramaters
                                  resultBlock:^(id ret) {
                                      if (result) {
                                          result(ret);
                                      }
                                  }];
    }
}

+ (void)sendDataByName:(NSString *)name Paramaters:(NSDictionary *)paramaters{
    
    id <DFINetworkServiceProtocol> interface = nil;
    
    id networkService = [[NSClassFromString(name) alloc] init];
    
    interface = networkService;
    
    if (interface && [interface respondsToSelector:@selector(sendDataWithURLParamaters:)]) {
        [interface sendDataWithURLParamaters:paramaters];
    }
}

+ (void)sendDataByName:(NSString *)name
            Paramaters:(NSDictionary *)paramaters
              delegate:(id<DFINetworkServiceAPIRequestDelegate>)delegate{
    
    id <DFINetworkServiceProtocol> interface = nil;
    
    id networkService = [[NSClassFromString(name) alloc] init];
    
    interface = networkService;
    
    if (interface &&
        [interface respondsToSelector:@selector(sendDataWithURLParamaters:delegate:)]) {
        
        [interface sendDataWithURLParamaters:paramaters
                                    delegate:delegate];
    }
}

+ (void)sendDataByName:(NSString *)name
            Paramaters:(NSDictionary *)paramaters
           resultBlock:(DFIAPIRequestResultBlock)result{
    
    id <DFINetworkServiceProtocol> interface = nil;
    
    id networkService = [[NSClassFromString(name) alloc] init];
    
    interface = networkService;
    
    if (interface &&
        [interface respondsToSelector:@selector(sendDataWithURLParamaters:resultBlock:)]) {
        
        [interface sendDataWithURLParamaters:paramaters
                                 resultBlock:^(id ret) {
                                     if (result) {
                                         result(ret);
                                     }
                                 }];
    }
}

+ (void)cancelHTTPRequest {
    [DFINetworkAPIRequest cancelHTTPRequest];
}

+ (void)cancelDataRequest {
    [DFINetworkAPIRequest cancelDataRequest];
}

@end

@implementation DFINetworkService (Cache)

+ (NSUInteger)currentURLCacheMemoryUsage {
    return [[NSURLCache sharedURLCache] currentMemoryUsage];
}

+ (NSUInteger)currentURLCacheDiskUsage {
    return [[NSURLCache sharedURLCache] currentDiskUsage];
}

+ (void)setupCacheWithMemoryCapacity:(NSUInteger)memoryCapacity
                        diskCapacity:(NSUInteger)diskCapacity {
    [[NSURLCache sharedURLCache] setMemoryCapacity:memoryCapacity];
    [[NSURLCache sharedURLCache] setDiskCapacity:diskCapacity];
}

+ (void)clearCache {
    [[NSURLCache sharedURLCache] removeAllCachedResponses];
}

@end
