//
//  DFINetworkHTTPRequestService.m
//  DFINetworkManager
//
//  Created by SDH on 14-5-20.
//  Copyright (c) 2014年 SDH. All rights reserved.
//

#import "DFINetworkHTTPRequestService.h"
#import "DFIErrorHandler.h"
#import "DFINetworkManagerDefines.h"
#import <AFNetworking/AFNetworking.h>

//Only use for debug
#ifndef DFINETWORK_ALLOW_INVALID_CERTFICATE 
#define DFINETWORK_ALLOW_INVALID_CERTFICATE NO
#endif

#ifndef DFINETWORK_ALLOW_VALIDATE_DOMAIN
#define DFINETWORK_ALLOW_VALIDATE_DOMAIN YES
#endif

@interface DFINetworkHTTPRequestService ()

@property (nonatomic, strong) AFHTTPSessionManager *HTTPSessionManager;
@property (nonatomic, strong) AFURLSessionManager  *URLSessionManager;

@end

@implementation DFINetworkHTTPRequestService

- (instancetype)init {
    self = [super init];
    
    if (self) {
        _HTTPSessionManager = [AFHTTPSessionManager manager];
       
        _URLSessionManager = [[AFURLSessionManager alloc] init];
        
        _HTTPSessionManager.responseSerializer = [AFHTTPResponseSerializer serializer];
        
        _HTTPSessionManager.securityPolicy =
        [AFSecurityPolicy policyWithPinningMode:AFSSLPinningModePublicKey];
        
#ifdef DFINETWORK_ALLOW_INVALID_CERTFICATE
        _HTTPSessionManager.securityPolicy.allowInvalidCertificates =
        DFINETWORK_ALLOW_INVALID_CERTFICATE;
#else
        _HTTPSessionManager.securityPolicy.allowInvalidCertificates = NO;
#endif
        
#ifdef DFINETWORK_ALLOW_VALIDATE_DOMAIN
        _HTTPSessionManager.securityPolicy.validatesDomainName =
        DFINETWORK_ALLOW_VALIDATE_DOMAIN;
#else
        _HTTPSessionManager.securityPolicy.validatesDomainName = YES;
#endif
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

+ (void)fetchDataFromURL:(NSString *)URLString
              paramaters:(NSDictionary *)paramaters
            successBlock:(void (^)(id result))success
               failBlock:(void (^)(NSError *error))fail {

    [[[self sharedInstance] HTTPSessionManager]
     GET:URLString parameters:paramaters progress:nil
     success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
         NSError *error = nil;
         
         id parsedJSONObject =
         [NSJSONSerialization JSONObjectWithData:responseObject
                                         options:NSJSONReadingMutableLeaves |
                                                 NSJSONReadingAllowFragments
                                           error:&error];
         
         if (error) {
             NSLog(@"DFINetworkHTTPRequestService (GET) JSON error: %@", [error description]);
         }
         
         if (success) {
             success(parsedJSONObject);
         }
         
         [self storeURLCacheWithDataTask:task data:responseObject];
     }
     failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
         
         if (fail) {
             fail(error);
         }
     }];
}

+ (void)sendDataToURL:(NSString *)URLString
           paramaters:(NSDictionary *)paramaters
              success:(DFISuccessBlock)success
                 fail:(DFIFailBlock)fail {
    [[[self sharedInstance] HTTPSessionManager]
     POST:URLString parameters:paramaters progress:nil
     success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
          NSError *error = nil;
          
          id parsedJSONObject =
          [NSJSONSerialization JSONObjectWithData:responseObject
                                          options:NSJSONReadingMutableLeaves |
                                                  NSJSONReadingAllowFragments
                                            error:&error];
          
          if (error) {
              NSLog(@"DFINetworkHTTPRequestService (POST) JSON error: %@", [error description]);
          }
          
          if (success){
              success(parsedJSONObject);
          }
         
         [self storeURLCacheWithDataTask:task data:responseObject];
      }
     failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
          if (fail) {
              fail(error);
          }
     }];
}

+ (void)sendDataToURL:(NSString *)URLString
           paramaters:(NSDictionary *)paramaters
        constructBody:(NSArray <NSData *> *)bodys
        bodyPartNames:(NSArray <NSString *> *)bodyPartNames
              success:(DFISuccessBlock)success
                 fail:(DFIFailBlock)fail {
    
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
    } progress:^(NSProgress * _Nonnull uploadProgress) {}
       success:^(NSURLSessionDataTask * _Nonnull task,
           id  _Nullable responseObject) {
          NSError *error = nil;
          
          id parsedJSONObject =
          [NSJSONSerialization JSONObjectWithData:responseObject
                                          options:NSJSONReadingMutableLeaves |
                                                  NSJSONReadingAllowFragments
                                            error:&error];
          
          if (error) {
              NSLog(@"DFINetworkHTTPRequestService (POST) JSON error: %@", [error description]);
              
              if (fail) {
                  fail(error);
              }
          }
          
          if (success){
              success(parsedJSONObject);
          }
           
           [self storeURLCacheWithDataTask:task data:responseObject];
       }
        failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
            if (fail) {
                fail(error);
            }
      }];
}

+ (void)headDataToURL:(NSString *)URL
           paramaters:(NSDictionary *)paramaters
              success:(DFISuccessBlock)success
                 fail:(DFIFailBlock)fail {
    [[[self sharedInstance] HTTPSessionManager]
     HEAD:URL parameters:paramaters success:^(NSURLSessionDataTask * _Nonnull task) {
          if (success) {
              success(task.response);
          }
      }
      failure:^(NSURLSessionDataTask * _Nullable task,
                NSError * _Nonnull error) {
          if (fail) {
              fail(error);
          }
      }];
}

+ (void)deleteDataToURL:(NSString *)URL
             paramaters:(NSDictionary *)paramters
                success:(DFISuccessBlock)success
                   fail:(DFIFailBlock)fail {

    [[[self sharedInstance] HTTPSessionManager]
     DELETE:URL parameters:paramters success:^(NSURLSessionDataTask * _Nonnull task,
                                               id  _Nullable responseObject) {
                
        if (success) {
            success(responseObject);
        }
    }
    failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
        if (fail) {
            fail(error);
        }
    }];
}

+ (void)uploadDataToURL:(NSString *)URL
               withData:(NSData *)data
          progressBlock:(void(^)(double progress, int64_t totalCountUnit))progressBlock
           successBlock:(DFISuccessBlock)successBlock
              failBlock:(DFIFailBlock)failBlock {

    NSURLSessionUploadTask *sessionUploadTask =
    [[[self sharedInstance] URLSessionManager]
     uploadTaskWithRequest:[NSURLRequest requestWithURL:[NSURL URLWithString:URL]]
                  fromData:data
                  progress:^(NSProgress * _Nonnull uploadProgress) {
                      if (progressBlock) {
                          progressBlock(uploadProgress.fractionCompleted,
                                        uploadProgress.totalUnitCount);
                      }
                  }
         completionHandler:^(NSURLResponse * _Nonnull response,
                             id  _Nullable responseObject,
                             NSError * _Nullable error) {
             
             if (!error) {
                 if (successBlock) {
                     successBlock(responseObject);
                 }
             }else {
                 if (failBlock) {
                     failBlock(error);
                 }
             }
         }];
    
    [sessionUploadTask resume];
}

+ (void)downloadWithURL:(NSString *)URLString
    destinationFilePath:(NSString *)filePath
          progressBlock:(void(^)(double progress, int64_t totalCountUnit))progressBlock
           successBlock:(DFISuccessBlock)successBlock
              failBlock:(DFIFailBlock)failBlock {

    NSURLSessionDownloadTask *sessionDownloadTask =
    [[[self sharedInstance] URLSessionManager]
     downloadTaskWithRequest:[NSURLRequest requestWithURL:[NSURL URLWithString:URLString]]
     progress:^(NSProgress * _Nonnull downloadProgress) {
           if (progressBlock) {
               progressBlock(downloadProgress.fractionCompleted,
                             downloadProgress.totalUnitCount);
           }
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
            if (successBlock) {
                successBlock(filePath);
            }
        }else {
            if (failBlock) {
                failBlock(error);
            }
        }
    }];
    
    [sessionDownloadTask resume];
}

+ (void)cancelHTTPRequest {
    [[[self sharedInstance] HTTPSessionManager] invalidateSessionCancelingTasks:YES];
}

+ (void)cancelDataRequest {
    [[[self sharedInstance] URLSessionManager] invalidateSessionCancelingTasks:YES];
}

+ (void)storeURLCacheWithDataTask:(NSURLSessionDataTask *)task data:(NSData *)data {
    NSCachedURLResponse *cachedURLResponse =
    [[NSCachedURLResponse alloc] initWithResponse:task.response
                                             data:data];
    
    [[NSURLCache sharedURLCache] storeCachedResponse:cachedURLResponse
                                         forDataTask:task];
}

@end
