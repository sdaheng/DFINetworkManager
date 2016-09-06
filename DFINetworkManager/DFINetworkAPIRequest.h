// The MIT License (MIT)
//
// Copyright (c) 2014-2016 SDH
//
// Permission is hereby granted, free of charge, to any person obtaining a copy
// of this software and associated documentation files (the "Software"), to deal
// in the Software without restriction, including without limitation the rights
// to use, copy, modify, merge, publish, distribute, sublicense, and/or sell
// copies of the Software, and to permit persons to whom the Software is
// furnished to do so, subject to the following conditions:
//
// The above copyright notice and this permission notice shall be included in all
// copies or substantial portions of the Software.
//
// THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR
// IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY,
// FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT. IN NO EVENT SHALL THE
// AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER
// LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING FROM,
// OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN THE
// SOFTWARE.

#import <Foundation/Foundation.h>

#import "DFINetworkManagerDefines.h"
#import "DFINetworkServiceAPIRequestDelegate.h"

/**
 *@brief 通知返回的userInfo里结果的Key
 */
DFI_NM_EXPORT NSString * const kDFINetworkRequestResultKey;

typedef enum : NSUInteger {
    DFINetworkManagerHTTPGETRequest,
    DFINetworkManagerHTTPPOSTRequest,
    DFINetworkManagerHTTPHEADRequest
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
              success:(DFIAPIRequestResultBlock)success
                 fail:(DFINetworkRequestFailBlock)fail;

+ (void)cancelHTTPRequest;

@end
