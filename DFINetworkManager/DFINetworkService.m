//
//  NetworkService.m
//  DFINetworkManager
//
//  Created by SDH on 14/6/23.
//  Copyright (c) 2014年 SDH. All rights reserved.
//

#import "DFINetworkService.h"
#import "DFINetworkServiceInterface.h"

@implementation DFINetworkService

+ (void)fetchDataByName:(NSString *)name Paramaters:(NSDictionary *)paramaters{
    
    id <DFINetworkServiceInterface> interface = nil;
    
    id networkService = [[NSClassFromString(name) alloc] init];
    
    interface = networkService;
    
    if (interface && [interface respondsToSelector:@selector(fetchDataWithURLParamaters:)]) {
        [interface fetchDataWithURLParamaters:paramaters];
    }
}

+ (void)fetchDataByName:(NSString *)name
             Paramaters:(NSDictionary *)paramaters
               delegate:(id<DFINetworkServiceAPIRequestDelegate>)delegate{
    
    id <DFINetworkServiceInterface> interface = nil;
    
    id networkService = [[NSClassFromString(name) alloc] init];
    
    interface = networkService;
    
    if (interface &&
        [interface respondsToSelector:@selector(fetchDataByName:Paramaters:delegate:)]) {
        
        [interface fetchDataWithURLParamaters:paramaters
                                     delegate:delegate];
    }
}

+ (void)fetchDataByName:(NSString *)name
             Paramaters:(NSDictionary *)paramaters
            resultBlock:(resultBlock)result{
    
    id <DFINetworkServiceInterface> interface = nil;
    
    id networkService = [[NSClassFromString(name) alloc] init];
    
    interface = networkService;
    
    if (interface &&
        [interface respondsToSelector:@selector(fetchDataWithURLParamaters:resultBlock:)]) {
        
        [interface fetchDataWithURLParamaters:paramaters
                                  resultBlock:^(id ret) {
                                      if (result) {
                                          result(ret);
                                      }
                                  }];
    }
}

+ (void)sendDataByName:(NSString *)name Paramaters:(NSDictionary *)paramaters{
    
    id <DFINetworkServiceInterface> interface = nil;
    
    id networkService = [[NSClassFromString(name) alloc] init];
    
    interface = networkService;
    
    if (interface && [interface respondsToSelector:@selector(sendDataWithURLParamaters:)]) {
        [interface sendDataWithURLParamaters:paramaters];
    }
}

+ (void)sendDataByName:(NSString *)name
            Paramaters:(NSDictionary *)paramaters
              delegate:(id<DFINetworkServiceAPIRequestDelegate>)delegate{
    
    id <DFINetworkServiceInterface> interface = nil;
    
    id networkService = [[NSClassFromString(name) alloc] init];
    
    interface = networkService;
    
    if (interface &&
        [interface respondsToSelector:@selector(sendDataWithURLParamaters:delegate:)]) {
        
        [interface sendDataWithURLParamaters:paramaters
                                    delegate:delegate];
    }
}

+ (void)sendDataByName:(NSString *)name
            Paramaters:(NSDictionary *)paramaters
           resultBlock:(resultBlock)result{
    
    id <DFINetworkServiceInterface> interface = nil;
    
    id networkService = [[NSClassFromString(name) alloc] init];
    
    interface = networkService;
    
    if (interface &&
        [interface respondsToSelector:@selector(sendDataWithURLParamaters:resultBlock:)]) {
        
        [interface sendDataWithURLParamaters:paramaters
                                 resultBlock:^(id ret) {
                                     if (result) {
                                         result(ret);
                                     }
                                 }];
    }
}

@end
