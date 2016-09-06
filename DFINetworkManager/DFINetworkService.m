//
//  NetworkService.m
//  DFINetworkManager
//
//  Created by SDH on 14/6/23.
//  Copyright (c) 2014年 SDH. All rights reserved.
//

#import "DFINetworkService.h"
#import "DFINetworkServiceProtocol.h"
#import "DFINetworkAPIRequest.h"
#import "DFINetworkHTTPRequestService.h"
#import "DFINetworkHTTPRequestService+Log.h"
#import "DFINetworkHTTPConfiguration.h"

#ifndef DFI_NETWORK_SERVICE_IMPLEMENT_METHOD_EXCEPTION
#   define DFI_NETWORK_SERVICE_IMPLEMENT_METHOD_EXCEPTION(sel)                                      \
        @throw [NSException exceptionWithName:@"DFINetworkService Protocol Method Not Implement"    \
                                       reason:[NSString stringWithFormat:@"%s NOT implement", #sel] \
                                     userInfo:nil];
#endif

@implementation DFINetworkService

+ (void)fetchDataByName:(NSString *)name Paramaters:(NSDictionary *)paramaters {
    
    id <DFINetworkServiceProtocol> interface = [[NSClassFromString(name) alloc] init];

    if (interface && [interface respondsToSelector:@selector(fetchDataWithURLParamaters:)]) {
        [interface fetchDataWithURLParamaters:paramaters];
    } else {
        DFI_NETWORK_SERVICE_IMPLEMENT_METHOD_EXCEPTION(fetchDataWithURLParamaters:)
    }
}

+ (void)fetchDataByName:(NSString *)name
             Paramaters:(NSDictionary *)paramaters
               delegate:(id<DFINetworkServiceAPIRequestDelegate>)delegate {
    
    id <DFINetworkServiceProtocol> interface = [[NSClassFromString(name) alloc] init];
    
    if (interface &&
        [interface respondsToSelector:@selector(fetchDataWithURLParamaters:delegate:)]) {
        
        [interface fetchDataWithURLParamaters:paramaters
                                     delegate:delegate];
    } else {
        DFI_NETWORK_SERVICE_IMPLEMENT_METHOD_EXCEPTION(fetchDataWithURLParamaters:delegate:)
    }
}

+ (void)fetchDataByName:(NSString *)name
             Paramaters:(NSDictionary *)paramaters
            resultBlock:(DFIAPIRequestResultBlock)result {
    
    id <DFINetworkServiceProtocol> interface = [[NSClassFromString(name) alloc] init];

    if (interface &&
        [interface respondsToSelector:@selector(fetchDataWithURLParamaters:resultBlock:)]) {
        
        [interface fetchDataWithURLParamaters:paramaters
                                  resultBlock:result];
    } else {
        DFI_NETWORK_SERVICE_IMPLEMENT_METHOD_EXCEPTION(fetchDataWithURLParamaters:resultBlock:)
    }
}

+ (void)sendDataByName:(NSString *)name Paramaters:(NSDictionary *)paramaters {
    
    id <DFINetworkServiceProtocol> interface = [[NSClassFromString(name) alloc] init];
    
    if (interface && [interface respondsToSelector:@selector(sendDataWithURLParamaters:)]) {
        [interface sendDataWithURLParamaters:paramaters];
    } else {
        DFI_NETWORK_SERVICE_IMPLEMENT_METHOD_EXCEPTION(sendDataWithURLParamaters:)
    }
}

+ (void)sendDataByName:(NSString *)name
            Paramaters:(NSDictionary *)paramaters
              delegate:(id<DFINetworkServiceAPIRequestDelegate>)delegate {
    
    id <DFINetworkServiceProtocol> interface = [[NSClassFromString(name) alloc] init];

    if (interface &&
        [interface respondsToSelector:@selector(sendDataWithURLParamaters:delegate:)]) {
        
        [interface sendDataWithURLParamaters:paramaters
                                    delegate:delegate];
    } else {
        DFI_NETWORK_SERVICE_IMPLEMENT_METHOD_EXCEPTION(sendDataWithURLParamaters:delegate:)
    }
}

+ (void)sendDataByName:(NSString *)name
            Paramaters:(NSDictionary *)paramaters
           resultBlock:(DFIAPIRequestResultBlock)result {
    
    id <DFINetworkServiceProtocol> interface = [[NSClassFromString(name) alloc] init];

    if (interface &&
        [interface respondsToSelector:@selector(sendDataWithURLParamaters:resultBlock:)]) {
        
        [interface sendDataWithURLParamaters:paramaters
                                 resultBlock:result];
    } else {
        DFI_NETWORK_SERVICE_IMPLEMENT_METHOD_EXCEPTION(sendDataWithURLParamaters:resultBlock:)
    }
}

+ (void)cancelHTTPRequest {
    [DFINetworkAPIRequest cancelHTTPRequest];
}

@end
#undef DFI_NETWORK_SERVICE_IMPLEMENT_METHOD_EXCEPTION

@implementation DFINetworkService (DataRequest)

+ (void)uploadDataToURL:(NSString *)URLString
               withData:(NSData *)data
          progressBlock:(void(^)(double progress, int64_t totalCountUnit))progressBlock
           successBlock:(DFINetworkRequestSuccessBlock)successBlock
              failBlock:(DFINetworkRequestFailBlock)failBlock {
    
    [DFINetworkHTTPRequestService uploadDataToURL:URLString
                                         withData:data
                                    progressBlock:progressBlock
                                     successBlock:successBlock
                                        failBlock:failBlock];
}

+ (void)downloadDataWithURL:(NSString *)URLString
                destination:(NSString *)filePath
              progressBlock:(void(^)(double progress, int64_t totalCountUnit))progressBlock
               successBlock:(DFINetworkRequestSuccessBlock)successBlock
                  failBlock:(DFINetworkRequestFailBlock)failBlock {
    
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

@implementation DFINetworkService (Configuration)

+ (void)setHTTPNetworkServiceConfiguration:(DFINetworkHTTPConfiguration *)configuration {
    [DFINetworkHTTPRequestService setHTTPRequestConfiguration:configuration];
}

+ (void)setHTTPSNetworkServiceConfiguration:(DFINetworkHTTPSecurityConfiguration *)configuration {
    [DFINetworkHTTPRequestService setHTTPSRequestConfiguration:configuration];
}

@end

@implementation DFINetworkService (Cache)

+ (void)enableURLCache:(BOOL)enableURLCache {
    [DFINetworkHTTPRequestService setEnableCache:enableURLCache];
}

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
