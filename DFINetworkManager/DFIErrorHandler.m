//
//  ErrorHandler.m
//  DFINetworkManager
//
//  Created by SDH on 14-5-21.
//  Copyright (c) 2014年 SDH. All rights reserved.
//

#import "DFIErrorHandler.h"

@implementation DFIErrorHandler

+ (void)handleErrorWithHandlerName:(NSString *)handlerName
                             error:(NSError *)error {
    
    id <DFIErrorHandlerInterface> interface = [[NSClassFromString(handlerName) alloc] init];
    
    if (interface && [interface respondsToSelector:@selector(handleError:)]) {
        [interface handleError:error];
    }
}

@end
