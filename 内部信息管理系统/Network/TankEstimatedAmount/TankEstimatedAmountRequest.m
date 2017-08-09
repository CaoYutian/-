//
//  TankEstimatedAmountRequest.m
//  内部信息管理系统
//
//  Created by Sunshine on 2017/7/31.
//  Copyright © 2017年 Sunshine. All rights reserved.
//

#import "TankEstimatedAmountRequest.h"

@implementation TankEstimatedAmountRequest

- (NSString *)requestPath {
    return CXJK_Home_detail_EAmount;
}

- (APIManagerRequestType)requestType {
    return APIManagerRequestTypeGet;
}

- (Class)responseClass {
    return [TankEstimatedAmountResponse class];
}
@end

@implementation TankEstimatedAmountResponse

@end
