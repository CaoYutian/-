//
//  UserManager.h
//  内部信息管理系统
//
//  Created by Sunshine on 2017/7/10.
//  Copyright © 2017年 Sunshine. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface UserManager : NSObject

+ (instancetype)sharedInstance;
+ (BOOL)isLogedin;
+ (void)saveLocalUserLoginInfo;
+ (void)removeLocalUserLoginInfo;
+ (void)initWithLocalUserLoginInfo;

- (void)updatePassword:(NSString *)password;

-(void)requestUserInfoWithHUDOnView:(UIView *)view;

@property(nonatomic, strong) UserModel *userData;
@property(nonatomic, copy) NSString *password;

@end
