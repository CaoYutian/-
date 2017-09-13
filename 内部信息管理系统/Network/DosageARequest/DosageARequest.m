//
//  DosageARequest.m
//  内部信息管理系统
//
//  Created by Sunshine on 2017/8/3.
//  Copyright © 2017年 Sunshine. All rights reserved.
//

#import "DosageARequest.h"
#import "DosageAModel.h"

@implementation DosageARequest

- (NSString *)requestPath {
    return Fenxie_index;
}

- (APIManagerRequestType)requestType {
    return APIManagerRequestTypePost;
}

- (Class)responseClass {
    return [DosageAResponse class];
}

@end

@implementation DosageAResponse
+ (NSDictionary *)modelContainerPropertyGenericClass {
    return @{@"data" : [DosageAAllModel class]};
}

@end

@implementation DosageAAllModel

- (id)copyWithZone:(NSZone *)zone {
    return [self yy_modelCopy];
}

+ (NSDictionary *)modelContainerPropertyGenericClass {
    return @{@"data" : [DosageAModel class],
             @"need" : [dischargPlanModel class],};
}

@end
