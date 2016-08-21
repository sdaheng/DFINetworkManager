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
   
    [DFINetworkService setEnableLogResult:YES];
    [DFINetworkService setEnableLogRequest:YES];
    
    [DFINetworkService fetchDataByName:@"NAFetchData"
                            Paramaters:nil
                           resultBlock:^(id ret) {
                               
                           }];
    
    [[DFINetworkService signalFetchDataByName:@"NAFetchData"
                                  Paramaters:nil]
     subscribeNext:^(id x) {
         
     }];
    
    [DFINetworkService fetchDataByName:@"NAFetchData"
                            Paramaters:nil];
    
    [DFINetworkService fetchDataByName:@"NAFetchData"
                            Paramaters:nil
                              delegate:self];
    
    [[NSNotificationCenter defaultCenter] addObserver:self
                                             selector:@selector(handleNotification:)
                                                 name:kNAFetchDataResultNotification
                                               object:nil];
    // Do any additional setup after loading the view, typically from a nib.
}

- (void)handleNotification:(NSNotification *)notification {
    if ([notification.name isEqualToString:kNAFetchDataResultNotification]) {
//        id result = notification.userInfo[kDFINetworkRequestResultKey];
    }
}

- (void)networkAPIRequestResult:(NSDictionary *)result {
    // result of +[DFINetworkService fetchDataByName:Paramaters:delegate:];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
