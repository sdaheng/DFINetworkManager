//
//  NetworkAPIRequest.m
//  DFINetworkManager
//
//  Created by SDH on 14-9-25.
//  Copyright (c) 2014年 SDH. All rights reserved.
//

#import "DFINetworkService.h"
#import "DFINetworkHTTPRequestService.h"
#import "DFINetworkAPIRequest.h"

#import <objc/runtime.h>

#if __has_include(<DFIFoundation/DFIFounation.h>)
#import <DFIFoundation/DFIFoundation.h>
#else
#import "DFINetworkNotificationNames.h"
#endif

NSString * const kDFINetworkRequestResultKey = @"kDFINetworkRequestResultKey";

@interface DFINetworkAPIRequest ()

@end

@implementation DFINetworkAPIRequest

+ (void)requestWithURL:(NSString *)URLString
            paramaters:(NSDictionary *)paramaters
           requestType:(DFINetworkManagerRequestType)requestType
      notificationName:(NSString *)notificationName {
    
    [self requestWithURL:URLString
              paramaters:paramaters
             requestType:requestType
        notificationName:notificationName
                delegate:nil
             resultBlock:nil];
}

+ (void)requestWithURL:(NSString *)URLString
            paramaters:(NSDictionary *)paramaters
           requestType:(DFINetworkManagerRequestType)requestType
              delegate:(id<DFINetworkServiceAPIRequestDelegate>)delegate {
    
    [self requestWithURL:URLString
              paramaters:paramaters
             requestType:requestType
        notificationName:nil
                delegate:delegate
             resultBlock:nil];
}

+ (void)requestWithURL:(NSString *)URLString
            paramaters:(NSDictionary *)paramaters
           requestType:(DFINetworkManagerRequestType)requestType
           resultBlock:(DFIAPIRequestResultBlock)resultBlock {
    
    [self requestWithURL:URLString
              paramaters:paramaters
             requestType:requestType
        notificationName:nil
                delegate:nil
             resultBlock:resultBlock];
}

+ (void)requestWithURL:(NSString *)URLString
            paramaters:(NSDictionary *)paramaters
           requestType:(DFINetworkManagerRequestType)requestType
      notificationName:(NSString *)notificationName
              delegate:(id<DFINetworkServiceAPIRequestDelegate>)delegate
           resultBlock:(DFIAPIRequestResultBlock)resultBlock {
    
    switch (requestType) {
        case DFINetworkManagerHTTPGETRequest:
        {
            [self GETRequestWithUrl:URLString
                        resultBlock:resultBlock
                           delegate:delegate
                   notificationName:notificationName
                         paramaters:paramaters];
            break;
        }
        case DFINetworkManagerHTTPPOSTRequest:
        {
            [self POSTRequestWithURL:URLString
                          paramaters:paramaters
                            delegate:delegate
                    notificationName:notificationName
                         resultBlock:resultBlock];
            break;
        }
        case DFINetworkManagerHTTPHEADRequest:
        {
            [self HEADRequestWithUrl:URLString
                         resultBlock:resultBlock
                            delegate:delegate
                    notificationName:notificationName
                          paramaters:paramaters];
        }
        default:
            break;
    }
}

+ (void)GETRequestWithUrl:(NSString *)URLString
              resultBlock:(DFIAPIRequestResultBlock)resultBlock
                 delegate:(id)delegate
         notificationName:(NSString *)notificationName
               paramaters:(NSDictionary *)paramaters {
    [DFINetworkHTTPRequestService
     fetchDataFromURL:URLString
           paramaters:paramaters
         successBlock:^(NSURLSessionDataTask *task, id result) {
             [self handleRequestTask:task
                              result:result
                            delegate:delegate
                    notificationName:notificationName
                         resultBlock:resultBlock];
       } failBlock:^(NSError *error) {
           [self handleRequestError:error];
       }];
}

+ (void)POSTRequestWithURL:(NSString *)URLString
                paramaters:(NSDictionary *)paramaters
                  delegate:(id)delegate
          notificationName:(NSString *)notificationName
               resultBlock:(DFIAPIRequestResultBlock)resultBlock {
    [DFINetworkHTTPRequestService
     sendDataToURL:URLString
        paramaters:paramaters
           success:^(NSURLSessionDataTask *sessionDataTask, id result) {
           [self handleRequestTask:sessionDataTask
                            result:result
                          delegate:delegate
                  notificationName:notificationName
                       resultBlock:resultBlock];
    } fail:^(NSError *error) {
        [self handleRequestError:error];
    }];
}

+ (void)HEADRequestWithUrl:(NSString *)URLString
              resultBlock:(DFIAPIRequestResultBlock)resultBlock
                 delegate:(id)delegate
         notificationName:(NSString *)notificationName
               paramaters:(NSDictionary *)paramaters {
    
    [DFINetworkHTTPRequestService
     headDataToURL:URLString
     paramaters:paramaters
     success:^(NSURLSessionDataTask *sessionDataTask, id result) {
         [self handleRequestTask:sessionDataTask
                          result:result
                        delegate:delegate
                notificationName:notificationName
                     resultBlock:resultBlock];
     }
     fail:^(NSError *error) {
         [self handleRequestError:error];
     }];
}

+ (void)sendDataToURL:(NSString *)URLString
           paramaters:(NSDictionary *)paramaters
        constructBody:(NSArray <NSData *> *)bodys
        bodyPartNames:(NSArray <NSString *> *)bodyPartNames
              success:(DFIAPIRequestResultBlock)success
                 fail:(DFINetworkRequestFailBlock)fail {
    
    [DFINetworkHTTPRequestService sendDataToURL:URLString
                                     paramaters:paramaters
                                  constructBody:bodys
                                  bodyPartNames:bodyPartNames
                                        success:^(NSURLSessionDataTask *task, id result) {
                                            success ? success(result) : nil;
                                        } fail:fail];
}

+ (void)handleRequestTask:(NSURLSessionDataTask *)task
                   result:(id)result
                 delegate:(id)delegate
         notificationName:(NSString *)notificationName
              resultBlock:(DFIAPIRequestResultBlock)resultBlock {
    if (notificationName) {
        
        NSDictionary *userInfo = @{kDFINetworkRequestResultKey : result ? : [NSNull null]};
        
        [[NSNotificationCenter defaultCenter] postNotificationName:notificationName
                                                            object:nil
                                                          userInfo:userInfo];
    }
    
    if (delegate &&
        [delegate respondsToSelector:@selector(networkAPIRequestTask:result:)]) {
        
        [delegate networkAPIRequestTask:task
                                 result:result];
    }
    
    if (resultBlock) {
        resultBlock(result);
    }
}

+ (void)cancelHTTPRequest {
    [DFINetworkHTTPRequestService cancelHTTPRequest];
}

+ (void)handleRequestError:(NSError *)error {
#if __has_include(<DFIFoundation/DFIFoundation.h>)
    [DFIErrorHandler handleErrorWithHandlerName:@"DFINetworkTimeoutErrorHandler"
                                          error:error];
    
    [DFIErrorHandler handleErrorWithHandlerName:@"DFINetworkCannotConnectToHostErrorHandler"
                                          error:error];
#else
    if (error.code == NSURLErrorTimedOut) {
        
        [[NSNotificationCenter defaultCenter]
         postNotificationName:kDFINetworkRequestTimeoutErrorNotification
                        object:nil];
        
    }else if (error.code == NSURLErrorCannotConnectToHost) {
        
        [[NSNotificationCenter defaultCenter]
         postNotificationName:kDFINetworkRequestCannotConnectHostErrorNotification
                        object:nil];
    }
    
#endif
}

@end
