//
//  NAFetchData.m
//  DFINetworkManagerDemo
//
//  Created by SDH on 19/08/2016.
//  Copyright © 2016 sdaheng. All rights reserved.
//

#import "NAFetchData.h"

#import "DFINetworkService-Protocol.h"
#import "DFINetworkAPIRequest.h"

@interface NAFetchData () <DFINetworkServiceProtocol>

@end

@implementation NAFetchData

- (void)fetchDataWithURLParamaters:(NSDictionary *)paramaters
                       resultBlock:(DFIAPIRequestResultBlock)resultBlock {
    
    NSString *URLString = @"https://api.github.com/users/facebook";
    
    [DFINetworkAPIRequest requestWithURL:URLString
                              paramaters:paramaters
                             requestType:DFINetworkManagerHTTPGetRequest
                             resultBlock:^(id ret) {
                                 NSLog(@"fetch result from URL: %@ %@", URLString, ret);
                                 resultBlock ? resultBlock(ret) : nil;
                             }];
}

@end
