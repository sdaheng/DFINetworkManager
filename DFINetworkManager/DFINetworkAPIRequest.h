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

typedef void(^resultBlock)(id ret);

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
+ (void)requestWithURL:(NSString *)URL
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
+ (void)requestWithURL:(NSString *)URL
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
+ (void)requestWithURL:(NSString *)URL
            paramaters:(NSDictionary *)paramaters
           requestType:(DFINetworkManagerRequestType)requestType
           resultBlock:(resultBlock)resultBlock;

+ (void)sendDataToURL:(NSString *)URL
           paramaters:(NSDictionary *)paramaters
        constructBody:(NSArray <NSData *> *)bodys
        bodyPartNames:(NSArray <NSString *> *)bodyPartNames
              success:(successBlock)success
                 fail:(failBlock)fail;

/**
 *  Upload binary data to URL
 *
 *  @param URL           A URL which is binary data would upload
 *  @param data          Binary data
 *  @param progressBlock Upload progress block
 *  @param successBlock  If upload data success, invoke this block
 *  @param failBlock     If upload data fail, invoke this block
 */
+ (void)uploadDataToURL:(NSString *)URL
               withData:(NSData *)data
          progressBlock:(void(^)(double progress, int64_t totalCountUnit))progressBlock
           successBlock:(successBlock)successBlock
              failBlock:(failBlock)failBlock;

/**
 *  Download something from URL
 *
 *  @param URL           Download file URL
 *  @param filePath      File path you want to save downloaded file
 *  @param progressBlock Download progress block
 *  @param successBlock  If download file success, invoke this block
 *  @param failBlock     If download file fail, invoke this block
 */
+ (void)downloadDataWithURL:(NSString *)URL
                destination:(NSString *)filePath
              progressBlock:(void(^)(double progress, int64_t totalCountUnit))progressBlock
               successBlock:(successBlock)successBlock
                  failBlock:(failBlock)failBlock;

@end
