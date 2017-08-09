//
//  TankMonitoringRequest.m
//  内部信息管理系统
//
//  Created by Sunshine on 2017/7/12.
//  Copyright © 2017年 Sunshine. All rights reserved.
//

#import "TankMonitoringRequest.h"
#import "lngMonitoringModel.h"

@implementation TankMonitoringRequest

- (NSString *)requestPath {
    return CXJK_Home;
}

- (APIManagerRequestType)requestType {
    return APIManagerRequestTypeGet;
}

- (Class)responseClass {
    return [TankMonitoringResponse class];
}

@end

@implementation TankMonitoringResponse

+ (NSDictionary *)modelContainerPropertyGenericClass {
    return @{@"data" : [lngMonitoringModel class]};
}

@end
