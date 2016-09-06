//
//  DFINetworkConfiguration.h
//  DFINetworkManager
//
//  Created by sdaheng on 16/8/22.
//  Copyright © 2016年 sdaheng. All rights reserved.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

@interface DFINetworkHTTPConfiguration : NSObject
//copy from AFHTTPRequestSerializer.h
/**
 The string encoding used to serialize parameters. `NSUTF8StringEncoding` by default.
 */
@property (nonatomic, assign) NSStringEncoding stringEncoding;

/**
 Whether created requests can use the device’s cellular radio (if present). `YES` by default.
 
 @see NSMutableURLRequest -setAllowsCellularAccess:
 */
@property (nonatomic, assign) BOOL allowsCellularAccess;

/**
 The cache policy of created requests. `NSURLRequestUseProtocolCachePolicy` by default.
 
 @see NSMutableURLRequest -setCachePolicy:
 */
@property (nonatomic, assign) NSURLRequestCachePolicy cachePolicy;

/**
 Whether created requests should use the default cookie handling. `YES` by default.
 
 @see NSMutableURLRequest -setHTTPShouldHandleCookies:
 */
@property (nonatomic, assign) BOOL HTTPShouldHandleCookies;

/**
 Whether created requests can continue transmitting data before receiving a response from an earlier transmission. `NO` by default
 
 @see NSMutableURLRequest -setHTTPShouldUsePipelining:
 */
@property (nonatomic, assign) BOOL HTTPShouldUsePipelining;

/**
 The network service type for created requests. `NSURLNetworkServiceTypeDefault` by default.
 
 @see NSMutableURLRequest -setNetworkServiceType:
 */
@property (nonatomic, assign) NSURLRequestNetworkServiceType networkServiceType;

/**
 The timeout interval, in seconds, for created requests. The default timeout interval is 60 seconds.
 
 @see NSMutableURLRequest -setTimeoutInterval:
 */
@property (nonatomic, assign) NSTimeInterval timeoutInterval;

///---------------------------------------
/// @name Configuring HTTP Request Headers
///---------------------------------------

/**
 Default HTTP header field values to be applied to serialized requests. By default, these include the following:
 
 - `Accept-Language` with the contents of `NSLocale +preferredLanguages`
 - `User-Agent` with the contents of various bundle identifiers and OS designations
 
 @discussion To add or remove default request headers, use `setValue:forHTTPHeaderField:`.
 */
@property (readonly, nonatomic, copy) NSDictionary <NSString *, NSString *> *HTTPRequestHeaders;

/**
 Sets the value for the HTTP headers set in request objects made by the HTTP client. If `nil`, removes the existing value for that header.
 
 @param field The HTTP header to set a default value for
 @param value The value set as default for the specified header, or `nil`
 */
- (void)setValue:(nullable NSString *)value forHTTPHeaderField:(NSString *)field;

/**
 Returns the value for the HTTP headers set in the request serializer.
 
 @param field The HTTP header to retrieve the default value for
 
 @return The value set as default for the specified header, or `nil`
 */
- (nullable NSString *)valueForHTTPHeaderField:(NSString *)field;

+ (instancetype)defaultConfiguration;

@end

typedef enum : NSUInteger {
    DFINetworkSSLPinningModeNone,
    DFINetworkSSLPinningModePublicKey,
    DFINetworkSSLPinningModeCertificate,
} DFINetworkSSLPinningMode;

@interface DFINetworkHTTPSecurityConfiguration : NSObject
//copy from AFSecurityPolicy.h
/**
 The criteria by which server trust should be evaluated against the pinned SSL certificates. Defaults to `AFSSLPinningModeNone`.
 */
@property (readonly, nonatomic, assign) DFINetworkSSLPinningMode SSLPinningMode;

/**
 The certificates used to evaluate server trust according to the SSL pinning mode.
 
 By default, this property is set to any (`.cer`) certificates included in the target compiling AFNetworking. Note that if you are using AFNetworking as embedded framework, no certificates will be pinned by default. Use `certificatesInBundle` to load certificates from your target, and then create a new policy by calling `policyWithPinningMode:withPinnedCertificates`.
 
 Note that if pinning is enabled, `evaluateServerTrust:forDomain:` will return true if any pinned certificate matches.
 */
@property (nonatomic, strong, nullable) NSSet <NSData *> *pinnedCertificates;

/**
 Whether or not to trust servers with an invalid or expired SSL certificates. Defaults to `NO`.
 */
@property (nonatomic, assign) BOOL allowInvalidCertificates;

/**
 Whether or not to validate the domain name in the certificate's CN field. Defaults to `YES`.
 */
@property (nonatomic, assign) BOOL validatesDomainName;

///-----------------------------------------
/// @name Getting Certificates from the Bundle
///-----------------------------------------

/**
 Returns any certificates included in the bundle. If you are using AFNetworking as an embedded framework, you must use this method to find the certificates you have included in your app bundle, and use them when creating your security policy by calling `policyWithPinningMode:withPinnedCertificates`.
 
 @return The certificates included in the given bundle.
 */
+ (NSSet <NSData *> *)certificatesInBundle:(NSBundle *)bundle;

/**
 *  Default HTTP configuration and default security policy
 */
+ (instancetype)defaultSecurityConfiguration;

@end

NS_ASSUME_NONNULL_END
