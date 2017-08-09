//
//  TankMonitoringDetailRequest.m
//  内部信息管理系统
//
//  Created by Sunshine on 2017/7/21.
//  Copyright © 2017年 Sunshine. All rights reserved.
//

#import "TankMonitoringDetailRequest.h"

@implementation TankMonitoringDetailRequest

- (NSString *)requestPath {
    return CXJK_Home_detail;
}

- (APIManagerRequestType)requestType {
    return APIManagerRequestTypePost;
}

- (Class)responseClass {
    return [TankMonitoringDetailResponse class];
}

@end

@implementation TankMonitoringDetailResponse

//+ (NSDictionary *)modelContainerPropertyGenericClass {
//    return @{@"data" : [TankMonitoringDetailModel class]};
//}

@end
