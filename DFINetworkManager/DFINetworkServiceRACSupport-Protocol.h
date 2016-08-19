//
//  DFINetworkServiceRACSupportProtocol.h
//  DFINetworkManager
//
//  Created by SDH on 3/15/16.
//  Copyright © 2016 com.dazhongcun. All rights reserved.
//

#import <Foundation/Foundation.h>

#if __has_include(<ReactiveCocoa/ReactiveCocoa.h>)
#import <ReactiveCocoa/ReactiveCocoa.h>

@protocol DFINetworkServiceRACSupportProtocol <NSObject>

- (RACSignal *)signalFetchDataWithURLParamaters:(NSDictionary *)paramaters;

- (RACSignal *)signalSendDataWithURLParamaters:(NSDictionary *)paramaters;

@end
#endif
