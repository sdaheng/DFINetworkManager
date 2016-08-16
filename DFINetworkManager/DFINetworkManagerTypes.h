//
//  DFINetworkManagerTypes.h
//  DFINetworkManager
//
//  Created by SDH on 15/2/10.
//  Copyright (c) 2015年 com.dazhongcun. All rights reserved.
//

#ifndef DFINetworkManager_DFINetworkManagerTypes_h
#define DFINetworkManager_DFINetworkManagerTypes_h

typedef void(^DFISuccessBlock)(id ret);
typedef void(^DFIFailBlock)(NSError *error);

typedef DFISuccessBlock DFIAPIRequestResultBlock;

#endif
