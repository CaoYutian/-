//
//  AmountCell.m
//  内部信息管理系统
//
//  Created by Sunshine on 2017/7/19.
//  Copyright © 2017年 Sunshine. All rights reserved.
//

#import "AmountCell.h"
#import "AmountModel.h"

@interface AmountCell ()
@property (nonatomic, strong) UIView *line;

@end

@implementation AmountCell

- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier {
    if (self = [super initWithStyle:style reuseIdentifier:reuseIdentifier]) {
        [self buildCellView];
    }
    return self;
}

- (void)buildCellView{
    
    self.contentView.backgroundColor = WHITECOLOR;
    
    //用户名
    [self.contentView addSubview:self.userName];
    [self.userName mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.contentView.mas_top).offset(FitheightRealValue(0));
        make.left.equalTo(self.contentView.mas_left).offset(FitwidthRealValue(13));
        make.height.mas_equalTo(FitheightRealValue(50));
        make.width.mas_equalTo((CYTMainScreen_WIDTH - FitwidthRealValue(56)) / 4);
    }];
    
    //日用量
    [self.contentView addSubview:self.traffic];
    [self.traffic mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.contentView.mas_top).offset(FitheightRealValue(0));
        make.left.equalTo(self.userName.mas_right).offset(FitwidthRealValue(10));
        make.height.mas_equalTo(FitheightRealValue(50));
        make.width.mas_equalTo((CYTMainScreen_WIDTH - FitwidthRealValue(56)) / 4);
    }];
    
    //日液位变化
    [self.contentView addSubview:self.liquidLevelChange];
    [self.liquidLevelChange mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.contentView.mas_top).offset(FitheightRealValue(0));
        make.left.equalTo(self.traffic.mas_right).offset(FitwidthRealValue(10));
        make.height.mas_equalTo(FitheightRealValue(50));
        make.width.mas_equalTo((CYTMainScreen_WIDTH - FitwidthRealValue(56)) / 4);
    }];
    
    //差值
    [self.contentView addSubview:self.differenceValue];
    [self.differenceValue mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.contentView.mas_top).offset(FitheightRealValue(0));
        make.left.equalTo(self.liquidLevelChange.mas_right).offset(FitwidthRealValue(10));
        make.height.mas_equalTo(FitheightRealValue(50));
        make.width.mas_equalTo((CYTMainScreen_WIDTH - FitwidthRealValue(56)) / 4);
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
    
    AmountModel *model = (AmountModel *)item;
    
    self.userName.text = model.all_name;
    self.traffic.text = [NSString stringWithFormat:@"%.2fm³",[model.vl doubleValue]];
    self.liquidLevelChange.text = [NSString stringWithFormat:@"%.2fmm",[model.yw_change doubleValue]];
    self.differenceValue.text = [NSString stringWithFormat:@"%.2f%@",[model.cz doubleValue],@"%"];
}

- (UILabel *)userName {
    if (!_userName) {
        _userName = [[UILabel alloc] init];
        _userName.font = FitFont(14);
        _userName.lineBreakMode = NSLineBreakByCharWrapping;
        _userName.numberOfLines = 0;
        _userName.textColor = [UIColor grayColor];
        _userName.textAlignment = NSTextAlignmentCenter;
    }
    return _userName;
}

- (UILabel *)traffic {
    if (!_traffic) {
        _traffic = [[UILabel alloc] init];
        _traffic.font = FitFont(14);
        _traffic.lineBreakMode = NSLineBreakByCharWrapping;
        _traffic.numberOfLines = 0;
        _traffic.textColor = [UIColor grayColor];
        _traffic.textAlignment = NSTextAlignmentCenter;
    }
    return _traffic;
}

- (UILabel *)liquidLevelChange {
    if (!_liquidLevelChange) {
        _liquidLevelChange = [[UILabel alloc] init];
        _liquidLevelChange.font = FitFont(14);
        _liquidLevelChange.lineBreakMode = NSLineBreakByCharWrapping;
        _liquidLevelChange.numberOfLines = 0;
        _liquidLevelChange.textColor = [UIColor grayColor];
        _liquidLevelChange.textAlignment = NSTextAlignmentCenter;
    }
    return _liquidLevelChange;
}

- (UILabel *)differenceValue {
    if (!_differenceValue) {
        _differenceValue = [[UILabel alloc] init];
        _differenceValue.font = FitFont(14);
        _differenceValue.lineBreakMode = NSLineBreakByCharWrapping;
        _differenceValue.numberOfLines = 0;
        _differenceValue.textColor = [UIColor grayColor];
        _differenceValue.textAlignment = NSTextAlignmentCenter;
    }
    return _differenceValue;
}

@end
