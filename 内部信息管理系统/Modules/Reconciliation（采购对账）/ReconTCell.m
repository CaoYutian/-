//
//  ReconTCell.m
//  内部信息管理系统
//
//  Created by Sunshine on 2017/7/13.
//  Copyright © 2017年 Sunshine. All rights reserved.
//

#import "ReconTCell.h"
#import "ReconciliationModel.h"

@interface ReconTCell ()
@property (nonatomic, strong) UIView *line;

@end

@implementation ReconTCell

- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier {
    if (self = [super initWithStyle:style reuseIdentifier:reuseIdentifier]) {
        [self buildCellView];
    }
    return self;
}

- (void)buildCellView{
    
    self.contentView.backgroundColor = WHITECOLOR;
    //车牌号
    [self.contentView addSubview:self.plateNumbers];
    [self.plateNumbers mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.contentView.mas_top).offset(FitheightRealValue(0));
        make.left.equalTo(self.contentView.mas_left).offset(FitwidthRealValue(10));
        make.height.mas_equalTo(FitheightRealValue(50));
        make.width.mas_equalTo((CYTMainScreen_WIDTH - FitwidthRealValue(40)) / 5);
    }];
    
    //用户名
    [self.contentView addSubview:self.userName];
    [self.userName mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.contentView.mas_top).offset(FitheightRealValue(0));
        make.left.equalTo(self.plateNumbers.mas_right).offset(FitwidthRealValue(8));
        make.height.mas_equalTo(FitheightRealValue(50));
        make.width.mas_equalTo((CYTMainScreen_WIDTH - FitwidthRealValue(56)) / 4);
    }];
    
    [self.contentView addSubview:self.condition];
    [self.condition mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.contentView.mas_top).offset(FitheightRealValue(10));
        make.right.equalTo(self.contentView.mas_right).offset(-FitwidthRealValue(13));
        make.size.mas_equalTo(CGSizeMake(FitwidthRealValue(30), FitheightRealValue(30)));
    }];
    
    //卸液量
    [self.contentView addSubview:self.lngDosage];
    [self.lngDosage mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.contentView.mas_top).offset(FitheightRealValue(0));
        make.left.equalTo(self.userName.mas_right).offset(FitwidthRealValue(8));
        make.height.mas_equalTo(FitheightRealValue(50));
        make.width.mas_equalTo(FitwidthRealValue(70));
    }];
    
    [self.contentView addSubview:self.liquidLevelError];
    [self.liquidLevelError mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.contentView.mas_top).offset(FitheightRealValue(0));
        make.left.equalTo(self.lngDosage.mas_right).offset(FitwidthRealValue(8));
        make.right.equalTo(self.condition.mas_left).offset(-FitwidthRealValue(8));
        make.height.mas_equalTo(FitheightRealValue(50));
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
    
    ReconciliationModel *model = (ReconciliationModel *)item;

    self.plateNumbers.text = model.car_id;
    self.userName.text = model.short_name;
    self.lngDosage.text = [NSString stringWithFormat:@"%@吨",model.xcl];
    if (model.flag.integerValue) {
        self.liquidLevelError.text = [NSString stringWithFormat:@"%.2f%@",[model.ywwc doubleValue],@"%"];
    }else {
        self.liquidLevelError.text = @"N/A";
    }
}

- (void)changeState {
    _condition.selected = !_condition.isSelected;
}

- (UILabel *)plateNumbers {
    if (!_plateNumbers) {
        _plateNumbers = [[UILabel alloc] init];
        _plateNumbers.font = FitFont(14);
        _plateNumbers.textAlignment = NSTextAlignmentLeft;
        _plateNumbers.textColor = [UIColor grayColor];
        _plateNumbers.lineBreakMode = NSLineBreakByCharWrapping;
        _plateNumbers.numberOfLines = 0;
    }
    return _plateNumbers;
}

- (UILabel *)userName {
    if (!_userName) {
        _userName = [[UILabel alloc] init];
        _userName.font = FitFont(14);
        _userName.textAlignment = NSTextAlignmentLeft;
        _userName.lineBreakMode = NSLineBreakByCharWrapping;
        _userName.numberOfLines = 0;
        _userName.textColor = [UIColor grayColor];
    }
    return _userName;
}

- (UILabel *)lngDosage {
    if (!_lngDosage) {
        _lngDosage = [[UILabel alloc] init];
        _lngDosage.textAlignment = NSTextAlignmentLeft;
        _lngDosage.font = FitFont(14);
        _lngDosage.textColor = [UIColor grayColor];
        _lngDosage.lineBreakMode = NSLineBreakByCharWrapping;
        _lngDosage.numberOfLines = 0;
    }
    return _lngDosage;
}

- (UILabel *)liquidLevelError {
    if (!_liquidLevelError) {
        _liquidLevelError = [[UILabel alloc] init];
        _liquidLevelError.textAlignment = NSTextAlignmentLeft;
        _liquidLevelError.font = FitFont(14);
        _liquidLevelError.textColor = [UIColor grayColor];
        _liquidLevelError.lineBreakMode = NSLineBreakByCharWrapping;
        _liquidLevelError.numberOfLines = 0;
    }
    return _liquidLevelError;
}

- (UIButton *)condition {
    if (!_condition) {
        _condition = [[UIButton alloc] init];
    }
    return _condition;
}

@end
