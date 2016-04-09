//
//  Services.h
//  PropertyHousekeeper
//
//  Created by SDH on 14-5-20.
//  Copyright (c) 2014年 包光晖. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "DFINetworkManagerTypes.h"

@interface DFINetworkHTTPRequestService : NSObject

/**
 *  从服务端获取数据(GET)
 *
 *  @param url     URL, 参数直接使用&拼接
 *  @param success 成功后调用的block, 并返回获取的结果
 *  @param fail    失败调用的block
 */
+ (void)fetchDataFromURL:(NSString *)url
            successBlock:(void (^)(id result))success
               failBlock:(void (^)(NSError *error))fail;

/**
 *  从服务端获取数据(GET)
 *
 *  @param url        URL
 *  @param paramaters HTTP Get 的参数
 *  @param success    成功后调用的block, 并返回获取的结果
 *  @param fail       失败调用的block
 */
+ (void)fetchDataFromURL:(NSString *)url
              paramaters:(NSDictionary *)paramaters
            successBlock:(void (^)(id result))success
               failBlock:(void (^)(NSError *error))fail;

/**
 *@brief 向服务端发送数据(POST)
 *@param URL
 *@param URL参数
 *@param 成功后的block
 *@param 失败后的block
 */
+ (void)sendDataToURL:(NSString *)url
           paramaters:(NSDictionary *)paramaters
              success:(successCallback)success
                 fail:(failCallback)fail;

+ (void)sendDataToURL:(NSString *)url
           paramaters:(NSDictionary *)paramaters
        constructBody:(NSArray <NSData *> *)bodys
        bodyPartNames:(NSArray <NSString *> *)bodyPartNames
              success:(successCallback)success
                 fail:(failCallback)fail;

/**
 *  Get HTTP HEAD from URL
 *
 *  @param URL        URL
 *  @param paramaters URL paramaters
 *  @param success    success block
 *  @param fail       fail block
 */
+ (void)headDataToURL:(NSString *)URL
           paramaters:(NSDictionary *)paramaters
              success:(successCallback)success
                 fail:(failCallback)fail;

/**
 *  Upload data to URL
 *
 *  @param URL           URL
 *  @param data          The data which you want to upload.
 *  @param progressBlock Upload progress
 *  @param successBlock  if data upload success, successBlock will be invoked.
 *  @param failBlock     if error occurred, failBlock will be invoked.
 */
+ (void)uploadDataToURL:(NSString *)URL
               withData:(NSData *)data
          progressBlock:(void(^)(double progress, int64_t totalCountUnit))progressBlock
           successBlock:(successCallback)successBlock
              failBlock:(failCallback)failBlock;

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
           successBlock:(successCallback)successBlock
              failBlock:(failCallback)failBlock;

@end
