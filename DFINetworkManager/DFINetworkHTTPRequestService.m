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

#import "DFINetworkHTTPRequestService.h"
#import "DFIErrorHandler.h"
#import "DFINetworkHTTPConfiguration.h"

#import <AFNetworking/AFNetworking.h>

@interface DFINetworkHTTPRequestService ()

@property (nonatomic, strong) AFHTTPSessionManager *HTTPSessionManager;
@property (nonatomic, strong) AFURLSessionManager  *URLSessionManager;

@property (nonatomic, assign) BOOL enableCache;

@end

@implementation DFINetworkHTTPRequestService

- (instancetype)init {
    self = [super init];
    
    if (self) {
        _HTTPSessionManager = [AFHTTPSessionManager manager];
       
        _URLSessionManager = [[AFURLSessionManager alloc] init];
        
        _HTTPSessionManager.responseSerializer = [AFHTTPResponseSerializer serializer];
        
        _enableCache = YES;
    }
    
    return self;
}

+ (instancetype)sharedInstance {
    static DFINetworkHTTPRequestService *networkRequestService = nil;
    
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        networkRequestService = [[DFINetworkHTTPRequestService alloc] init];
    });
    
    return networkRequestService;
}

#pragma mark - API Request

+ (void)fetchDataFromURL:(NSString *)URLString
              paramaters:(NSDictionary *)paramaters
            successBlock:(DFINetworkRequestSuccessBlock)success
               failBlock:(DFINetworkRequestFailBlock)fail {

    [[[self sharedInstance] HTTPSessionManager]
     GET:URLString parameters:paramaters progress:nil
     success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
         [self handleAPIRequestWithTask:task
               resultWithResponseObject:responseObject
                           successBlock:success
                              failBlock:fail];
         
         [self storeURLCacheWithDataTask:task data:responseObject];
     } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
         fail ? fail(error) : nil;
     }];
}

+ (void)sendDataToURL:(NSString *)URLString
           paramaters:(NSDictionary *)paramaters
              success:(DFINetworkRequestSuccessBlock)success
                 fail:(DFINetworkRequestFailBlock)fail {
    [[[self sharedInstance] HTTPSessionManager]
     POST:URLString parameters:paramaters progress:nil
     success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
         [self handleAPIRequestWithTask:task
               resultWithResponseObject:responseObject
                           successBlock:success
                              failBlock:fail];
      } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
         fail ? fail(error) : nil;
     }];
}

+ (void)sendDataToURL:(NSString *)URLString
           paramaters:(NSDictionary *)paramaters
        constructBody:(NSArray <NSData *> *)bodys
        bodyPartNames:(NSArray <NSString *> *)bodyPartNames
              success:(DFINetworkRequestSuccessBlock)success
                 fail:(DFINetworkRequestFailBlock)fail {
    
    [[[self sharedInstance] HTTPSessionManager]
     POST:URLString
     parameters:paramaters constructingBodyWithBlock:^(id<AFMultipartFormData>  _Nonnull formData) {
         [bodys enumerateObjectsUsingBlock:^(NSData * _Nonnull obj,
                                             NSUInteger idx,
                                             BOOL * _Nonnull stop) {
    
            if (idx > bodyPartNames.count) {
                *stop = YES;
            }
            [formData appendPartWithFormData:obj
                                        name:bodyPartNames[idx]];
         }];
    } progress:nil
       success:^(NSURLSessionDataTask * _Nonnull task,
           id  _Nullable responseObject) {
          
           [self handleAPIRequestWithTask:task
                 resultWithResponseObject:responseObject
                             successBlock:success
                                failBlock:fail];
       } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
            fail ? fail(error) : nil;
      }];
}

+ (void)headDataToURL:(NSString *)URL
           paramaters:(NSDictionary *)paramaters
              success:(DFINetworkRequestSuccessBlock)success
                 fail:(DFINetworkRequestFailBlock)fail {
    [[[self sharedInstance] HTTPSessionManager]
     HEAD:URL parameters:paramaters
     success:^(NSURLSessionDataTask * _Nonnull task) {
         success ? success(task, task.response) : nil;
      } failure:^(NSURLSessionDataTask * _Nullable task,
                NSError * _Nonnull error) {
          fail ? fail(error) : nil;
      }];
}

+ (void)deleteDataToURL:(NSString *)URL
             paramaters:(NSDictionary *)paramters
                success:(DFINetworkRequestSuccessBlock)success
                   fail:(DFINetworkRequestFailBlock)fail {

    [[[self sharedInstance] HTTPSessionManager]
     DELETE:URL parameters:paramters
     success:^(NSURLSessionDataTask * _Nonnull task,
                                               id  _Nullable responseObject) {
         success ? success(task, responseObject) : nil;
    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
        fail ? fail(error) : nil;
    }];
}

+ (void)handleAPIRequestWithTask:(NSURLSessionDataTask *)sessionDataTask
        resultWithResponseObject:(id)responseObject
                    successBlock:(DFINetworkRequestSuccessBlock)successBlock
                       failBlock:(DFINetworkRequestFailBlock)failBlock {
    NSError *error = nil;
    
    id parsedJSONObject =
    [NSJSONSerialization JSONObjectWithData:responseObject
                                    options:NSJSONReadingMutableLeaves |
                                            NSJSONReadingAllowFragments
                                      error:&error];
    
    if (error) {
        failBlock ? failBlock(error) : nil;
    }

    successBlock ? successBlock(sessionDataTask, parsedJSONObject) : nil;
}

#pragma mark - Data Request

+ (void)uploadDataToURL:(NSString *)URL
               withData:(NSData *)data
          progressBlock:(void(^)(double progress, int64_t totalCountUnit))progressBlock
           successBlock:(DFINetworkRequestSuccessBlock)successBlock
              failBlock:(DFINetworkRequestFailBlock)failBlock {

    NSURLSessionUploadTask *sessionUploadTask =
    [[[self sharedInstance] URLSessionManager]
     uploadTaskWithRequest:[NSURLRequest requestWithURL:[NSURL URLWithString:URL]]
                  fromData:data
                  progress:^(NSProgress * _Nonnull uploadProgress) {
                      dispatch_async(dispatch_get_main_queue(), ^{
                          if (progressBlock) {
                              progressBlock(uploadProgress.fractionCompleted,
                                            uploadProgress.totalUnitCount);
                          }
                      });
                  }
         completionHandler:^(NSURLResponse * _Nonnull response,
                             id  _Nullable responseObject,
                             NSError * _Nullable error) {
             
             if (!error) {
                 successBlock ? successBlock(nil, responseObject) : nil;
             }else {
                 failBlock ? failBlock(error) : nil;
             }
         }];
    
    [sessionUploadTask resume];
}

+ (void)downloadWithURL:(NSString *)URLString
    destinationFilePath:(NSString *)filePath
          progressBlock:(void(^)(double progress, int64_t totalCountUnit))progressBlock
           successBlock:(DFINetworkRequestSuccessBlock)successBlock
              failBlock:(DFINetworkRequestFailBlock)failBlock {

    NSURLSessionDownloadTask *sessionDownloadTask =
    [[[self sharedInstance] URLSessionManager]
     downloadTaskWithRequest:[NSURLRequest requestWithURL:[NSURL URLWithString:URLString]]
     progress:^(NSProgress * _Nonnull downloadProgress) {
         dispatch_async(dispatch_get_main_queue(), ^{
             if (progressBlock) {
                 progressBlock(downloadProgress.fractionCompleted,
                               downloadProgress.totalUnitCount);
             }
         });
       }
    destination:^NSURL * _Nonnull(NSURL * _Nonnull targetPath,
                                  NSURLResponse * _Nonnull response) {
        
        if ([filePath hasPrefix:@"file://"]) {
            return [NSURL URLWithString:filePath];
        }
        NSURL *destinationURL = [NSURL URLWithString:filePath
                                       relativeToURL:[[[NSFileManager defaultManager]
                                                       URLsForDirectory:NSDocumentDirectory
                                                       inDomains:NSUserDomainMask] lastObject]];
        
        return destinationURL;
    } completionHandler:^(NSURLResponse * _Nonnull response,
                          NSURL * _Nullable filePath,
                          NSError * _Nullable error) {
        if (!error) {
            successBlock ? successBlock(nil, filePath) : nil;
        }else {
            failBlock ? failBlock(error) : nil;
        }
    }];
    
    [sessionDownloadTask resume];
}

#pragma mark - Cacnel

+ (void)cancelHTTPRequest {
    [[[self sharedInstance] HTTPSessionManager] invalidateSessionCancelingTasks:YES];
}

+ (void)cancelDataRequest {
    [[[self sharedInstance] URLSessionManager] invalidateSessionCancelingTasks:YES];
}

#pragma mark - Configuration

+ (void)setHTTPRequestConfiguration:(DFINetworkHTTPConfiguration *)configuration {
    [[self sharedInstance] HTTPSessionManager].requestSerializer =
    [self AFReqeustSerializerFromHTTPConfiguration:configuration];
}

+ (void)setHTTPSRequestConfiguration:(DFINetworkHTTPSecurityConfiguration *)configuration {
    [[self sharedInstance] HTTPSessionManager].securityPolicy =
    [self AFSecurityPolicyFromHTTPConfiguration:configuration];
}

+ (AFHTTPRequestSerializer *)AFReqeustSerializerFromHTTPConfiguration:(DFINetworkHTTPConfiguration *)configuration {
    AFHTTPRequestSerializer *requestSerializer = [AFHTTPRequestSerializer serializer];
    
    requestSerializer.HTTPShouldUsePipelining = configuration.HTTPShouldUsePipelining;
    requestSerializer.HTTPShouldHandleCookies = configuration.HTTPShouldHandleCookies;
    requestSerializer.stringEncoding = configuration.stringEncoding;
    requestSerializer.allowsCellularAccess = configuration.allowsCellularAccess;
    requestSerializer.cachePolicy = configuration.cachePolicy;
    requestSerializer.networkServiceType = configuration.networkServiceType;
    requestSerializer.timeoutInterval = configuration.timeoutInterval;
    
    [configuration.HTTPRequestHeaders enumerateKeysAndObjectsUsingBlock:^(NSString * _Nonnull key,
                                                                          NSString * _Nonnull obj,
                                                                          BOOL * _Nonnull stop) {
        [requestSerializer setValue:obj forHTTPHeaderField:key];
    }];
    
    return requestSerializer;
}

+ (AFSecurityPolicy *)AFSecurityPolicyFromHTTPConfiguration:(DFINetworkHTTPSecurityConfiguration *)configuration {
    AFSecurityPolicy *securityPolicy =
    [AFSecurityPolicy policyWithPinningMode:(AFSSLPinningMode)configuration.SSLPinningMode
                     withPinnedCertificates:configuration.pinnedCertificates];
    
    securityPolicy.allowInvalidCertificates = configuration.allowInvalidCertificates;
    securityPolicy.validatesDomainName = configuration.validatesDomainName;
    
    return securityPolicy;
}

#pragma mark - Cache

+ (void)storeURLCacheWithDataTask:(NSURLSessionDataTask *)task data:(NSData *)data {
    if ([[DFINetworkHTTPRequestService sharedInstance] enableCache]) {
        NSCachedURLResponse *cachedURLResponse =
        [[NSCachedURLResponse alloc] initWithResponse:task.response
                                                 data:data];
        
        [[NSURLCache sharedURLCache] storeCachedResponse:cachedURLResponse
                                             forDataTask:task];
    }
}

+ (void)setEnableCache:(BOOL)enableCache {
    [DFINetworkHTTPRequestService sharedInstance].enableCache = enableCache;
}

@end
