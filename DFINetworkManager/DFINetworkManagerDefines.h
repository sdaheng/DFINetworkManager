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

//Only use for debug
#define DFINETWORK_ALLOW_INVALID_CERTFICATE YES
#define DFINETWORK_ALLOW_VALIDATE_DOMAIN    NO

#if __has_include(<ReactiveCocoa/ReactiveCocoa.h>)
    #define SUBSCRIBER_DATA_HANDLER(subscriber, success, result) \
            SUBSCRIBER_DATA_HANDLER_4(subscriber, success, result, @"")

    #define SUBSCRIBER_DATA_HANDLER_4(subscriber, success, result, errorDescription) \
            do {               \
                if (success) { \
                    NSLog(@"result %@", result);   \
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
