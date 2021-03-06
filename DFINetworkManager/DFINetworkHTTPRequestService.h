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
#import "DFINetworkManagerTypes.h"

@class DFINetworkHTTPConfiguration;
@class DFINetworkHTTPSecurityConfiguration;
@interface DFINetworkHTTPRequestService : NSObject

/**
 *  从服务端获取数据(GET)
 *
 *  @param url        URL
 *  @param paramaters HTTP Get 的参数
 *  @param success    成功后调用的block, 并返回获取的结果
 *  @param fail       失败调用的block
 */
+ (void)fetchDataFromURL:(NSString *)URLString
              paramaters:(NSDictionary *)paramaters
            successBlock:(DFINetworkRequestSuccessBlock)success
               failBlock:(DFINetworkRequestFailBlock)fail;

/**
 *@brief 向服务端发送数据(POST)
 *@param URL
 *@param URL参数
 *@param 成功后的block
 *@param 失败后的block
 */
+ (void)sendDataToURL:(NSString *)URLString
           paramaters:(NSDictionary *)paramaters
              success:(DFINetworkRequestSuccessBlock)success
                 fail:(DFINetworkRequestFailBlock)fail;

+ (void)sendDataToURL:(NSString *)URLString
           paramaters:(NSDictionary *)paramaters
        constructBody:(NSArray <NSData *> *)bodys
        bodyPartNames:(NSArray <NSString *> *)bodyPartNames
              success:(DFINetworkRequestSuccessBlock)success
                 fail:(DFINetworkRequestFailBlock)fail;

/**
 *  Get HTTP HEAD from URL
 *
 *  @param URL        URL
 *  @param paramaters URL paramaters
 *  @param success    success block
 *  @param fail       fail block
 */
+ (void)headDataToURL:(NSString *)URLString
           paramaters:(NSDictionary *)paramaters
              success:(DFINetworkRequestSuccessBlock)success
                 fail:(DFINetworkRequestFailBlock)fail;

+ (void)deleteDataToURL:(NSString *)URL
             paramaters:(NSDictionary *)paramters
                success:(DFINetworkRequestSuccessBlock)success
                   fail:(DFINetworkRequestFailBlock)fail;

/**
 *  Upload data to URL
 *
 *  @param URL           URL
 *  @param data          The data which you want to upload.
 *  @param progressBlock Upload progress
 *  @param successBlock  if data upload success, successBlock will be invoked.
 *  @param failBlock     if error occurred, failBlock will be invoked.
 */
+ (void)uploadDataToURL:(NSString *)URLString
               withData:(NSData *)data
          progressBlock:(void(^)(double progress, int64_t totalCountUnit))progressBlock
           successBlock:(DFINetworkRequestSuccessBlock)successBlock
              failBlock:(DFINetworkRequestFailBlock)failBlock;

/**
 *  Download a file from URL
 *
 *  @param URLString     URL
 *  @param filePath      destination file path, subpath of document directory.
 *  @param progressBlock download progress.
 *  @param successBlock  if file download succeed, successBlock will be invoked.
 *  @param failBlock     if error occurred, failBlock will be invoked.
 */
+ (void)downloadWithURL:(NSString *)URLString
    destinationFilePath:(NSString *)filePath
          progressBlock:(void(^)(double progress, int64_t totalCountUnit))progressBlock
           successBlock:(DFINetworkRequestSuccessBlock)successBlock
              failBlock:(DFINetworkRequestFailBlock)failBlock;

+ (void)cancelHTTPRequest;
+ (void)cancelDataRequest;

+ (void)setHTTPRequestConfiguration:(DFINetworkHTTPConfiguration *)configuration;
+ (void)setHTTPSRequestConfiguration:(DFINetworkHTTPSecurityConfiguration *)configuration;

+ (void)setEnableCache:(BOOL)enableCache;

@end
