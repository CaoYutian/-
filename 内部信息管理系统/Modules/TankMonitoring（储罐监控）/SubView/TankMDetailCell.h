//
//  TankMDetailCell.h
//  内部信息管理系统
//
//  Created by Sunshine on 2017/7/21.
//  Copyright © 2017年 Sunshine. All rights reserved.
//

#import "BaseTableViewCell.h"

@interface TankMDetailCell : BaseTableViewCell

@property (nonatomic, strong) UILabel *traffic;
@property (nonatomic, strong) UILabel *hourTraffic;
@property (nonatomic, strong) UILabel *liquidLevel;
@property (nonatomic, strong) UILabel *volumeOfGas;

@end
