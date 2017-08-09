//
//  TankMDetailTopView.h
//  内部信息管理系统
//
//  Created by Sunshine on 2017/7/21.
//  Copyright © 2017年 Sunshine. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "TankMonitoringDetailModel.h"

typedef void (^callBackBlock)(NSString *date);
@interface TankMDetailTopView : UIView

@property (nonatomic, strong) UILabel *estimatedAmount;
@property (nonatomic, strong) UITextField *estimatedAmountTf;
@property (nonatomic, strong) UILabel *largestAmount;
@property (nonatomic, strong) UILabel *instantaneousDelivery;
@property (nonatomic, strong) UILabel *currentLevel;
@property (nonatomic, strong) UILabel *volumeOfGas;
@property (nonatomic, strong) UILabel *timeRemaining;

@property (nonatomic, strong) UIView *line;
@property (nonatomic, strong) UILabel *date;

- (void)setData:(TankMonitoringDetailModel *)data;
- (void)callBack:(callBackBlock)callBack;

@end
