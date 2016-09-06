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
                             requestType:DFINetworkManagerHTTPGETRequest
                             resultBlock:resultBlock];
}

- (RACSignal *)signalFetchDataWithURLParamaters:(NSDictionary *)paramaters {
//    NSString *URLString = @"https://api.github.com/users/facebook";
    NSString *URLString = @"http://c.m.163.com/nc/article/headline/T1348647853363/0-20.html?from=toutiao&fn=3&prog=LMA1&passport=&devId=11kWnvC6hEKJz5fXi1dFQpUYLPfK6ElUvADPoIdvxBX%2B%2B8Up8bq4jvLzob%2FMHvjf&offset=0&size=20&version=14.1&spever=false&net=wifi&lat=&lon=&ts=1472094183&sign=o4%2BDWae7XEYbpf7qENipu1UGXUbppmSvJ27%2FvEGQUdx48ErR02zJ6%2FKXOnxX046I&encryption=1&canal=appstore";
    
    return [[RACSignal createSignal:^RACDisposable *(id<RACSubscriber> subscriber) {
        
        [DFINetworkAPIRequest requestWithURL:URLString
                                  paramaters:paramaters
                                 requestType:DFINetworkManagerHTTPGETRequest
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
                             requestType:DFINetworkManagerHTTPGETRequest
                        notificationName:kNAFetchDataResultNotification];
 
}

- (void)fetchDataWithURLParamaters:(NSDictionary *)paramaters
                          delegate:(id<DFINetworkServiceAPIRequestDelegate>)delegate {
    NSString *URLString = @"https://api.github.com/users/facebook";
    
    [DFINetworkAPIRequest requestWithURL:URLString
                              paramaters:paramaters
                             requestType:DFINetworkManagerHTTPGETRequest
                                delegate:delegate];
}

@end
