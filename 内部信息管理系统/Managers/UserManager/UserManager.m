//
//  UserManager.m
//  内部信息管理系统
//
//  Created by Sunshine on 2017/7/10.
//  Copyright © 2017年 Sunshine. All rights reserved.
//

#import "UserManager.h"
#import "KeyChainManager.h"


#define USER_DATA @"USER_DATA"

@interface UserManager ()
//用户信息请求
@end

@implementation UserManager

+ (instancetype)sharedInstance {
    static UserManager *sharedInstance;
    static dispatch_once_t once;
    dispatch_once(&once, ^{
        sharedInstance = [[self alloc] init];
    });
    return sharedInstance;
}

- (instancetype)init {
    if (self = [super init]) {
        _userData = [[UserModel alloc] init];
    }
    return self;
}

- (void)updatePassword:(NSString *)password
{
    if (!password.length) {
        return;
    }
    [KeyChainManager save:kKeyPassword data:password];
}

+ (void)saveLocalUserLoginInfo {
    NSUserDefaults *userDefaults = [NSUserDefaults standardUserDefaults];
    NSData *data = [NSKeyedArchiver archivedDataWithRootObject:[UserManager sharedInstance].userData];
    [userDefaults setObject:data forKey:USER_DATA];
    [userDefaults synchronize];
}

+ (void)removeLocalUserLoginInfo {
    NSUserDefaults *userDefaults = [NSUserDefaults standardUserDefaults];
    [userDefaults removeObjectForKey:USER_DATA];
    [userDefaults synchronize];
}

+ (void)initWithLocalUserLoginInfo {
    NSUserDefaults *userDefaults = [NSUserDefaults standardUserDefaults];
    UserModel *user = [NSKeyedUnarchiver unarchiveObjectWithData:[userDefaults objectForKey:USER_DATA]];
    [UserManager sharedInstance].userData = user;
    DLog(@"%@-%@",user.phoneNumber,userManager.password);
}

@end
