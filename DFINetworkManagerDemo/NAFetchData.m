//
//  NAFetchData.m
//  DFINetworkManagerDemo
//
//  Created by SDH on 19/08/2016.
//  Copyright © 2016 sdaheng. All rights reserved.
//

#import "NAFetchData.h"

#import "DFINetworkManager.h"

NSString * const kNAFetchDataResultNotification = @"kNAFetchDataResultNotification";

@interface NAFetchData () <DFINetworkServiceProtocol,
                           DFINetworkServiceRACSupportProtocol>

@end

@implementation NAFetchData

- (void)fetchDataWithURLParamaters:(NSDictionary *)paramaters
                       resultBlock:(DFIAPIRequestResultBlock)resultBlock {
    
    NSString *URLString = @"https://api.github.com/users/facebook";
    
    [DFINetworkAPIRequest requestWithURL:URLString
                              paramaters:paramaters
                             requestType:DFINetworkManagerHTTPGetRequest
                             resultBlock:^(id ret) {
                                 resultBlock ? resultBlock(ret) : nil;
                             }];
}

- (RACSignal *)signalFetchDataWithURLParamaters:(NSDictionary *)paramaters {
    NSString *URLString = @"https://api.github.com/users/facebook";

    return [[RACSignal createSignal:^RACDisposable *(id<RACSubscriber> subscriber) {
        
        [DFINetworkAPIRequest requestWithURL:URLString
                                  paramaters:paramaters
                                 requestType:DFINetworkManagerHTTPGetRequest
                                 resultBlock:^(id ret) {
                                     SUBSCRIBER_DATA_HANDLER(subscriber, YES, ret);
                                 }];
        return nil;
    }] replay];
}

- (void)fetchDataWithURLParamaters:(NSDictionary *)paramaters {
    NSString *URLString = @"https://api.github.com/users/facebook";
    
    [DFINetworkAPIRequest requestWithURL:URLString
                              paramaters:paramaters
                             requestType:DFINetworkManagerHTTPGetRequest
                        notificationName:kNAFetchDataResultNotification];
 
}

- (void)fetchDataWithURLParamaters:(NSDictionary *)paramaters
                          delegate:(id<DFINetworkServiceAPIRequestDelegate>)delegate {
    NSString *URLString = @"https://api.github.com/users/facebook";
    
    [DFINetworkAPIRequest requestWithURL:URLString
                              paramaters:paramaters
                             requestType:DFINetworkManagerHTTPGetRequest
                                delegate:delegate];
}

@end
