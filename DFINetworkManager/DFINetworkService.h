//
//  NetworkService.h
//  DFINetworkManager
//
//  Created by SDH on 14/6/20.
//  Copyright (c) 2014年 SDH. All rights reserved.
//

#import <Foundation/Foundation.h>

#import "DFINetworkServiceAPIRequestDelegate.h"
#import "DFINetworkManagerTypes.h"

@interface DFINetworkService : NSObject

/**
 *@brief 通过不同的类名从服务器获取不同的数据（GET）, 获取结果由通知返回
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
            resultBlock:(resultBlock)result;

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
           resultBlock:(resultBlock)result;

@end
