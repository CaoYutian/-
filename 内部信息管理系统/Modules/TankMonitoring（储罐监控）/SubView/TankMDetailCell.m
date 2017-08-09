//
//  TankMDetailCell.m
//  内部信息管理系统
//
//  Created by Sunshine on 2017/7/21.
//  Copyright © 2017年 Sunshine. All rights reserved.
//

#import "TankMDetailCell.h"
#import "TankMonitoringDetailModel.h"

@interface TankMDetailCell ()
@property (nonatomic, strong) UIView *line;

@end

@implementation TankMDetailCell

- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier {
    if (self = [super initWithStyle:style reuseIdentifier:reuseIdentifier]) {
        [self buildCellView];
    }
    return self;
}

- (void)buildCellView{
    
    self.contentView.backgroundColor = WHITECOLOR;
    
    //总流量
    [self.contentView addSubview:self.traffic];
    [self.traffic mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.contentView.mas_top).offset(FitheightRealValue(0));
        make.left.equalTo(self.contentView.mas_left);
        make.height.mas_equalTo(FitheightRealValue(49));
        make.width.mas_equalTo(CYTMainScreen_WIDTH / 4);
    }];
    
    //小时流量
    [self.contentView addSubview:self.hourTraffic];
    [self.hourTraffic mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.contentView.mas_top).offset(FitheightRealValue(0));
        make.left.equalTo(self.traffic.mas_right);
        make.height.mas_equalTo(FitheightRealValue(49));
        make.width.mas_equalTo(CYTMainScreen_WIDTH / 4);
    }];
    
    //液位
    [self.contentView addSubview:self.liquidLevel];
    [self.liquidLevel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.contentView.mas_top).offset(FitheightRealValue(0));
        make.left.equalTo(self.hourTraffic.mas_right);
        make.height.mas_equalTo(FitheightRealValue(49));
        make.width.mas_equalTo(CYTMainScreen_WIDTH / 4);
    }];
    
    //气体体积
    [self.contentView addSubview:self.volumeOfGas];
    [self.volumeOfGas mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.contentView.mas_top);
        make.right.equalTo(self.contentView.mas_right);
        make.height.mas_equalTo(FitheightRealValue(49));
        make.width.mas_equalTo(CYTMainScreen_WIDTH / 4);
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
    
    TankMonitoringDetailModel *model = (TankMonitoringDetailModel *)item;
    
    self.traffic.text = [NSString stringWithFormat:@"%.2fm³",[[model valueForKey:@"vl_tody"] doubleValue]];
    self.hourTraffic.text = [NSString stringWithFormat:@"%.2fm³",[[model valueForKey:@"vl_hour"] doubleValue]];
    self.liquidLevel.text = [NSString stringWithFormat:@"%.2fmm",[[model valueForKey:@"f_yw"] doubleValue]];
    self.volumeOfGas.text = [NSString stringWithFormat:@"%.2fm³",[[model valueForKey:@"qttj"] doubleValue]];
}

- (UILabel *)traffic {
    if (!_traffic) {
        _traffic = [[UILabel alloc] init];
        _traffic.font = FitFont(14);
        _traffic.textColor = [UIColor grayColor];
        _traffic.textAlignment = NSTextAlignmentCenter;
    }
    return _traffic;
}

- (UILabel *)hourTraffic {
    if (!_hourTraffic) {
        _hourTraffic = [[UILabel alloc] init];
        _hourTraffic.font = FitFont(14);
        _hourTraffic.textColor = [UIColor grayColor];
        _hourTraffic.textAlignment = NSTextAlignmentCenter;
    }
    return _hourTraffic;
}

- (UILabel *)liquidLevel {
    if (!_liquidLevel) {
        _liquidLevel = [[UILabel alloc] init];
        _liquidLevel.font = FitFont(14);
        _liquidLevel.textColor = [UIColor grayColor];
        _liquidLevel.textAlignment = NSTextAlignmentCenter;
    }
    return _liquidLevel;
}

- (UILabel *)volumeOfGas {
    if (!_volumeOfGas) {
        _volumeOfGas = [[UILabel alloc] init];
        _volumeOfGas.font = FitFont(14);
        _volumeOfGas.textColor = [UIColor grayColor];
        _volumeOfGas.textAlignment = NSTextAlignmentCenter;
    }
    return _volumeOfGas;
}


@end
