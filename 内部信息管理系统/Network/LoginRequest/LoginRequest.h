//
//  LoginRequest.h
//  内部信息管理系统
//
//  Created by Sunshine on 2017/7/10.
//  Copyright © 2017年 Sunshine. All rights reserved.
//

#import "APIRequest.h"

@interface LoginRequest : APIRequest <APIManager>

+ (void)autoReloginSuccess:(void(^)())success failure:(void(^)())failure;

@end

@interface LoginResponse : BaseResponse
@property(nonatomic,strong)UserModel *data;
@end
