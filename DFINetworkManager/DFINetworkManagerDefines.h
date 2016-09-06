//
//  DFINetworkManagerDefines.h
//  DFINetworkManager
//
//  Created by SDH on 8/13/15.
//  Copyright (c) 2015 com.dazhongcun. All rights reserved.
//

#ifndef DFINetworkManagerDefines_h
#define DFINetworkManagerDefines_h

#if __cplusplus
    #define DFI_NM_EXPORT extern "C"
#else
    #define DFI_NM_EXPORT extern
#endif

#if __has_include(<ReactiveCocoa/ReactiveCocoa.h>)
    #define SUBSCRIBER_DATA_HANDLER(subscriber, success, result) \
            SUBSCRIBER_DATA_HANDLER_4(subscriber, success, result, @"")

    #define SUBSCRIBER_DATA_HANDLER_4(subscriber, success, result, errorDescription) \
            do {               \
                if (success) { \
                    [subscriber sendNext:result];  \
                    [subscriber sendCompleted];    \
                } else {                           \
                    NSError *error = [NSError errorWithDomain:@"NetworkRequest Error"     \
                                                         code:1                           \
                                                     userInfo:@{@"reason" : errorDescription}]; \
                                                                                                \
                    [subscriber sendError:error]; \
                    [subscriber sendCompleted];   \
                }    \
            }while(0)\

#endif

#endif
