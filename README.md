# DFINetworkManager

DFINetworkManager is a networking library built on top of  the AFNetworking. The library aiming to modular architecture with well-designed that you are enjoy to use.

## Installation With  CocoaPods

##### Podfile

To integrate DFINetworkManager into your Xcode project using CocoaPods, specify it in your Podfile:

```ruby
source 'https://github.com/CocoaPods/Specs.git'
platform :ios, '8.0'

target 'TargetName' do
  pod 'DFINetworkManager', '~> 0.1'
end
```

Then, run the following command:

```
$ pod install
```

## Architecture

##### HTTP Request

* `DFINetworkHTTPRequestService`

##### API Request

* `DFINetworkService`
* `<DFINetworkServiceProtocol>`
* `DFINetworkAPIRequest`

##### Configuration 

* `DFINetworkHTTPConfiguration`
* `DFINetworkHTTPSecurityConfiguration`

##### RAC Support

* `<DFINetworkServiceRACSupportProtocol>`
* `DFINetworkService+RACSupport`

##### Additional Functionality

* `DFINetworkReachabilityManager`

## Usage

#### GET

First, to create a new file like this. Name whatever you want. 

 ![QQ20160906-0@2x](/Users/sdaheng/Desktop/QQ20160906-0@2x.png)

Conform DFINetworkService protocol,  and choose one of your prefer way of getting result.

```objective-c
@interface NAFetchData () <DFINetworkServiceProtocol>

@end
  
@implementation NAFetchData

// No need to implement all of methods in DFINetworkServiceProtocol. 
  
- (void)fetchDataWithURLParamaters:(NSDictionary *)paramaters
                       resultBlock:(DFIAPIRequestResultBlock)resultBlock {
    
    NSString *URLString = @"https://api.github.com/users/facebook";
    
    [DFINetworkAPIRequest requestWithURL:URLString
                              paramaters:paramaters
                             requestType:DFINetworkManagerHTTPGETRequest
                             resultBlock:resultBlock];
}

- (void)fetchDataWithURLParamaters:(NSDictionary *)paramaters {
    NSString *URLString = @"https://api.github.com/users/facebook";
    
    [DFINetworkAPIRequest requestWithURL:URLString
                              paramaters:paramaters
                             requestType:DFINetworkManagerHTTPGETRequest
                        notificationName:kNAFetchDataResultNotification];
}

- (void)fetchDataWithURLParamaters:(NSDictionary *)paramaters
                          delegate:(id<DFINetworkServiceAPIRequestDelegate>)delegate {
    NSString *URLString = @"https://api.github.com/users/facebook";
    
    [DFINetworkAPIRequest requestWithURL:URLString
                              paramaters:paramaters
                             requestType:DFINetworkManagerHTTPGETRequest
                                delegate:delegate];
}

@end
```

If you want to use ReactiveCocoa,  you can conform `DFINetworkServiceRACSupportProtocol`  and implement `-(RACSignal *)signalFetchDataWithURLParamaters: `method.

```objective-c
- (RACSignal *)signalFetchDataWithURLParamaters:(NSDictionary *)paramaters {
    NSString *URLString = @"https://api.github.com/users/facebook";
  
    return [[RACSignal createSignal:^RACDisposable *(id<RACSubscriber> subscriber) {
        
        [DFINetworkAPIRequest requestWithURL:URLString
                                  paramaters:paramaters
                                 requestType:DFINetworkManagerHTTPGETRequest
                                 resultBlock:^(id ret) {
                                     SUBSCRIBER_DATA_HANDLER(subscriber, YES, ret);
                                 }];
        return nil;
    }] replay];
}
```

Call you implement method in viewController or other places like this. Pass the file name which you create.

Paramater is a `NSDictionary`. Pass HTTP request parameters like `@{@"key" : @"value"}`.

```
- (void)fetchDataReturnByBlock {
    [DFINetworkService fetchDataByName:@"NAFetchData"
                            Paramaters:nil
                           resultBlock:^(id ret) {
                               
                           }];
}

- (void)fetchDataReturnBySignal {
    [[DFINetworkService signalFetchDataByName:@"NAFetchData"
                                   Paramaters:nil]
     subscribeNext:^(id x) {
         
     }];
}

- (void)fetchDataReturnByNotification {
    [DFINetworkService fetchDataByName:@"NAFetchData"
                            Paramaters:nil];
}

- (void)fetchDataReturnByDelegte {
    [DFINetworkService fetchDataByName:@"NAFetchData"
                            Paramaters:nil
                              delegate:self];
}
```

If you want to get result through notification, register notification center observer.

```objective-c
[[NSNotificationCenter defaultCenter] addObserver:self
                                         selector:@selector(handleNotification:)
                                             name:kNAFetchDataResultNotification
                                           object:nil];

- (void)handleNotification:(NSNotification *)notification {
    if ([notification.name isEqualToString:kNAFetchDataResultNotification]) {
        id result = notification.userInfo[kDFINetworkRequestResultKey];
    }
}
```

If you want to get result through delegate. Implement `- (void)networkAPIRequestTask:result:`

```objective-c
- (void)networkAPIRequestTask:(NSURLSessionDataTask *)task result:(NSDictionary *)result {
    
}
```

#### POST

Usage of POST is same as GET, just change `fetch`  to `send`.

```objective-c
- (void)sendDataWithURLParamaters:(NSDictionary *)paramaters
                      resultBlock:(DFIAPIRequestResultBlock)resultBlock {
    [DFINetworkAPIRequest requestWithURL:nil
                              paramaters:paramaters
                             requestType:DFINetworkManagerHTTPPOSTRequest
                             resultBlock:resultBlock];
}
```

#### Download and Upload

##### Download

```objective-c
[DFINetworkService downloadDataWithURL:(NSString *)URLString
                           destination:(NSString *)filePath
              progressBlock:^(double progress, int64_t totalCountUnit)){}
               successBlock:^(NSURLSessionDataTask *sessionDataTask, id ret){}
                  failBlock:^(NSError *error){}];
```

##### Upload

```
[DFINetworkService uploadDataToURL:(NSString *)URLString
                          withData:(NSData *)data
                     progressBlock:^(double progress, int64_t totalCountUnit)){}
                      successBlock:^(NSURLSessionDataTask *sessionDataTask, id ret){}
                         failBlock:^(NSError *error){}
```

#### Configuration

New an instance of `DFINetworkHTTPConfiguration`.  

Set header `- (void)setValue:(nullable NSString *)value forHTTPHeaderField:(NSString *)field`

For security, new an instance of `DFINetworkHTTPSecurityConfiguration`.

#### Cache

Cache is using NSURLCache. Default cache enable is YES.  You can turn off caching by

 `[DFINetworkService enableURLCache:NO]`

Clear Cache `[DFINetworkService clearCache]`

#### Log

To enable log request  `[DFINetworkService setEnableLogRequest:YES]`.

To enable log result `[DFINetworkService setEnableLogResult:YES]`.

Default log enable is NO.

## License

DFINetworkManager is released under the MIT license. See LICENSE for details.