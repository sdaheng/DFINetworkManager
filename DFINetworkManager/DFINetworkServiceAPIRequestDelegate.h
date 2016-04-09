//
//  DFINetworkServiceAPIRequestDelegate.h
//  DFInfrastructure
//
//  Created by dzc002 on 15/2/10.
//  Copyright (c) 2015年 com.dazhongcun. All rights reserved.
//

#import <Foundation/Foundation.h>

@protocol DFINetworkServiceAPIRequestDelegate <NSObject>

- (void)networkAPIRequestResult:(NSDictionary *)result;

@end
