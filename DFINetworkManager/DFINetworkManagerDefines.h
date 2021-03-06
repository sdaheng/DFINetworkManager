// The MIT License (MIT)
//
// Copyright (c) 2014-2016 SDH
//
// Permission is hereby granted, free of charge, to any person obtaining a copy
// of this software and associated documentation files (the "Software"), to deal
// in the Software without restriction, including without limitation the rights
// to use, copy, modify, merge, publish, distribute, sublicense, and/or sell
// copies of the Software, and to permit persons to whom the Software is
// furnished to do so, subject to the following conditions:
//
// The above copyright notice and this permission notice shall be included in all
// copies or substantial portions of the Software.
//
// THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR
// IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY,
// FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT. IN NO EVENT SHALL THE
// AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER
// LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING FROM,
// OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN THE
// SOFTWARE.

#ifndef DFINetworkManagerDefines_h
#define DFINetworkManagerDefines_h

#if __cplusplus
    #define DFI_NM_EXPORT extern "C"
#else
    #define DFI_NM_EXPORT extern
#endif

#if __has_include(<ReactiveCocoa/ReactiveCocoa.h>)
    #define SUBSCRIBER_DATA_HANDLER(subscriber, success, result) \
            SUBSCRIBER_DATA_HANDLER_5(subscriber, success, result, 0, @"")

    #define SUBSCRIBER_DATA_HANDLER_WITH_ERROR(subscriber, success, result, errorCode, errorDescription) \
            SUBSCRIBER_DATA_HANDLER_5(subscriber, success, result, errorCode, errorDescritpion)

    #define SUBSCRIBER_DATA_HANDLER_5(subscriber, success, result, errorCode, errorDescription) \
            do {               \
                if (success) { \
                    [subscriber sendNext:result];  \
                    [subscriber sendCompleted];    \
                } else {                           \
                    NSError *error = [NSError errorWithDomain:@"NetworkRequest Error"           \
                                                         code:errorCode                         \
                                                     userInfo:@{@"reason" : errorDescription}]; \
                                                                                                \
                    [subscriber sendError:error]; \
                    [subscriber sendCompleted];   \
                }    \
            }while(0)\

#endif

#endif
