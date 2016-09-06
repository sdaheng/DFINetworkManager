//
//  NASendData.m
//  DFINetworkManagerDemo
//
//  Created by sdaheng on 16/8/23.
//  Copyright © 2016年 sdaheng. All rights reserved.
//

#import "NASendData.h"

#import "DFINetworkManager.h"

NSString * const kNASendDataResultNotification = @"kNASendDataResultNotification";

@interface NASendData () <DFINetworkServiceProtocol,
                          DFINetworkServiceRACSupportProtocol>

@end

@implementation NASendData

- (void)sendDataWithURLParamaters:(NSDictionary *)paramaters {
    [DFINetworkAPIRequest requestWithURL:nil
                              paramaters:paramaters
                             requestType:DFINetworkManagerHTTPPOSTRequest
                        notificationName:kNASendDataResultNotification];
}

- (void)sendDataWithURLParamaters:(NSDictionary *)paramaters
                         delegate:(id<DFINetworkServiceAPIRequestDelegate>)delegate {
    [DFINetworkAPIRequest requestWithURL:nil
                              paramaters:paramaters
                             requestType:DFINetworkManagerHTTPPOSTRequest
                                delegate:delegate];
}

- (void)sendDataWithURLParamaters:(NSDictionary *)paramaters
                      resultBlock:(DFIAPIRequestResultBlock)resultBlock {
    [DFINetworkAPIRequest requestWithURL:nil
                              paramaters:paramaters
                             requestType:DFINetworkManagerHTTPPOSTRequest
                             resultBlock:resultBlock];
}

- (RACSignal *)signalSendDataWithURLParamaters:(NSDictionary *)paramaters {
    return [[RACSignal createSignal:^RACDisposable *(id<RACSubscriber> subscriber) {
        [DFINetworkAPIRequest requestWithURL:nil
                                  paramaters:paramaters
                                 requestType:DFINetworkManagerHTTPPOSTRequest
                                 resultBlock:^(id ret) {
                                     SUBSCRIBER_DATA_HANDLER(subscriber, YES, ret);
                                 }];
        return nil;
    }] replay];
}

@end
