//
//  NetworkAPIRequest.h
//  DFINetworkManager
//
//  Created by SDH on 14-9-25.
//  Copyright (c) 2014年 SDH. All rights reserved.
//

#import <Foundation/Foundation.h>

#import "DFINetworkManagerDefines.h"
#import "DFINetworkServiceAPIRequestDelegate.h"

/**
 *@brief 通知返回的userInfo里结果的Key
 */
DFI_NM_EXPORT NSString * const kDFINetworkRequestResultKey;

typedef void(^DFIAPIRequestResultBlock)(id ret);

typedef enum : NSUInteger {
    DFINetworkManagerHTTPGetRequest,
    DFINetworkManagerHTTPPostRequest,
    DFINetworkManagerHTTPHeadRequest
} DFINetworkManagerRequestType;

@interface DFINetworkAPIRequest : NSObject

/**
 *  HTTP Request
 *
 *  @param URL              Request URL
 *  @param paramaters       URL paramaters
 *  @param requestType      Request method (support GET, POST, HEAD)
 *  @param notificationName Request result notification name
 */
+ (void)requestWithURL:(NSString *)URLString
            paramaters:(NSDictionary *)paramaters
           requestType:(DFINetworkManagerRequestType)requestType
      notificationName:(NSString *)notificationName;

/**
 *  HTTP Request
 *
 *  @param URL         Request URL
 *  @param paramaters  URL paramaters
 *  @param requestType Request method (support GET, POST, HEAD)
 *  @param delegate    Request result delegate
 */
+ (void)requestWithURL:(NSString *)URLString
            paramaters:(NSDictionary *)paramaters
           requestType:(DFINetworkManagerRequestType)requestType
              delegate:(id<DFINetworkServiceAPIRequestDelegate>)delegate;

/**
 *  HTTP Request
 *
 *  @param URL         Request URL
 *  @param paramaters  URL patamaters
 *  @param requestType Request method (support GET, POST, HEAD)
 *  @param resultBlock Request result block
 */
+ (void)requestWithURL:(NSString *)URLString
            paramaters:(NSDictionary *)paramaters
           requestType:(DFINetworkManagerRequestType)requestType
           resultBlock:(DFIAPIRequestResultBlock)resultBlock;

+ (void)sendDataToURL:(NSString *)URLString
           paramaters:(NSDictionary *)paramaters
        constructBody:(NSArray <NSData *> *)bodys
        bodyPartNames:(NSArray <NSString *> *)bodyPartNames
              success:(DFISuccessBlock)success
                 fail:(DFIFailBlock)fail;

+ (void)cancelHTTPRequest;

@end
