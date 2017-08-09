//
//  ReconciliationRequest.h
//  内部信息管理系统
//
//  Created by Sunshine on 2017/7/13.
//  Copyright © 2017年 Sunshine. All rights reserved.
//

#import "APIRequest.h"

@interface ReconciliationRequest : APIRequest <APIManager>

@end

@interface ReconciliationResponse : BaseResponse
@property(nonatomic,strong)NSArray *data;
@end
