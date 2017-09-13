//
//  TankMDetailTopView.m
//  内部信息管理系统
//
//  Created by Sunshine on 2017/7/21.
//  Copyright © 2017年 Sunshine. All rights reserved.
//

#import "TankMDetailTopView.h"
#import "DeliveryTimeView.h"

@implementation TankMDetailTopView {
    void (^_block) (NSString *date);
}

- (instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        [self CreateUI];
    }
    return self;
}

- (void)CreateUI {
    
    self.backgroundColor = WHITECOLOR;
    
    //预估用量
    [self addSubview:self.estimatedAmount];
    [self.estimatedAmount mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.mas_top).offset(FitheightRealValue(10));
        make.left.equalTo(self.mas_left).offset(FitwidthRealValue(13));
        make.height.mas_equalTo(FitheightRealValue(25));
    }];
    
    [self addSubview:self.estimatedAmountTf];
    [self.estimatedAmountTf mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self.estimatedAmount.mas_right).offset(FitwidthRealValue(5));
        make.centerY.mas_equalTo(self.estimatedAmount.mas_centerY);
        make.height.mas_equalTo(FitheightRealValue(25));
        make.width.mas_offset(FitwidthRealValue(95));
    }];
    
    //最大用量
    [self addSubview:self.largestAmount];
    [self.largestAmount mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.mas_top).offset(FitheightRealValue(10));
        make.left.equalTo(self.mas_centerX).offset(FitwidthRealValue(13));
        make.height.mas_equalTo(FitheightRealValue(25));
    }];
    
    //瞬时流量
    [self addSubview:self.instantaneousDelivery];
    [self.instantaneousDelivery mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.estimatedAmount.mas_bottom);
        make.left.equalTo(self.mas_left).offset(FitwidthRealValue(13));
        make.height.mas_equalTo(FitheightRealValue(25));
    }];
    
    //当期液位
    [self addSubview:self.currentLevel];
    [self.currentLevel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.estimatedAmount.mas_bottom);
        make.left.equalTo(self.mas_centerX).offset(FitwidthRealValue(13));
        make.height.mas_equalTo(FitheightRealValue(25));
    }];
    
    //气体体积
    [self addSubview:self.volumeOfGas];
    [self.volumeOfGas mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.instantaneousDelivery.mas_bottom);
        make.left.equalTo(self.mas_left).offset(FitwidthRealValue(13));
        make.height.mas_equalTo(FitheightRealValue(25));
    }];
    
    //预估剩余时间
    [self addSubview:self.timeRemaining];
    [self.timeRemaining mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.instantaneousDelivery.mas_bottom);
        make.left.equalTo(self.mas_centerX).offset(FitwidthRealValue(13));
        make.height.mas_equalTo(FitheightRealValue(25));
    }];
    
    [self addSubview:self.line];
    [self.line mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.right.equalTo(self);
        make.top.equalTo(self.volumeOfGas.mas_bottom).offset(FitheightRealValue(5));
        make.height.mas_equalTo(FitheightRealValue(1));
    }];
    
    [self addSubview:self.date];
    [self.date mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.right.equalTo(self);
        make.top.equalTo(self.line.mas_bottom);
        make.height.mas_equalTo(FitheightRealValue(40));
    }];
}

- (void)setData:(TankMonitoringDetailModel *)data {
    TankMonitoringDetailModel *model = data;
    
    if (model.yg.integerValue) {
        self.estimatedAmountTf.text = model.yg;
    }
    
    self.largestAmount.text = [NSString stringWithFormat:@"最大用量：%.2f",[model.most doubleValue]];
    self.instantaneousDelivery.text = [NSString stringWithFormat:@"瞬时用量：%.2fm³/小时",[model.vl_hour doubleValue]];
    self.currentLevel.text = [NSString stringWithFormat:@"当前液位：%.2fmm",[model.f_yw doubleValue]];
    self.volumeOfGas.text = [NSString stringWithFormat:@"气体体积：%.2fm³",[model.qttj doubleValue]];
    self.timeRemaining.text = [NSString stringWithFormat:@"预估剩余时间：%.2f小时",[model.yugu_time doubleValue]];
}

- (NSString *)getTimeNow {
    NSDateFormatter * formatter = [[NSDateFormatter alloc ] init];
    [formatter setDateFormat:@"YYYY-MM-dd"];
    NSString* date = [formatter stringFromDate:[NSDate date]];
    return date;
}

#pragma mark 选择日期
- (void)chooseDate {
    [self.estimatedAmountTf resignFirstResponder];
    DeliveryTimeView *deliveryTimeView = [[DeliveryTimeView alloc] init];
    deliveryTimeView.isSingle = YES;
    [deliveryTimeView showInView:self];
    
    [deliveryTimeView getDeliveryTime:^(NSString *startTime, NSString *endTime) {
        self.date.text = [NSString stringWithFormat:@"%@",startTime];
        [self RequestData:startTime];
    }];
}

- (void)callBack:(callBackBlock)callBack {
    _block = callBack;
}

- (void)RequestData:(NSString *)date {
    if (_block) {
        _block(date);
    }
}

- (UILabel *)estimatedAmount {
    if (!_estimatedAmount) {
        _estimatedAmount = [[UILabel alloc] init];
        _estimatedAmount.textColor = BLACKCOLOR;
        _estimatedAmount.text = @"预估用量:";
        _estimatedAmount.font = FitFont(14);
    }
    return _estimatedAmount;
}

-(UITextField *)estimatedAmountTf {
    if (!_estimatedAmountTf) {
        _estimatedAmountTf = [[UITextField alloc] init];
        _estimatedAmountTf.textColor = [UIColor orangeColor];
        _estimatedAmountTf.keyboardType = UIKeyboardTypeASCIICapableNumberPad;
        _estimatedAmountTf.borderStyle = UITextBorderStyleRoundedRect;
        _estimatedAmountTf.font = FitFont(14);
        _estimatedAmountTf.placeholder = @"请输入用量";
    }
    return _estimatedAmountTf;
}

- (UILabel *)largestAmount {
    if (!_largestAmount) {
        _largestAmount = [[UILabel alloc] init];
        _largestAmount.textColor = BLACKCOLOR;
        _largestAmount.text = @"最大用量:";
        _largestAmount.font = FitFont(14);
    }
    return _largestAmount;
}

- (UILabel *)instantaneousDelivery {
    if (!_instantaneousDelivery) {
        _instantaneousDelivery = [[UILabel alloc] init];
        _instantaneousDelivery.textColor = BLACKCOLOR;
        _instantaneousDelivery.text = @"瞬时流量:";
        _instantaneousDelivery.font = FitFont(14);
    }
    return _instantaneousDelivery;
}

- (UILabel *)currentLevel {
    if (!_currentLevel) {
        _currentLevel = [[UILabel alloc] init];
        _currentLevel.textColor = BLACKCOLOR;
        _currentLevel.text = @"当前液位:";
        _currentLevel.font = FitFont(14);
    }
    return _currentLevel;
}

- (UILabel *)volumeOfGas {
    if (!_volumeOfGas) {
        _volumeOfGas = [[UILabel alloc] init];
        _volumeOfGas.textColor = BLACKCOLOR;
        _volumeOfGas.text = @"气体体积:";
        _volumeOfGas.font = FitFont(14);
    }
    return _volumeOfGas;
}

- (UILabel *)timeRemaining {
    if (!_timeRemaining) {
        _timeRemaining = [[UILabel alloc] init];
        _timeRemaining.textColor = BLACKCOLOR;
        _timeRemaining.text = @"预估剩余时间:";
        _timeRemaining.font = FitFont(14);
    }
    return _timeRemaining;
}

- (UIView *)line {
    if (!_line) {
        _line = [[UIView alloc] init];
        _line.backgroundColor = MainBackgroundColor;
    }
    return _line;
}

- (UILabel *)date {
    if (!_date) {
        _date = [[UILabel alloc] init];
        _date.textColor = BLACKCOLOR;
        _date.font = FitFont(16);
        _date.text = [self getTimeNow];
        _date.textAlignment = NSTextAlignmentCenter;
        WS(weakSelf);
        [_date setTapActionWithBlock:^{
            [weakSelf chooseDate];
        }];
    }
    return _date;
}

@end
