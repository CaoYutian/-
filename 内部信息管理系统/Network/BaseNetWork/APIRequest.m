//
//  BaseAPIManager.m
//  CQArchitecture
//
//  Created by KevinCao on 2016/12/1.
//  Copyright © 2016年 caoqun. All rights reserved.
//

#import "APIRequest.h"
#import "APIProxy.h"
#import "LoginRequest.h"

@interface APIRequest ()

@property (nonatomic, copy, readwrite) NSString *errorMessage;
@property (nonatomic, copy, readwrite) NSString *successMessage;
@property (nonatomic, readwrite) APIManagerErrorType errorType;
@property (nonatomic, strong) NSMutableArray *requestIdList;
@property (nonatomic, strong)UIView *hudSuperView;
@property (nonatomic, assign)NSInteger reloginCount;

@end

@implementation APIRequest

-(instancetype)initWithDelegate:(id)delegate paramSource:(id)paramSource
{
    self = [super init];
    if (self) {
        _delegate = delegate;
        _paramSource = paramSource;
        _validator = (id)self;
        _errorType = APIManagerErrorTypeDefault;
        
        if ([self conformsToProtocol:@protocol(APIManager)]) {
            self.child = (id <APIManager>)self;
        }
    }
    return self;
}

- (instancetype)init
{
    self = [super init];
    if (self) {
        _delegate = nil;
        _paramSource = nil;
        _validator = (id)self;
        _errorType = APIManagerErrorTypeDefault;
        
        if ([self conformsToProtocol:@protocol(APIManager)]) {
            self.child = (id <APIManager>)self;
        }
    }
    return self;
}

- (void)dealloc
{
    [self cancelAllRequests];
    self.requestIdList = nil;
}

#pragma mark - calling api
-(NSInteger)loadDataWithHUDOnView:(UIView *)view {
    return [self loadDataWithHUDOnView:view HUDMsg:@""];
}

-(NSInteger)loadDataWithHUDOnView:(UIView *)view HUDMsg:(NSString *)HUDMsg
{
    [self cancelAllRequests];
    if (view) {
        self.hudSuperView = view;
        [MBProgressHUD showLoadingHUD:HUDMsg onView:self.hudSuperView];
    }
    NSDictionary *params = [self.paramSource paramsForApi:self];
    if ([self.child respondsToSelector:@selector(reformParamsForApi:)]) {
        params = [self.child reformParamsForApi:params];
    }

    params = [self signatureParams:params];
    DLog(@"****--->>%@",params);
    NSInteger requestId = [self loadDataWithParams:params];
    return requestId;
}

- (NSInteger)loadDataWithParams:(NSDictionary *)params {
    NSInteger requestId = 0;
    if ([self isReachable]) {
        if ([self.child respondsToSelector:@selector(requestSerializer)]) {
            [APIProxy sharedInstance].requestSerializer = self.child.requestSerializer;
        } else {
            [APIProxy sharedInstance].requestSerializer = [AFHTTPRequestSerializer serializer];
        }
        if ([self.child respondsToSelector:@selector(responseSerializer)]) {
            [APIProxy sharedInstance].responseSerializer = self.child.responseSerializer;
        } else {
            [APIProxy sharedInstance].responseSerializer = [AFJSONResponseSerializer serializer];
        }
        
        [[APIProxy sharedInstance] callAPIWithRequestType:self.child.requestType params:params requestPath:self.child.requestPath uploadBlock:[self.paramSource respondsToSelector:@selector(uploadBlock:)]?[self.paramSource uploadBlock:self]:nil success:^(APIResponse *response) {
            [self successedOnCallingAPI:response];
        } fail:^(APIResponse *response) {
            [self failedOnCallingAPI:response withErrorType:response.errorType];
        }];
        [self.requestIdList addObject:@(requestId)];
        return requestId;
        
    } else {
        [self failedOnCallingAPI:nil withErrorType:APIManagerErrorTypeNoNetWork];
        return requestId;
    }
    return requestId;
}

- (void)successedOnCallingAPI:(APIResponse *)response
{
    if (self.hudSuperView) {
        [MBProgressHUD hideLoadingHUD];
    }
    [self removeRequestIdWithRequestID:response.requestId];
    DLog(@"%@:%@", [self.child requestPath],response.responseData);
    if ([self.child respondsToSelector:@selector(responseClass)]) {
        self.responseData =  [[self.child responseClass] yy_modelWithDictionary:response.responseData];
        DLog(@"message:==%@",self.responseData.msg);
        if (self.responseData.err != 1) {
            response.message = self.responseData.msg;
            [self failedOnCallingAPI:response withErrorType:APIManagerErrorTypeDefault];
            return;
        }
    } else {
        self.responseData = response.responseData;
    }
    
    if ([self.validator respondsToSelector:@selector(manager:isCorrectWithCallBackData:)] && ![self.validator manager:self isCorrectWithCallBackData:self.responseData]) {
        [self failedOnCallingAPI:response withErrorType:APIManagerErrorTypeNoContent];
    } else {
        if ([self.child respondsToSelector:@selector(reformData)]) {
            [self.child reformData];
        }
        [self.delegate managerCallAPIDidSuccess:self];
    }
}

- (void)failedOnCallingAPI:(APIResponse *)response withErrorType:(APIManagerErrorType)errorType {
    if (self.hudSuperView) {
        [MBProgressHUD hideLoadingHUD];
    }
    self.errorType = errorType;
    self.message = response.message;
    [self removeRequestIdWithRequestID:response.requestId];
    DLog(@"%@:%@", [self.child requestPath],response.responseData);

    switch (errorType) {
        case APIManagerErrorTypeDefault:
            self.errorMessage = response.message;
            break;
        case APIManagerErrorTypeSuccess:
            break;
        case APIManagerErrorTypeNoContent:
            break;
        case APIManagerErrorTypeParamsError:
            break;
        case APIManagerErrorTypeTimeout:
            self.message = Tip_RequestOutTime;
            break;
        case APIManagerErrorTypeNoNetWork:
            self.message = Tip_NoNetwork;
            break;
        case APIManagerErrorLoginTimeout:
            self.message = Tip_LoginTimeOut;
            break;
        default:
            break;
    }
    if (self.errorType==APIManagerErrorLoginTimeout) {
        if (!self.reloginCount && ![self isKindOfClass:[LoginRequest class]]) {
            self.reloginCount++;
            [LoginRequest autoReloginSuccess:^{
                [self loadDataWithHUDOnView:self.hudSuperView];
            } failure:^{
                [UserManager removeLocalUserLoginInfo];
//                [kAppDelegate loadLoginVC];
            }];
        } else {
            [UserManager removeLocalUserLoginInfo];
            [kAppDelegate loadLoginVC];
        }
    } else {
        [self.delegate managerCallAPIDidFailed:self];
        if (self.hudSuperView && !self.disableErrorTip) {
            [MBProgressHUD showMsgHUD:response.message];
        }
    }
}

#pragma mark - private methods
- (void)cancelAllRequests
{
    [[APIProxy sharedInstance] cancelRequestWithRequestIDList:self.requestIdList];
    [self.requestIdList removeAllObjects];
}

- (void)cancelRequestWithRequestId:(NSInteger)requestID
{
    [self removeRequestIdWithRequestID:requestID];
    [[APIProxy sharedInstance] cancelRequestWithRequestID:@(requestID)];
}

- (void)removeRequestIdWithRequestID:(NSInteger)requestId
{
    NSNumber *requestIDToRemove = nil;
    for (NSNumber *storedRequestId in self.requestIdList) {
        if ([storedRequestId integerValue] == requestId) {
            requestIDToRemove = storedRequestId;
        }
    }
    if (requestIDToRemove) {
        [self.requestIdList removeObject:requestIDToRemove];
    }
}

- (NSDictionary *)signatureParams:(NSDictionary *)params {
    if (![params isKindOfClass:[NSDictionary class]]) {
        return nil;
    }
    //获取token
    NSString *user_token = [UserManager sharedInstance].userData.user_token;
    if (CYTStringIsEmpty(user_token)) {
        user_token = @"-1";
    }
    
    NSMutableDictionary *signParams = [[NSMutableDictionary alloc] init];
    [signParams addEntriesFromDictionary:params];
    signParams[@"token"] = user_token;
    
    NSString *str2 = [self stringWithDict:signParams];
    
    NSString *sign = [CommonUtils MD5:str2];
    NSString *signature = [sign uppercaseString];
    NSMutableDictionary *newParams = [params mutableCopy];
    newParams[@"sign"] = signature;
    newParams[@"token"] = user_token;
    return newParams;
}

#pragma mark 参数按Key排序
-(NSString*)stringWithDict:(NSDictionary*)dict{
    
    NSArray*keys = [dict allKeys];
    NSArray*sortedArray = [keys sortedArrayUsingComparator:^NSComparisonResult(id obj1,id obj2) {
        return[obj1 compare:obj2 options:NSNumericSearch];//正序
    }];
    NSString*str =@"";
    for(NSString*categoryId in sortedArray) {
        
        id value = [dict objectForKey:categoryId];
        if([value isKindOfClass:[NSDictionary class]]) {
            value = [self stringWithDict:value];
        }
        
        if([str length] !=0) {
            str = [str stringByAppendingString:@"&"];
        }
        
        str = [str stringByAppendingFormat:@"%@=%@",categoryId,value];
    }
    NSString *Str = [NSString stringWithFormat:@"%@%@",str,@"&key=appsecret"];
    return Str;
}

#pragma mark - getters and setters
- (BOOL)isReachable
{
    if ([AFNetworkReachabilityManager sharedManager].networkReachabilityStatus == AFNetworkReachabilityStatusUnknown) {
        return YES;
    } else {
        return [[AFNetworkReachabilityManager sharedManager] isReachable];
    }
}

- (NSMutableArray *)requestIdList
{
    if (_requestIdList == nil) {
        _requestIdList = [[NSMutableArray alloc] init];
    }
    return _requestIdList;
}

@end
