//
//  DFINetworkTimeoutErrorHandler.m
//  DFInfrastructure
//
//  Created by SDH on 8/13/15.
//  Copyright (c) 2015 com.dazhongcun. All rights reserved.
//

#import "DFINetworkTimeoutErrorHandler.h"

#if __has_include(<DFIFoundation/DFIFoundation.h>)
#import <DFIFoundation/DFIFoundation.h>
#endif

#import "DFINetworkNotificationNames.h"

@interface DFINetworkTimeoutErrorHandler ()
#if __has_include(<DFIFoundation/DFIFoundation.h>)
<DFIErrorHandlerInterface>
#endif

@end

@implementation DFINetworkTimeoutErrorHandler

- (void)handleError:(NSError *)error {
    if (error.code == NSURLErrorTimedOut) {
        [[NSNotificationCenter defaultCenter] postNotificationName:kDFINetworkRequestTimeoutErrorNotification
                                                            object:nil];
    }
}

@end
