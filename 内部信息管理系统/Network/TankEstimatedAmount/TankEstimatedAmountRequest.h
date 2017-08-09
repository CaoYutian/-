//
//  TankEstimatedAmountRequest.h
//  内部信息管理系统
//
//  Created by Sunshine on 2017/7/31.
//  Copyright © 2017年 Sunshine. All rights reserved.
//

#import "APIRequest.h"
#import "TankMonitoringDetailModel.h"

@interface TankEstimatedAmountRequest : APIRequest <APIManager>

@end

@interface TankEstimatedAmountResponse : BaseResponse
@property(nonatomic,strong) TankMonitoringDetailModel *data;

@end
