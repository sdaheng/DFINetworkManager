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

#import "DFINetworkManagerTypes.h"
#import "DFINetworkServiceAPIRequestDelegate.h"

@protocol DFINetworkServiceProtocol <NSObject>

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
