//
//  DFINetworkManagerTypes.h
//  DFInfrastructure
//
//  Created by dzc002 on 15/2/10.
//  Copyright (c) 2015年 com.dazhongcun. All rights reserved.
//

#ifndef DFInfrastructure_DFINetworkManagerTypes_h
#define DFInfrastructure_DFINetworkManagerTypes_h

typedef void(^successCallback)(id ret);
typedef void(^failCallback)(NSError *error);

typedef successCallback resultBlock;

#endif
