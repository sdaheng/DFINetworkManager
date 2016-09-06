//
//  DFINetworkConfiguration.m
//  DFINetworkManager
//
//  Created by sdaheng on 16/8/22.
//  Copyright © 2016年 sdaheng. All rights reserved.
//

#import "DFINetworkHTTPConfiguration.h"

#import <objc/runtime.h>

@interface DFINetworkHTTPConfiguration ()

@property (nonatomic, copy) NSDictionary <NSString *, NSString *> *HTTPRequestHeaders;

@end

@implementation DFINetworkHTTPConfiguration

+ (instancetype)defaultConfiguration {
    return [[self alloc] init];
}

- (instancetype)init {
    if (self = [super init]) {
        _stringEncoding = NSUTF8StringEncoding;
        _allowsCellularAccess = YES;
        _timeoutInterval = 60;
        _cachePolicy = NSURLRequestUseProtocolCachePolicy;
        _HTTPShouldHandleCookies = YES;
        _HTTPShouldUsePipelining = NO;
        _networkServiceType = NSURLNetworkServiceTypeDefault;
    }
    
    return self;
}

- (void)setValue:(NSString *)value forHTTPHeaderField:(NSString *)field {
    NSMutableDictionary *tempMutableDictionary =
    [NSMutableDictionary dictionaryWithDictionary:self.HTTPRequestHeaders];
    
    [tempMutableDictionary setValue:value
                             forKey:field];
    
    self.HTTPRequestHeaders = [tempMutableDictionary copy];
}

- (nullable NSString *)valueForHTTPHeaderField:(NSString *)field {
    return self.HTTPRequestHeaders[field];
}

@end

@implementation DFINetworkHTTPSecurityConfiguration

+ (instancetype)defaultSecurityConfiguration {
    return [[self alloc] initWithPinningMode:DFINetworkSSLPinningModeNone];
}

- (instancetype)initWithPinningMode:(DFINetworkSSLPinningMode)pinningMode {
    self = [super init];
    
    if (self) {
        _SSLPinningMode = pinningMode;
        _validatesDomainName = YES;
        _allowInvalidCertificates = NO;
    }
    
    return self;
}

//copy certificatesInBundle: from AFSecurityPolicy.m
+ (NSSet *)certificatesInBundle:(NSBundle *)bundle {
    NSArray *paths = [bundle pathsForResourcesOfType:@"cer" inDirectory:@"."];
    
    NSMutableSet *certificates = [NSMutableSet setWithCapacity:[paths count]];
    for (NSString *path in paths) {
        NSData *certificateData = [NSData dataWithContentsOfFile:path];
        [certificates addObject:certificateData];
    }
    
    return [NSSet setWithSet:certificates];
}

@end
