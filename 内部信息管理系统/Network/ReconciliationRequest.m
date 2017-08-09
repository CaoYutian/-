//
//  ReconciliationRequest.m
//  内部信息管理系统
//
//  Created by Sunshine on 2017/7/13.
//  Copyright © 2017年 Sunshine. All rights reserved.
//

#import "ReconciliationRequest.h"
#import "ReconciliationModel.h"
@implementation ReconciliationRequest

- (NSString *)requestPath {
    return Caigouduizhang_index;
}

- (APIManagerRequestType)requestType {
    return APIManagerRequestTypePost;
}

- (Class)responseClass {
    return [ReconciliationResponse class];
}

@end

@implementation ReconciliationResponse

+ (NSDictionary *)modelContainerPropertyGenericClass {
    return @{@"data" : [ReconciliationModel class]};
}

@end
