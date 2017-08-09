//
//  AmountRequest.h
//  内部信息管理系统
//
//  Created by Sunshine on 2017/7/19.
//  Copyright © 2017年 Sunshine. All rights reserved.
//

#import "APIRequest.h"
#import "AmountModel.h"

@interface AmountRequest : APIRequest <APIManager>

@end

@interface AmountResponse : BaseResponse
@property(nonatomic,strong) NSArray *data;
@end
