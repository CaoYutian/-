//
//  ReconTCell.h
//  内部信息管理系统
//
//  Created by Sunshine on 2017/7/13.
//  Copyright © 2017年 Sunshine. All rights reserved.
//

#import "BaseTableViewCell.h"

@interface ReconTCell : BaseTableViewCell

@property (nonatomic, strong) UILabel *plateNumbers;
@property (nonatomic, strong) UILabel *userName;
@property (nonatomic, strong) UILabel *lngDosage;
@property (nonatomic, strong) UILabel *liquidLevelError;
@property (nonatomic, strong) UIButton *condition;

@end
