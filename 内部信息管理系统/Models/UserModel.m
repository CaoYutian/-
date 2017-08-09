//
//  UserModel.m
//  内部信息管理系统
//
//  Created by Sunshine on 2017/7/10.
//  Copyright © 2017年 Sunshine. All rights reserved.
//

#import "UserModel.h"

@implementation UserModel
- (id)copyWithZone:(NSZone *)zone {
    return [self yy_modelCopy];
}

- (instancetype)init {
    if (self = [super init]) {
        _last_login_time = @"";
        _nickname = @"";
        _row_number = @"";
        _nickname = @"";
    }
    return self;
}

+ (NSDictionary *)modelCustomPropertyMapper {
    return @{@"last_login_time":@"last_login_time",
             @"nickname":@"nickname",
             @"power":@"power",
             @"row_number":@"row_number",
             @"user_id":@"user_id",
             @"user_name":@"user_name",
             @"user_token":@"user_token",
             };
}

- (void)encodeWithCoder:(NSCoder *)aCoder {
    [self yy_modelEncodeWithCoder:aCoder];
}

- (instancetype)initWithCoder:(NSCoder *)aDecoder {
    if (self = [super init]) {
        [self yy_modelInitWithCoder:aDecoder];
    }
    return self;
}

@end
