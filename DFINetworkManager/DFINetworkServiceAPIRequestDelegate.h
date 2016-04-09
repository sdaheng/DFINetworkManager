//
//  DFINetworkServiceAPIRequestDelegate.h
//  DFINetworkManager
//
//  Created by SDH on 15/2/10.
//  Copyright (c) 2015年 com.dazhongcun. All rights reserved.
//

#import <Foundation/Foundation.h>

@protocol DFINetworkServiceAPIRequestDelegate <NSObject>

- (void)networkAPIRequestResult:(NSDictionary *)result;

@end
