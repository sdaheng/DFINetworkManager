//
//  ViewController.m
//  DFINetworkManagerDemo
//
//  Created by SDH on 4/9/16.
//  Copyright © 2016 sdaheng. All rights reserved.
//

#import "ViewController.h"

#import "DFINetworkManager.h"
#import "NotificationNames.h"

@interface ViewController () <DFINetworkServiceAPIRequestDelegate>

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
   
    [self setupNetowrkRequestLog];
    
    [self fetchDataByBlock];
    
    [self fetchDataBySignal];
    
    [self fetchDataByDelegte];
    
    [self registerNotificationObserver];
    // Do any additional setup after loading the view, typically from a nib.
}

- (void)setupNetowrkRequestLog {
    [DFINetworkService setEnableLogResult:YES];
    [DFINetworkService setEnableLogRequest:YES];
}

- (void)fetchDataByBlock {
    [DFINetworkService fetchDataByName:@"NAFetchData"
                            Paramaters:nil
                           resultBlock:^(id ret) {
                               
                           }];
}

- (void)fetchDataBySignal {
    [[DFINetworkService signalFetchDataByName:@"NAFetchData"
                                   Paramaters:nil]
     subscribeNext:^(id x) {
         
     }];
}

- (void)fetchDataByNotification {
    [DFINetworkService fetchDataByName:@"NAFetchData"
                            Paramaters:nil];
}

- (void)fetchDataByDelegte {
    [DFINetworkService fetchDataByName:@"NAFetchData"
                            Paramaters:nil
                              delegate:self];
}

- (void)registerNotificationObserver {
    [[NSNotificationCenter defaultCenter] addObserver:self
                                             selector:@selector(handleNotification:)
                                                 name:kNAFetchDataResultNotification
                                               object:nil];
}

- (void)handleNotification:(NSNotification *)notification {
    if ([notification.name isEqualToString:kNAFetchDataResultNotification]) {
//        id result = notification.userInfo[kDFINetworkRequestResultKey];
    }
}

- (void)networkAPIRequestTask:(NSURLSessionDataTask *)task result:(NSDictionary *)result {
    
}

- (void)dealloc {
    [[NSNotificationCenter defaultCenter] removeObserver:self];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
