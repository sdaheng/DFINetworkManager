# DFINetworkManager

DFINetworkManager是一个基于[AFNetworking](https://github.com/AFNetworking/AFNetworking)的网络库。设计这个库的初衷是每个网络请求单独放在一个文件，将网络请求与数据转换从业务逻辑中分离出来。这个库旨在让你有个良好的网络层架构。

## 使用CocoaPods安装

##### Podfile

将DFINetworkManager集成进你的Xcode项目，需要你在Podfile中加入以下代码。

```ruby
source 'https://github.com/CocoaPods/Specs.git'
platform :ios, '8.0'

target 'TargetName' do
  pod 'DFINetworkManager'
end
```

然后运行一下下面这个命令。

```
$ pod install
```

## 系统要求

iOS 8.0+

## 架构

##### HTTP Request

- `DFINetworkHTTPRequestService`

##### API Request

- `DFINetworkService`
- `<DFINetworkServiceProtocol>`
- `DFINetworkAPIRequest`

##### Configuration

- `DFINetworkHTTPConfiguration`
- `DFINetworkHTTPSecurityConfiguration`

##### ReactiveCocoa Support

- `<DFINetworkServiceRACSupportProtocol>`
- `DFINetworkService+RACSupport`

##### Additional Functionality

- `DFINetworkReachabilityManager`

## 使用方法

#### GET

首先，你需要新建一个文件，名字随便你取。

`DFINetworkServiceProtocol`中提供Block、Delegation、Notification、RACSignal的方式来获取返回值。

你可以任意选一个你喜欢的取得返回值的方式来实现方法。

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

如果你在项目中使用了`ReactiveCocoa`.

你需要实现 `<DFINetworkServiceRACSupportProtocol>`中的`- (RACSignal *)signalFetchDataWithURLParamaters: `

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

使用ReactiveCocoa可以方便的处理数据转换。

```objective-c
- (RACSignal *)signalFetchDataWithURLParamaters:(NSDictionary *)paramaters {
    NSString *URLString = @"https://api.github.com/users/facebook";
  
    return [[[RACSignal createSignal:^RACDisposable *(id<RACSubscriber> subscriber) {
        [DFINetworkAPIRequest requestWithURL:URLString
                                  paramaters:paramaters
                                 requestType:DFINetworkManagerHTTPGETRequest
                                 resultBlock:^(id ret) {
                                     SUBSCRIBER_DATA_HANDLER(subscriber, YES, ret);
                                 }];
        return nil;
    }] replay] map:^id(id value) {
        return transformData(value); // Such as dictionary to model object.
    }];
}
```

实现这些方法以后你就可以在`viewController`或者其他什么地方调用它了。你只需要传一个你刚才新建文件的文件名和一个包含请求参数的NSDictionary类型的对象，就像 `@{@"HTTPRequestParamater" : @"value"}`这样。

**使用block的方式获取结果**

```objective-c
- (void)fetchDataReturnByBlock {
    [DFINetworkService fetchDataByName:@"NAFetchData"
                            paramaters:nil
                           resultBlock:^(id ret) {
                               
                           }];
}
```

**使用RACSignal的方式获取结果**

```objective-c
- (void)fetchDataReturnBySignal {
    [[DFINetworkService signalFetchDataByName:@"NAFetchData"
                                   Paramaters:nil]
     subscribeNext:^(id x) {
         
     }];
}
```

**使用通知的方式获取结果，你需要注册一个通知中心的观察者**

结果包含在`userInfo[kDFINetworkRequestResultKey]`中。

```objective-c
- (void)fetchDataReturnByNotification {
    [DFINetworkService fetchDataByName:@"NAFetchData"
                            paramaters:nil];
}

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

**使用代理的方式获取结果**

你需要实现一下`<DFINetworkServiceAPIRequestDelegate> `中的`- (void)networkAPIRequestTask:result:`

```objective-c
- (void)fetchDataReturnByDelegte {
    [DFINetworkService fetchDataByName:@"NAFetchData"
                            paramaters:nil
                              delegate:self];
}

- (void)networkAPIRequestTask:(NSURLSessionDataTask *)task result:(NSDictionary *)result {
    
}
```

#### POST

POST的使用方法和GET一样，只是把`fetch`换成`send`。

```objective-c
@interface NASendData () <DFINetworkServiceProtocol>

@end

@implementation NASendData
                            
- (void)sendDataWithURLParamaters:(NSDictionary *)paramaters
                      resultBlock:(DFIAPIRequestResultBlock)resultBlock {
    [DFINetworkAPIRequest requestWithURL:nil
                              paramaters:paramaters
                             requestType:DFINetworkManagerHTTPPOSTRequest
                             resultBlock:resultBlock];
}

@end
```

使用block的方式获取结果。

```objective-c
- (void)sendDataByBlock {
    [DFINetworkService sendDataByName:@"NASendData"
                            paramaters:nil
                           resultBlock:^(id ret) {
                               
                           }];
}
```

#### 下载与上传

##### 下载

```objective-c
[DFINetworkService downloadDataWithURL:(NSString *)URLString
                           destination:(NSString *)filePath
                         progressBlock:^(double progress, int64_t totalCountUnit)){}
                          successBlock:^(NSURLSessionDataTask *sessionDataTask, id ret){}
                             failBlock:^(NSError *error){}];
```

##### 上传

```objective-c
[DFINetworkService uploadDataToURL:(NSString *)URLString
                          withData:(NSData *)data
                     progressBlock:^(double progress, int64_t totalCountUnit)){}
                      successBlock:^(NSURLSessionDataTask *sessionDataTask, id ret){}
                         failBlock:^(NSError *error){}
```

#### 配置

##### HTTP配置

设置HTTP头

```objective-c
[[DFINetworkHTTPConfiguration defaultConfiguration] setValue:forHTTPHeaderField:];
```

##### HTTPS配置

For security, new an instance of `DFINetworkHTTPSecurityConfiguration`.

#### 缓存

缓存底层为`NSURLCache`, 缓存默认为开启状态。

关闭缓存 `[DFINetworkService enableURLCache:NO]`

清除缓存 `[DFINetworkService clearCache]`

#### 日志

日志默认为关闭状态。

打开请求日志  `[DFINetworkService setEnableLogRequest:YES]`.

打开结果日志 `[DFINetworkService setEnableLogResult:YES]`.

## 许可证

DFINetworkManager发布在MIT许可证下。详见LICENSE。
