//
//  NetworkServiceInterface.h
//  DFINetworkManager
//
//  Created by SDH on 14/6/20.
//  Copyright (c) 2014年 SDH. All rights reserved.
//

#import <Foundation/Foundation.h>

#import "DFINetworkManagerTypes.h"
#import "DFINetworkServiceAPIRequestDelegate.h"

@protocol DFINetworkServiceInterface <NSObject>

@optional

/**
 *@brief Fetch data with paramaters, result is returned by notification
 *@paramater url paramater
 *@return void
 */
- (void)fetchDataWithURLParamaters:(NSDictionary *)paramaters;

/**
 *@brief Fetch data with paramater, result is returned by delegate
 *@paramater url paramater
 *@paramater delegate
 *@return void
 */
- (void)fetchDataWithURLParamaters:(NSDictionary *)paramaters
                          delegate:(id<DFINetworkServiceAPIRequestDelegate>)delegate;

/**
 *@brief Fetch data with paramater, result is returned by block
 *@paramater url paramater
 *@paramater result block
 *@return void
 */
- (void)fetchDataWithURLParamaters:(NSDictionary *)paramaters
                       resultBlock:(DFIAPIRequestResultBlock)resultBlock;

/**
 *@brief Post data with paramater, result is returned by notification
 *@paramater url paramater
 *@return void
 */
- (void)sendDataWithURLParamaters:(NSDictionary *)paramaters;

/**
 *@brief Post data with paramater, result is returned by delegate
 *@paramater url paramater
 *@paramater delegate
 *@return void
 */
- (void)sendDataWithURLParamaters:(NSDictionary *)paramaters
                         delegate:(id<DFINetworkServiceAPIRequestDelegate>)delegate;

/**
 *@brief Post data with paramater, result is resturned by block
 *@paramater url paramater
 *@paramater result block
 *@return void
 */
- (void)sendDataWithURLParamaters:(NSDictionary *)paramaters
                      resultBlock:(DFIAPIRequestResultBlock)resultBlock;

@end
