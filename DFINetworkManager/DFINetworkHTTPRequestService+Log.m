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
#import "DFINetworkHTTPRequestService+Log.h"
#import <objc/runtime.h>

@implementation DFINetworkHTTPRequestService (Log)

+ (void)load {
    [self swizzleRequest];
}

char * const enableLogRequestkey = "\0";
char * const enableLogResultKey  = "\0";

+ (void)setEnableLogRequest:(BOOL)enableLog {
    objc_setAssociatedObject(self, enableLogRequestkey, @(enableLog), OBJC_ASSOCIATION_ASSIGN);
}

+ (void)setEnableLogResult:(BOOL)enableLog {
    objc_setAssociatedObject(self, enableLogResultKey, @(enableLog), OBJC_ASSOCIATION_ASSIGN);
}

+ (void)swizzleRequest {
    exchangeClassMethodImplementation([self class],
                                      @selector(fetchDataFromURL:paramaters:successBlock:failBlock:),
                                      @selector(swizzleFetchDataFromURL:paramaters:successBlock:failBlock:));
    
    exchangeClassMethodImplementation([self class],
                                      @selector(sendDataToURL:paramaters:success:fail:),
                                      @selector(swizzleSendDataToURL:paramaters:constructBody:bodyPartNames:success:fail:));
    
    exchangeClassMethodImplementation([self class],
                                      @selector(headDataToURL:paramaters:success:fail:),
                                      @selector(swizzleHeadDataToURL:paramaters:success:fail:));

    exchangeClassMethodImplementation([self class],
                                      @selector(deleteDataToURL:paramaters:success:fail:),
                                      @selector(swizzleDeleteDataToURL:paramaters:success:fail:));
}

+ (void)swizzleFetchDataFromURL:(NSString *)URLString
                     paramaters:(NSDictionary *)paramaters
                   successBlock:(DFINetworkRequestSuccessBlock)success
                      failBlock:(void (^)(NSError *error))fail {
    if ([objc_getAssociatedObject(self, enableLogRequestkey) boolValue]) {
        NSLog(@"(GET) URL: %@ paramaters: %@", URLString, paramaters);
    }
    
    [self swizzleFetchDataFromURL:URLString
                       paramaters:paramaters
                     successBlock:^(NSURLSessionDataTask *task, id result){
                         if ([objc_getAssociatedObject(self, enableLogResultKey) boolValue]) {
                             NSLog(@"(GET) URL: %@ result: %@", URLString, result);
                             success ? success(task, result) : nil;
                         }
                     } failBlock:^(NSError *error) {
                         if ([objc_getAssociatedObject(self, enableLogResultKey) boolValue]) {
                             NSLog(@"(GET) URL: %@ error: %@", URLString, [error description]);
                         }
                         fail ? fail(error) : nil;
                     }];
}

+ (void)swizzleSendDataToURL:(NSString *)URLString
                  paramaters:(NSDictionary *)paramaters
                     success:(DFINetworkRequestSuccessBlock)success
                        fail:(DFINetworkRequestFailBlock)fail {
    if ([objc_getAssociatedObject(self, enableLogRequestkey) boolValue]) {
        NSLog(@"(POST) URL: %@ paramaters: %@", URLString, paramaters);
    }
    
    [self swizzleSendDataToURL:URLString
                    paramaters:paramaters
                       success:^(NSURLSessionDataTask *task, id result) {
                           if ([objc_getAssociatedObject(self, enableLogResultKey) boolValue]) {
                               NSLog(@"(POST) URL: %@ result:%@", URLString, result);
                               success ? success(task, result) : nil;
                           }
                       } fail:^(NSError *error){
                           if ([objc_getAssociatedObject(self, enableLogResultKey) boolValue]) {
                               NSLog(@"(POST) URL: %@ error: %@", URLString, [error description]);
                           }
                           fail ? fail(error) : nil;
                       }];
}

+ (void)swizzleSendDataToURL:(NSString *)URLString
                  paramaters:(NSDictionary *)paramaters
               constructBody:(NSArray <NSData *> *)bodys
               bodyPartNames:(NSArray <NSString *> *)bodyPartNames
                     success:(DFINetworkRequestSuccessBlock)success
                        fail:(DFINetworkRequestFailBlock)fail {
    if ([objc_getAssociatedObject(self, enableLogRequestkey) boolValue]) {
        NSLog(@"Multipart (POST) URL: %@ paramater: %@", URLString, paramaters);
    }
    
    [self swizzleSendDataToURL:URLString
                    paramaters:paramaters
                 constructBody:bodys
                 bodyPartNames:bodyPartNames
                       success:^(NSURLSessionDataTask *task, id result) {
                           if ([objc_getAssociatedObject(self, enableLogResultKey) boolValue]) {
                               NSLog(@"Multipart (POST) URL:%@ result: %@", URLString, result);
                               success ? success(task, result) : nil;
                           }
                       } fail:^(NSError *error) {
                           if ([objc_getAssociatedObject(self, enableLogResultKey) boolValue]) {
                               NSLog(@"Multipart (POST) URL:%@ error: %@", URLString, [error description]);
                           }
                           fail ? fail(error) : nil;
                       }];
}

+ (void)swizzleHeadDataToURL:(NSString *)URL
                  paramaters:(NSDictionary *)paramaters
                     success:(DFINetworkRequestSuccessBlock)success
                        fail:(DFINetworkRequestFailBlock)fail {
    if ([objc_getAssociatedObject(self, enableLogRequestkey) boolValue]) {
        NSLog(@"(HEAD) URL: %@ paramater: %@",  URL, paramaters);
    }
    
    [self swizzleHeadDataToURL:URL
                    paramaters:paramaters
                       success:^(NSURLSessionDataTask *task, id result) {
                           if ([objc_getAssociatedObject(self, enableLogResultKey) boolValue]) {
                               NSLog(@"(HEAD) URL: %@ result: %@", URL, result);
                               success ? success(task, result) : nil;
                           }
                       } fail:^(NSError *error) {
                           if ([objc_getAssociatedObject(self, enableLogResultKey) boolValue]) {
                               NSLog(@"(HEAD) URL: %@ error: %@", URL, [error description]);
                           }
                           fail ? fail(error) : nil;
                       }];
}

+ (void)swizzleDeleteDataToURL:(NSString *)URL
                    paramaters:(NSDictionary *)paramters
                       success:(DFINetworkRequestSuccessBlock)success
                          fail:(DFINetworkRequestFailBlock)fail {
    if ([objc_getAssociatedObject(self, enableLogRequestkey) boolValue]) {
        NSLog(@"(DELETE) URL: %@ paramater: %@", URL, paramters);
    }
    
    [self swizzleDeleteDataToURL:URL
                      paramaters:paramters
                         success:^(NSURLSessionDataTask *task, id result) {
                             if ([objc_getAssociatedObject(self, enableLogResultKey) boolValue]) {
                                 NSLog(@"(DELETE) URL: %@ result: %@", URL, result);
                             }
                             success ? success(task, result) : nil;
                         } fail:^(NSError *error) {
                             if ([objc_getAssociatedObject(self, enableLogResultKey) boolValue]) {
                                 NSLog(@"(DELETE) URL: %@ error: %@", URL, [error description]);
                             }
                             fail ? fail(error) : nil;
                         }];
}

static void exchangeClassMethodImplementation(Class clazz, SEL origin, SEL destation) {
    Method originMethod = class_getClassMethod(clazz, origin);
    Method swizzleMethod = class_getClassMethod(clazz, destation);
    
    method_exchangeImplementations(originMethod, swizzleMethod);
}

@end
