//
//  DFINetworkCouldNotConnectServerErrorHandler.m
//  DFInfrastructure
//
//  Created by SDH on 8/13/15.
//  Copyright (c) 2015 com.dazhongcun. All rights reserved.
//

#import "DFINetworkCannotConnectToHostErrorHandler.h"

#if __has_include(<DFIFoundation/DFIFoundation.h>)
#import <DFIFoundation/DFIFoundation.h>
#endif

#import "DFINetworkNotificationNames.h"

@interface DFINetworkCannotConnectToHostErrorHandler ()
#if __has_include(<DFIFoundation/DFIFoundation.h>)
<DFIErrorHandlerInterface>
#endif

@end

@implementation DFINetworkCannotConnectToHostErrorHandler

- (void)handleError:(NSError *)error {
    if (error.code == NSURLErrorCannotConnectToHost) {
        [[NSNotificationCenter defaultCenter] postNotificationName:kDFINetworkRequestCannotConnectHostErrorNotification
                                                            object:nil];
    }
}

@end
