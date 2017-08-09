//
//  AmountRequest.m
//  内部信息管理系统
//
//  Created by Sunshine on 2017/7/19.
//  Copyright © 2017年 Sunshine. All rights reserved.
//

#import "AmountRequest.h"

@implementation AmountRequest

- (NSString *)requestPath {
    return Contrast_index;
}

- (APIManagerRequestType)requestType {
    return APIManagerRequestTypePost;
}

- (Class)responseClass {
    return [AmountResponse class];
}

@end

@implementation AmountResponse

+ (NSDictionary *)modelContainerPropertyGenericClass {
    return @{@"data" : [AmountModel class]};
}

@end
