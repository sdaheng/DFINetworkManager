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

#import "DFINetworkService+RACSupport.h"

#import "DFINetworkServiceRACSupportProtocol.h"

#if __has_include(<ReactiveCocoa/ReactiveCocoa.h>)

#ifndef DFI_NETWORK_SERVICE_IMPLEMENT_METHOD_EXCEPTION
#   define DFI_NETWORK_SERVICE_IMPLEMENT_METHOD_EXCEPTION(sel)                                    \
        @throw [NSException exceptionWithName:@"DFINetworkService Protocol Method Not Implement"  \
                                     reason:[NSString stringWithFormat:@"%s NOT implement", #sel] \
                                   userInfo:nil];
#endif

@implementation DFINetworkService (RACSupport)

+ (RACSignal *)signalFetchDataByName:(NSString *)name
                          Paramaters:(NSDictionary *)paramaters{
    id <DFINetworkServiceRACSupportProtocol> interface = [[NSClassFromString(name) alloc] init];

    if (interface &&
        [interface respondsToSelector:@selector(signalFetchDataWithURLParamaters:)]) {
        return [interface signalFetchDataWithURLParamaters:paramaters];
    } else {
        DFI_NETWORK_SERVICE_IMPLEMENT_METHOD_EXCEPTION(signalFetchDataWithURLParamaters:)
    }
    
    return [RACSignal empty];
}

+ (RACSignal *)signalSendDataByName:(NSString *)name
                         Paramaters:(NSDictionary *)paramaters {
    
    id <DFINetworkServiceRACSupportProtocol> interface = [[NSClassFromString(name) alloc] init];
    
    if (interface &&
        [interface respondsToSelector:@selector(signalSendDataWithURLParamaters:)]) {
        
        return [interface signalSendDataWithURLParamaters:paramaters];
    } else {
        DFI_NETWORK_SERVICE_IMPLEMENT_METHOD_EXCEPTION(signalSendDataWithURLParamaters:)
    }
    
    return [RACSignal empty];
}

@end
#undef DFI_NETWORK_SERVICE_IMPLEMENT_METHOD_EXCEPTION
#endif
