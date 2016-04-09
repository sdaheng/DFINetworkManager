//
//  DFINetworkManagerDefines.h
//  DFInfrastructure
//
//  Created by SDH on 8/13/15.
//  Copyright (c) 2015 com.dazhongcun. All rights reserved.
//

#ifndef DFInfrastructure_DFINetworkManagerDefines_h
#define DFInfrastructure_DFINetworkManagerDefines_h

#if __cplusplus
#define DFI_NM_EXPORT extern "C"
#else
#define DFI_NM_EXPORT extern
#endif

//仅在调试时使用，发布时需删除下面两行代码
#define DFINETWORK_ALLOW_INVALID_CERTFICATE YES
#define DFINETWORK_ALLOW_VALIDATE_DOMAIN    NO

#ifdef MMY_PROJECTS

#define FETCH_NETWORK_DATA_SUCCESS [ret[@"status"] integerValue] == 0
#define FETCH_NETWORK_DATA_FAIL    [ret[@"status"] integerValue] == 1

#ifdef REACTIVECOCOA_SUPPORT

#define SUBSCRIBER_DATA_HANDLER if (FETCH_NETWORK_DATA_SUCCESS) { \
NSLog(@"result %@", ret);      \
[subscriber sendNext:ret];      \
[subscriber sendCompleted];      \
}else if (FETCH_NETWORK_DATA_FAIL) {  \
NSError *error = [NSError errorWithDomain:@"NetworkRequest Error"    \
code:1                           \
userInfo:@{@"reason" : ret[@"msg"]}]; \
\
[subscriber sendError:error]; \
[subscriber sendCompleted];    \
} \

#endif
#endif

#endif
