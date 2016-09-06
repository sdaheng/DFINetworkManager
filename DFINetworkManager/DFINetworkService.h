// The MIT License (MIT)
//
// Copyright (c) 2016 SDH
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

#import "DFINetworkServiceAPIRequestDelegate.h"
#import "DFINetworkManagerTypes.h"

@class DFINetworkHTTPConfiguration;
@class DFINetworkHTTPSecurityConfiguration;
@interface DFINetworkService : NSObject

/**
 *@brief Fetch data by class name.（GET) 获取结果由通知返回
 *@param 网络请求接口的类名
 *@param 要传的参数
 *@return 无
 */
+ (void)fetchDataByName:(NSString *)name
             Paramaters:(NSDictionary *)paramaters;

/**
 *@brief 通过不同的类名从服务器获取不同的数据（GET）, 获取结果由delegate返回
 *@param 网络请求接口的类名
 *@param 参数
 *@param delegate
 *@return 无
 */
+ (void)fetchDataByName:(NSString *)name
             Paramaters:(NSDictionary *)paramaters
               delegate:(id<DFINetworkServiceAPIRequestDelegate>)delegate;

/**
 *@brief 通过不同的类名从服务器获取不同的数据（GET）, 获取结果由block返回
 *@param 网络请求接口的类名
 *@param 参数
 *@param resultBlock
 *@return 无
 */
+ (void)fetchDataByName:(NSString *)name
             Paramaters:(NSDictionary *)paramaters
            resultBlock:(DFIAPIRequestResultBlock)result;

/**
 *@brief 通过不同的类名向服务器提交不同的数据（POST）, 获取的结果由通知返回
 *@param 网络请求接口的类名
 *@param 要传的参数
 *@return 无
 */
+ (void)sendDataByName:(NSString *)name
            Paramaters:(NSDictionary *)paramaters;

/**
 *@brief 通过不同的类名向服务器提交不同的数据（POST）, 获取结果由delegate返回
 *@param 网络请求接口的类名
 *@param 要传的参数
 *@param delegate
 *@return 无
 */
+ (void)sendDataByName:(NSString *)name
            Paramaters:(NSDictionary *)paramaters
              delegate:(id<DFINetworkServiceAPIRequestDelegate>)delegate;

/**
 *@brief 通过不同的类名向服务器提交不同的数据（POST）, 获取结果由resultBlock返回
 *@param 网络请求接口的类名
 *@param 要传的参数
 *@param resultBlock
 *@return 无
 */
+ (void)sendDataByName:(NSString *)name
            Paramaters:(NSDictionary *)paramaters
           resultBlock:(DFIAPIRequestResultBlock)result;

+ (void)cancelHTTPRequest;

@end

@interface DFINetworkService (DataRequest)

/**
 *  Upload binary data to URL
 *
 *  @param URL           A URL which is binary data would upload
 *  @param data          Binary data
 *  @param progressBlock Upload progress block
 *  @param successBlock  If upload data success, invoke this block
 *  @param failBlock     If upload data fail, invoke this block
 */
+ (void)uploadDataToURL:(NSString *)URLString
               withData:(NSData *)data
          progressBlock:(void(^)(double progress, int64_t totalCountUnit))progressBlock
           successBlock:(DFINetworkRequestSuccessBlock)successBlock
              failBlock:(DFINetworkRequestFailBlock)failBlock;

/**
 *  Download something from URL
 *
 *  @param URL           Download file URL
 *  @param filePath      File path you want to save downloaded file
 *  @param progressBlock Download progress block
 *  @param successBlock  If download file success, invoke this block
 *  @param failBlock     If download file fail, invoke this block
 */
+ (void)downloadDataWithURL:(NSString *)URLString
                destination:(NSString *)filePath
              progressBlock:(void(^)(double progress, int64_t totalCountUnit))progressBlock
               successBlock:(DFINetworkRequestSuccessBlock)successBlock
                  failBlock:(DFINetworkRequestFailBlock)failBlock;

+ (void)cancelDataRequest;

@end

@interface DFINetworkService (Configuration)

+ (void)setHTTPNetworkServiceConfiguration:(DFINetworkHTTPConfiguration *)configuration;
+ (void)setHTTPSNetworkServiceConfiguration:(DFINetworkHTTPSecurityConfiguration *)configuration;

@end

@interface DFINetworkService (Cache)

/**
 *  Default is YES
 *
 *  @param enableURLCache enableURLCache
 */
+ (void)enableURLCache:(BOOL)enableURLCache;

+ (NSUInteger)currentURLCacheMemoryUsage;
+ (NSUInteger)currentURLCacheDiskUsage;

+ (void)setupCacheWithMemoryCapacity:(NSUInteger)memoryCapacity
                        diskCapacity:(NSUInteger)diskCapacity;
+ (void)clearCache;

@end

@interface DFINetworkService (Log)

+ (void)setEnableLogRequest:(BOOL)enableLog;
+ (void)setEnableLogResult:(BOOL)enableLog;

@end
