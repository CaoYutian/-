//
//  DosageARequest.h
//  内部信息管理系统
//
//  Created by Sunshine on 2017/8/3.
//  Copyright © 2017年 Sunshine. All rights reserved.
//

#import "APIRequest.h"
#import "DosageAModel.h"

@interface DosageARequest : APIRequest

@end

@interface DosageAResponse : BaseResponse
@property (nonatomic, strong) NSArray *data;


@end
