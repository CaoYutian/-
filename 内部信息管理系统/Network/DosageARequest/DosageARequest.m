//
//  DosageARequest.m
//  内部信息管理系统
//
//  Created by Sunshine on 2017/8/3.
//  Copyright © 2017年 Sunshine. All rights reserved.
//

#import "DosageARequest.h"

@implementation DosageARequest

- (NSString *)requestPath {
    return @"";
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
    return @{@"data" : [DosageAModel class]};
}

@end
