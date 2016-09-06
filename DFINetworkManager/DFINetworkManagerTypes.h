//
//  DFINetworkManagerTypes.h
//  DFINetworkManager
//
//  Created by SDH on 15/2/10.
//  Copyright (c) 2015年 com.dazhongcun. All rights reserved.
//

#ifndef DFINetworkManager_DFINetworkManagerTypes_h
#define DFINetworkManager_DFINetworkManagerTypes_h

typedef void(^DFINetworkRequestSuccessBlock)(NSURLSessionDataTask *sessionDataTask, id ret);
typedef void(^DFINetworkRequestFailBlock)(NSError *error);

typedef void(^DFIAPIRequestResultBlock)(id ret);

#endif
