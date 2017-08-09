//
//  AmountCell.h
//  内部信息管理系统
//
//  Created by Sunshine on 2017/7/19.
//  Copyright © 2017年 Sunshine. All rights reserved.
//

#import "BaseTableViewCell.h"

@interface AmountCell : BaseTableViewCell

@property (nonatomic, strong) UILabel *userName;
@property (nonatomic, strong) UILabel *traffic;
@property (nonatomic, strong) UILabel *liquidLevelChange;
@property (nonatomic, strong) UILabel *differenceValue;

@end
