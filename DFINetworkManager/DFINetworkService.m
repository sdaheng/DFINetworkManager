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
#import "DFINetworkHTTPRequestService.h"

@implementation DFINetworkService

+ (void)fetchDataByName:(NSString *)name Paramaters:(NSDictionary *)paramaters {
    
    id <DFINetworkServiceProtocol> interface = nil;
    
    id networkService = [[NSClassFromString(name) alloc] init];
    
    interface = networkService;
    
    if (interface && [interface respondsToSelector:@selector(fetchDataWithURLParamaters:)]) {
        [interface fetchDataWithURLParamaters:paramaters];
    }
}

+ (void)fetchDataByName:(NSString *)name
             Paramaters:(NSDictionary *)paramaters
               delegate:(id<DFINetworkServiceAPIRequestDelegate>)delegate {
    
    id <DFINetworkServiceProtocol> interface = nil;
    
    id networkService = [[NSClassFromString(name) alloc] init];
    
    interface = networkService;
    
    if (interface &&
        [interface respondsToSelector:@selector(fetchDataWithURLParamaters:delegate:)]) {
        
        [interface fetchDataWithURLParamaters:paramaters
                                     delegate:delegate];
    }
}

+ (void)fetchDataByName:(NSString *)name
             Paramaters:(NSDictionary *)paramaters
            resultBlock:(DFIAPIRequestResultBlock)result {
    
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

+ (void)sendDataByName:(NSString *)name Paramaters:(NSDictionary *)paramaters {
    
    id <DFINetworkServiceProtocol> interface = nil;
    
    id networkService = [[NSClassFromString(name) alloc] init];
    
    interface = networkService;
    
    if (interface && [interface respondsToSelector:@selector(sendDataWithURLParamaters:)]) {
        [interface sendDataWithURLParamaters:paramaters];
    }
}

+ (void)sendDataByName:(NSString *)name
            Paramaters:(NSDictionary *)paramaters
              delegate:(id<DFINetworkServiceAPIRequestDelegate>)delegate {
    
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
           resultBlock:(DFIAPIRequestResultBlock)result {
    
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

@end

@implementation DFINetworkService (DataRequest)

+ (void)uploadDataToURL:(NSString *)URLString
               withData:(NSData *)data
          progressBlock:(void(^)(double progress, int64_t totalCountUnit))progressBlock
           successBlock:(DFISuccessBlock)successBlock
              failBlock:(DFIFailBlock)failBlock {
    
    [DFINetworkHTTPRequestService uploadDataToURL:URLString
                                         withData:data
                                    progressBlock:progressBlock
                                     successBlock:successBlock
                                        failBlock:failBlock];
}

+ (void)downloadDataWithURL:(NSString *)URLString
                destination:(NSString *)filePath
              progressBlock:(void(^)(double progress, int64_t totalCountUnit))progressBlock
               successBlock:(DFISuccessBlock)successBlock
                  failBlock:(DFIFailBlock)failBlock {
    
    [DFINetworkHTTPRequestService downloadWithURL:URLString
                              destinationFilePath:filePath
                                    progressBlock:progressBlock
                                     successBlock:successBlock
                                        failBlock:failBlock];
}

+ (void)cancelDataRequest {
    [DFINetworkHTTPRequestService cancelDataRequest];
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

@implementation DFINetworkService (Log)

+ (void)setEnableLogRequest:(BOOL)enableLog {
    [DFINetworkHTTPRequestService setEnableLogRequest:enableLog];
}

+ (void)setEnableLogResult:(BOOL)enableLog {
    [DFINetworkHTTPRequestService setEnableLogResult:enableLog];
}

@end
