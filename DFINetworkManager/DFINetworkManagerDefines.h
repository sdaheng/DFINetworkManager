//
//  DFINetworkManagerDefines.h
//  DFINetworkManager
//
//  Created by SDH on 8/13/15.
//  Copyright (c) 2015 com.dazhongcun. All rights reserved.
//

#ifndef DFINetworkManager_DFINetworkManagerDefines_h
#define DFINetworkManager_DFINetworkManagerDefines_h

#if __cplusplus
#define DFI_NM_EXPORT extern "C"
#else
#define DFI_NM_EXPORT extern
#endif

//仅在调试时使用，发布时需删除下面两行代码
#define DFINETWORK_ALLOW_INVALID_CERTFICATE YES
#define DFINETWORK_ALLOW_VALIDATE_DOMAIN    NO

#endif
