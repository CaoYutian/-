//
//  LoginRequest.m
//  内部信息管理系统
//
//  Created by Sunshine on 2017/7/10.
//  Copyright © 2017年 Sunshine. All rights reserved.
//

#import "LoginRequest.h"

@interface LoginRequest ()
@property (nonatomic,copy) void (^loginSuccessBlock)();
@property (nonatomic,copy) void (^loginFailureBlock)();
@end

@implementation LoginRequest

- (NSString *)requestPath
{
    return Login_Url;
}

- (APIManagerRequestType)requestType
{
    return APIManagerRequestTypePost;
}

- (Class)responseClass
{
    return [LoginResponse class];
}

#pragma mark - public
+ (void)autoReloginSuccess:(void(^)())success failure:(void(^)())failure
{
    NSLog(@"%@-%@",userManager.userData.phoneNumber,userManager.password);
    LoginRequest *loginRequest = [[LoginRequest alloc] init];
    loginRequest.paramSource = (id)loginRequest;
    loginRequest.delegate = (id)loginRequest;
    if (userManager.userData.phoneNumber.length && userManager.password.length) {
        loginRequest.loginSuccessBlock = ^ {
            success();
        };
        loginRequest.loginFailureBlock = ^ {
            failure();
        };
        [loginRequest loadDataWithHUDOnView:nil];
    } else {
        failure();
    }
}

#pragma mark - APIManagerApiCallBackDelegate
- (void)managerCallAPIDidSuccess:(APIRequest *)request
{
    if (request==self) {
        if (self.loginSuccessBlock) {
            self.loginSuccessBlock();
        }
    }
}

- (void)managerCallAPIDidFailed:(APIRequest *)request
{
    if (request==self) {
        if (self.loginFailureBlock) {
            self.loginFailureBlock();
        }
        return;
    }
}

#pragma mark - APIManagerParamSourceDelegate
- (NSDictionary *)paramsForApi:(APIRequest *)request
{
    if (request==self) {
        return @{@"uname":userManager.userData.phoneNumber,
                 @"upass":userManager.password};
    }
    return nil;
}

@end

@implementation LoginResponse



@end

