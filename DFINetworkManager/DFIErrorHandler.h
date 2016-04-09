//
//  ErrorHandler.h
//  DFINetworkManager
//
//  Created by SDH on 14-5-21.
//  Copyright (c) 2014年 SDH. All rights reserved.
//

#import <Foundation/Foundation.h>

@protocol DFIErrorHandlerInterface <NSObject>

- (void)handleError:(NSError *)error;

@end

@interface DFIErrorHandler : NSObject

+ (void)handleErrorWithHandlerName:(NSString *)handlerName
                             error:(NSError *)error;

@end
