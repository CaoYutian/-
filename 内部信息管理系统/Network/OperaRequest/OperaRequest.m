//
//  OperaRequest.m
//  内部信息管理系统
//
//  Created by Sunshine on 2017/8/2.
//  Copyright © 2017年 Sunshine. All rights reserved.
//

#import "OperaRequest.h"

@implementation OperaRequest

- (NSString *)requestPath
{
    return Photo_upload;
}

- (APIManagerRequestType)requestType
{
    return APIManagerRequestTypeUpload;
}

- (Class)responseClass
{
    return [OperaReponse class];
}

@end

@implementation OperaReponse



@end
