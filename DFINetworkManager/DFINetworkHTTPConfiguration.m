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
