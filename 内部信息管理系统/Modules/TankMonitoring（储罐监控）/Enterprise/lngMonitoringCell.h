//
//  lngMonitoringCell.h
//  内部信息管理系统
//
//  Created by Sunshine on 2017/7/12.
//  Copyright © 2017年 Sunshine. All rights reserved.
//

#import "BaseTableViewCell.h"

@interface lngMonitoringCell : BaseTableViewCell

@property (nonatomic, strong) UILabel *enterPriseName;
@property (nonatomic, strong) UILabel *cumulativeDosage;
@property (nonatomic, strong) UILabel *liquidLevel;
@property (nonatomic, strong) UILabel *state;

@end
