//
//  lngMonitoringCell.m
//  内部信息管理系统
//
//  Created by Sunshine on 2017/7/12.
//  Copyright © 2017年 Sunshine. All rights reserved.
//

#import "lngMonitoringCell.h"
#import "lngMonitoringModel.h"

@interface lngMonitoringCell ()
@property (nonatomic, strong) UIView *line;

@end

@implementation lngMonitoringCell

- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier {
    if (self = [super initWithStyle:style reuseIdentifier:reuseIdentifier]) {
        [self buildCellView];
    }
    return self;
}

- (void)buildCellView {
    
    self.contentView.backgroundColor = WHITECOLOR;
    
    //企业名称
    [self.contentView addSubview:self.enterPriseName];
    [self.enterPriseName mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.contentView.mas_top).offset(FitheightRealValue(10));
        make.left.equalTo(self.contentView.mas_left).offset(FitwidthRealValue(13));
        make.height.mas_equalTo(FitheightRealValue(25));
    }];
    
    //小时用量
    [self.contentView addSubview:self.cumulativeDosage];
    [self.cumulativeDosage mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.enterPriseName.mas_bottom).offset(0);
        make.left.equalTo(self.contentView.mas_left).offset(FitwidthRealValue(13));
        make.height.mas_equalTo(FitheightRealValue(25));
        make.width.mas_equalTo(CYTMainScreen_WIDTH / 3 + FitwidthRealValue(10));
    }];
    
    //剩余时间
    [self.contentView addSubview:self.liquidLevel];
    [self.liquidLevel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.enterPriseName.mas_bottom).offset(0);
        make.left.equalTo(self.cumulativeDosage.mas_right).offset(FitwidthRealValue(20));
        make.height.mas_equalTo(FitheightRealValue(25));
    }];
    
    //状态
    [self.contentView addSubview:self.state];
    [self.state mas_makeConstraints:^(MASConstraintMaker *make) {
        make.right.mas_equalTo(FitwidthRealValue(-5));
        make.centerY.mas_equalTo(self.contentView);
        make.size.mas_equalTo(CGSizeMake(FitwidthRealValue(60), FitheightRealValue(30)));
    }];
    
    self.line = [[UIView alloc] init];
    self.line.backgroundColor = MainBackgroundColor;
    [self.contentView addSubview:self.line];
    [self.line mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.right.equalTo(self.contentView);
        make.height.mas_equalTo(FitheightRealValue(1));
        make.bottom.equalTo(self.contentView).offset(-FitheightRealValue(0));
    }];
}

- (void)setCellData:(id)item atIndexPath:(NSIndexPath *)indexPath  {
    lngMonitoringModel *lngMonitoring = (lngMonitoringModel *)item;
    
    self.enterPriseName.text = lngMonitoring.all_name;
    self.cumulativeDosage.text = [NSString stringWithFormat:@"小时用量:%.2f方",[lngMonitoring.vl_hour floatValue]];
    
    if (lngMonitoring.time.integerValue) {
        self.liquidLevel.text = [NSString stringWithFormat:@"预估剩余时间:%.2f小时",[lngMonitoring.time floatValue]];
    }else {
        self.liquidLevel.text = [NSString stringWithFormat:@"预估剩余时间:--小时"];
    }
    
    self.state.text = lngMonitoring.flag;
    if (!lngMonitoring.flag.integerValue) {
        self.state.text = @"异常";
        self.state.layer.borderColor = [UIColor redColor].CGColor;
        self.state.textColor = [UIColor redColor];
    }else {
        self.state.text = @"正常";
    }
}

- (UILabel *)enterPriseName {
    if (!_enterPriseName) {
        _enterPriseName = [[UILabel alloc] init];
        _enterPriseName.font = FitFont(16);
        _enterPriseName.textColor = BLACKCOLOR;
    }
    return _enterPriseName;
}

- (UILabel *)cumulativeDosage {
    if (!_cumulativeDosage) {
        _cumulativeDosage = [[UILabel alloc] init];
        _cumulativeDosage.font = FitFont(14);
        _cumulativeDosage.textColor = [UIColor grayColor];
    }
    return _cumulativeDosage;
}

- (UILabel *)liquidLevel {
    if (!_liquidLevel) {
        _liquidLevel = [[UILabel alloc] init];
        _liquidLevel.font = FitFont(14);
        _liquidLevel.textColor = [UIColor grayColor];
    }
    return _liquidLevel;
}

- (UILabel *)state {
    if (!_state) {
        _state = [[UILabel alloc] init];
        _state.layer.masksToBounds = YES;
        _state.layer.cornerRadius = 5;
        _state.layer.borderColor = [UIColor greenColor].CGColor;
        _state.textColor = [UIColor greenColor];
        _state.layer.borderWidth = 1.0;
        _state.textAlignment = NSTextAlignmentCenter;
    }
    return _state;
}

@end
