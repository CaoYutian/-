//
//  TankMonitoringDetailRequest.h
//  内部信息管理系统
//
//  Created by Sunshine on 2017/7/21.
//  Copyright © 2017年 Sunshine. All rights reserved.
//

#import "APIRequest.h"
#import "TankMonitoringDetailModel.h"

@interface TankMonitoringDetailRequest : APIRequest <APIManager>

@end

@interface TankMonitoringDetailResponse : BaseResponse
@property(nonatomic,strong) TankMonitoringDetailModel *data;

@end
