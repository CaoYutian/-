//
//  DosageACell.h
//  内部信息管理系统
//
//  Created by Sunshine on 2017/8/3.
//  Copyright © 2017年 Sunshine. All rights reserved.
//

#import "BaseTableViewCell.h"

@interface DosageACell : BaseTableViewCell

@property (nonatomic, strong) UILabel *userName;
@property (nonatomic, strong) UILabel *dailyDosage;
@property (nonatomic, strong) UILabel *remainNum;
@property (nonatomic, strong) UILabel *percentage;

@end

@interface dischargPlanCell : BaseTableViewCell

@property (nonatomic, strong) UILabel *lngCar;
@property (nonatomic, strong) UILabel *liquidSource;
@property (nonatomic, strong) UILabel *address1;
@property (nonatomic, strong) UILabel *address2;
@property (nonatomic, strong) UILabel *address3;

@end
