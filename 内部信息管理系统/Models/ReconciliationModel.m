//
//  ReconciliationModel.m
//  内部信息管理系统
//
//  Created by Sunshine on 2017/7/13.
//  Copyright © 2017年 Sunshine. All rights reserved.
//

#import "ReconciliationModel.h"

@implementation ReconciliationModel

+ (NSDictionary *)modelCustomPropertyMapper {
    return@{@"gongqi_id" :@"id"};
}

- (id)copyWithZone:(NSZone *)zone {
    return [self yy_modelCopy];
}

@end
