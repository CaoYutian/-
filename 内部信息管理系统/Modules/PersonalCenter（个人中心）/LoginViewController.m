//
//  LoginViewController.m
//  内部信息管理系统
//
//  Created by Sunshine on 2017/7/24.
//  Copyright © 2017年 Sunshine. All rights reserved.
//

#import "LoginViewController.h"
#import "logInView.h"
#import "UIView+TransitionAnimation.h"
#import "LoginRequest.h"
@interface LoginViewController ()
@property(nonatomic,strong)LoginRequest *loginRequest;
@property (nonatomic, copy) NSString *uname;
@property (nonatomic, copy) NSString *upass;

@end

@implementation LoginViewController

- (void)viewWillDisappear:(BOOL)animated {
    [self resignFirstResponder];
}

- (void)viewDidLoad {
    [super viewDidLoad];
    
    logInView *logInV = [[logInView alloc] initWithFrame:self.view.bounds];
    logInV.titleLabel.text = @"中旖内控系统";
    logInV.titleLabel.textColor = [UIColor grayColor];
    logInV.hideEyesType = NOEyesHide;
    [self.view addSubview:logInV];
    
    [logInV setClickBlock:^(NSString *accountText, NSString *passwordText) {
        [self logInClickaccount:accountText password:passwordText];
    }];
}

#pragma mark - APIManagerParamSourceDelegate
- (NSDictionary *)paramsForApi:(APIRequest *)request{
    if (request == self.loginRequest) {
        return @{@"uname":self.uname,
                 @"upass":self.upass
                 };
    }
    return nil;
}

#pragma mark - APIManagerApiCallBackDelegate
- (void)managerCallAPIDidSuccess:(APIRequest *)request{
    if (request == self.loginRequest) {
        userManager.userData = ((LoginResponse *)request.responseData).data;
        [UserManager saveLocalUserLoginInfo];

        [self.view.window addTransitionAnimationWithDuration:1.0 andType:TransitionRippleEffect andSubTupe:From_TOP];
        switch (userManager.userData.power) {
            case 1:
                [kAppDelegate loadMainVC];
                break;
            case 2:
                [kAppDelegate loadOperaVC];
                break;
        }
        return;
    }
}

#pragma Mark 请求失败
- (void)managerCallAPIDidFailed:(APIRequest *)request {
    
}

#pragma mark 登录
- (void)logInClickaccount:(NSString *)account password:(NSString *)password {
    self.uname = account;
    self.upass = password;

    [self.loginRequest loadDataWithHUDOnView:self.view];
}

-(LoginRequest *)loginRequest {
    if (!_loginRequest) {
        _loginRequest = [[LoginRequest alloc] initWithDelegate:self paramSource:self];
    }
    return _loginRequest;
}

@end
