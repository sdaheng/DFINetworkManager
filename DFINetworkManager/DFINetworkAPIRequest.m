//
//  NetworkAPIRequest.m
//  PropertyHousekeeper
//
//  Created by 包光晖 on 14-9-25.
//  Copyright (c) 2014年 包光晖. All rights reserved.
//

#import "DFINetworkService.h"
#import "DFINetworkServiceInterface.h"
#import "DFINetworkHTTPRequestService.h"
#import "DFINetworkAPIRequest.h"

#import <objc/runtime.h>

#if __has_include(<DFIFoundation/DFIFounation.h>)
#import <DFIFoundation/DFIFoundation.h>
#else
#import "DFINetworkNotificationNames.h"
#endif

NSString * const kDFINetworkRequestResultKey = @"kDFINetworkRequestResultKey";

@implementation DFINetworkAPIRequest

+ (void)requestWithURL:(NSString *)url
            paramaters:(NSDictionary *)paramaters
           requestType:(DFINetworkManagerRequestType)requestType
      notificationName:(NSString *)notificationName{
    
    [self requestWithURL:url
              paramaters:paramaters
             requestType:requestType
        notificationName:notificationName
                delegate:nil
             resultBlock:nil];
}

+ (void)requestWithURL:(NSString *)url
            paramaters:(NSDictionary *)paramaters
           requestType:(DFINetworkManagerRequestType)requestType
              delegate:(id<DFINetworkServiceAPIRequestDelegate>)delegate{
    
    [self requestWithURL:url
              paramaters:paramaters
             requestType:requestType
        notificationName:nil
                delegate:delegate
             resultBlock:nil];
}

+ (void)requestWithURL:(NSString *)url
            paramaters:(NSDictionary *)paramaters
           requestType:(DFINetworkManagerRequestType)requestType
           resultBlock:(resultBlock)resultBlock{
    
    [self requestWithURL:url
              paramaters:paramaters
             requestType:requestType
        notificationName:nil
                delegate:nil
             resultBlock:resultBlock];
}

+ (void)requestWithURL:(NSString *)url
            paramaters:(NSDictionary *)paramaters
           requestType:(DFINetworkManagerRequestType)requestType
      notificationName:(NSString *)notificationName
              delegate:(id<DFINetworkServiceAPIRequestDelegate>)delegate
           resultBlock:(resultBlock)resultBlock{
    
    @try {
        switch (requestType) {
            case DFINetworkManagerHTTPGetRequest:
            {
                [self GETRequestWithUrl:url
                            resultBlock:resultBlock
                               delegate:delegate
                       notificationName:notificationName
                             paramaters:paramaters];
                break;
            }
            case DFINetworkManagerHTTPPostRequest:
            {
                [self POSTRequestWithURL:url
                              paramaters:paramaters
                                delegate:delegate
                        notificationName:notificationName
                             resultBlock:resultBlock];
                break;
            }
            case DFINetworkManagerHTTPHeadRequest:
            {
                [self HEADRequestWithUrl:url
                             resultBlock:resultBlock
                                delegate:delegate
                        notificationName:notificationName
                              paramaters:paramaters];
            }
            default:
                break;
        }
        
    }
    @catch (NSException *exception) {
        NSLog(@"exception name = %@ reason = %@", exception.name, exception.reason);
    }
    @finally {
        
    }
}

+ (void)GETRequestWithUrl:(NSString *)url
              resultBlock:(resultBlock)resultBlock
                 delegate:(id)delegate
         notificationName:(NSString *)notificationName
               paramaters:(NSDictionary *)paramaters
{
    [DFINetworkHTTPRequestService
     fetchDataFromURL:url
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

+ (void)POSTRequestWithURL:(NSString *)url
                paramaters:(NSDictionary *)paramaters
                  delegate:(id)delegate
          notificationName:(NSString *)notificationName
               resultBlock:(resultBlock)resultBlock
{
    [DFINetworkHTTPRequestService
     sendDataToURL:url
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

+ (void)HEADRequestWithUrl:(NSString *)url
              resultBlock:(resultBlock)resultBlock
                 delegate:(id)delegate
         notificationName:(NSString *)notificationName
               paramaters:(NSDictionary *)paramaters {
    
    [DFINetworkHTTPRequestService
     headDataToURL:url
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

+ (void)sendDataToURL:(NSString *)url
           paramaters:(NSDictionary *)paramaters
        constructBody:(NSArray <NSData *> *)bodys
        bodyPartNames:(NSArray <NSString *> *)bodyPartNames
              success:(successCallback)success
                 fail:(failCallback)fail {
    
    [DFINetworkHTTPRequestService sendDataToURL:url
                                     paramaters:paramaters
                                  constructBody:bodys
                                  bodyPartNames:bodyPartNames
                                        success:success
                                           fail:fail];
}

+ (void)uploadDataToURL:(NSString *)URL
               withData:(NSData *)data
          progressBlock:(void(^)(double progress, int64_t totalCountUnit))progressBlock
           successBlock:(successCallback)successBlock
              failBlock:(failCallback)failBlock {
    
    [DFINetworkHTTPRequestService uploadDataToURL:URL
                                         withData:data
                                    progressBlock:progressBlock
                                     successBlock:successBlock
                                        failBlock:failBlock];
}

+ (void)downloadDataWithURL:(NSString *)URL
                destination:(NSString *)filePath
              progressBlock:(void(^)(double progress, int64_t totalCountUnit))progressBlock
               successBlock:(successCallback)successBlock
                  failBlock:(failCallback)failBlock {
    
    [DFINetworkHTTPRequestService downloadWithURL:URL
                              destinationFilePath:filePath
                                    progressBlock:progressBlock
                                     successBlock:successBlock
                                        failBlock:failBlock];
}

+ (void)handleRequestResult:(resultBlock)resultBlock
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
