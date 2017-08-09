//
//  UserModel.h
//  内部信息管理系统
//
//  Created by Sunshine on 2017/7/10.
//  Copyright © 2017年 Sunshine. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface UserModel : NSObject
//id
@property (nonatomic, copy) NSString *user_id;
//昵称
@property (nonatomic, copy) NSString *nickname;
//用户权限
@property (nonatomic, assign) NSInteger power;
//user_token
@property (nonatomic, copy) NSString *user_token;
//最后登录时间
@property (nonatomic, copy) NSString *last_login_time;
//手机号
@property (nonatomic, copy) NSString *phoneNumber;
//row_number
@property (nonatomic, copy) NSString *row_number;
//用户账号
@property (nonatomic, copy) NSString *user_name;
//user_info
@property (nonatomic, strong) NSDictionary *user_info;


@end
