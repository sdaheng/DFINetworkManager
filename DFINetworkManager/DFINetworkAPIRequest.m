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
        case DFINetworkManagerHTTPGetRequest:
        {
            [self GETRequestWithUrl:URLString
                        resultBlock:resultBlock
                           delegate:delegate
                   notificationName:notificationName
                         paramaters:paramaters];
            break;
        }
        case DFINetworkManagerHTTPPostRequest:
        {
            [self POSTRequestWithURL:URLString
                          paramaters:paramaters
                            delegate:delegate
                    notificationName:notificationName
                         resultBlock:resultBlock];
            break;
        }
        case DFINetworkManagerHTTPHeadRequest:
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
         successBlock:^(id result) {
           [self handleRequestResult:resultBlock
                              result:result
                            delegate:delegate
                    notificationName:notificationName];

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
           success:^(id result) {

        [self handleRequestResult:resultBlock
                           result:result
                         delegate:delegate
                 notificationName:notificationName];
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
     success:^(id result) {
         [self handleRequestResult:resultBlock
                            result:result
                          delegate:delegate
                  notificationName:notificationName];
     }
     fail:^(NSError *error) {
         [self handleRequestError:error];
     }];
}

+ (void)sendDataToURL:(NSString *)URLString
           paramaters:(NSDictionary *)paramaters
        constructBody:(NSArray <NSData *> *)bodys
        bodyPartNames:(NSArray <NSString *> *)bodyPartNames
              success:(DFISuccessBlock)success
                 fail:(DFIFailBlock)fail {
    
    [DFINetworkHTTPRequestService sendDataToURL:URLString
                                     paramaters:paramaters
                                  constructBody:bodys
                                  bodyPartNames:bodyPartNames
                                        success:success
                                           fail:fail];
}

+ (void)handleRequestResult:(DFIAPIRequestResultBlock)resultBlock
                     result:(id)result
                   delegate:(id)delegate
           notificationName:(NSString *)notificationName {
    if (result) {
        if (notificationName) {
            
            NSDictionary *userInfo = @{kDFINetworkRequestResultKey : result};
            
            [[NSNotificationCenter defaultCenter] postNotificationName:notificationName
                                                                object:nil
                                                              userInfo:userInfo];
        }
        
        if (delegate &&
            [delegate respondsToSelector:@selector(networkAPIRequestResult:)]) {
            
            [delegate networkAPIRequestResult:result];
        }
        
        if (resultBlock) {
            resultBlock(result);
        }
    }
}

+ (void)cancelHTTPRequest {
    [DFINetworkHTTPRequestService cancelHTTPRequest];
}

+ (void)handleRequestError:(NSError *)error {
#ifdef DFIFoundation_H
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
