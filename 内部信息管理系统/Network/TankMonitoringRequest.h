//
//  TankMonitoringRequest.h
//  内部信息管理系统
//
//  Created by Sunshine on 2017/7/12.
//  Copyright © 2017年 Sunshine. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface TankMonitoringRequest : APIRequest <APIManager>

@end

@interface TankMonitoringResponse : BaseResponse
@property(nonatomic,strong)NSArray *data;
@end
