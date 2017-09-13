//
//  DosageACell.m
//  内部信息管理系统
//
//  Created by Sunshine on 2017/8/3.
//  Copyright © 2017年 Sunshine. All rights reserved.
//

#import "DosageACell.h"
#import "DosageAModel.h"

@interface DosageACell ()
@property (nonatomic, strong) UIView *line;

@end

@implementation DosageACell

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
    [self.contentView addSubview:self.dailyDosage];
    [self.dailyDosage mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.contentView.mas_top).offset(FitheightRealValue(0));
        make.left.equalTo(self.userName.mas_right).offset(FitwidthRealValue(10));
        make.height.mas_equalTo(FitheightRealValue(50));
        make.width.mas_equalTo((CYTMainScreen_WIDTH - FitwidthRealValue(56)) / 4);
    }];
    
    //剩余吨位
    [self.contentView addSubview:self.remainNum];
    [self.remainNum mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.contentView.mas_top).offset(FitheightRealValue(0));
        make.left.equalTo(self.dailyDosage.mas_right).offset(FitwidthRealValue(10));
        make.height.mas_equalTo(FitheightRealValue(50));
        make.width.mas_equalTo((CYTMainScreen_WIDTH - FitwidthRealValue(56)) / 4);
    }];
    
    //百分比
    [self.contentView addSubview:self.percentage];
    [self.percentage mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.contentView.mas_top).offset(FitheightRealValue(0));
        make.right.equalTo(self.contentView.mas_right).offset(-FitwidthRealValue(13));
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
    
    DosageAModel *model = (DosageAModel *)item;
    
    self.userName.text = model.short_name;
    self.dailyDosage.text = [NSString stringWithFormat:@"%.2fm³",[model.agv_vl doubleValue]];
    self.remainNum.text = [NSString stringWithFormat:@"%.2f吨",[model.t_yw doubleValue]];
    self.percentage.text = [NSString stringWithFormat:@"%.2f%@",[model.t_yw doubleValue] / 22 * 100,@"%"];
}

- (UILabel *)userName {
    if (!_userName) {
        _userName = [[UILabel alloc] init];
        _userName.font = FitFont(14);
        _userName.lineBreakMode = NSLineBreakByCharWrapping;
        _userName.numberOfLines = 0;
        _userName.textColor = [UIColor grayColor];
    }
    return _userName;
}

- (UILabel *)dailyDosage {
    if (!_dailyDosage) {
        _dailyDosage = [[UILabel alloc] init];
        _dailyDosage.font = FitFont(14);
        _dailyDosage.lineBreakMode = NSLineBreakByCharWrapping;
        _dailyDosage.numberOfLines = 0;
        _dailyDosage.textColor = [UIColor grayColor];
        _dailyDosage.textAlignment = NSTextAlignmentCenter;
    }
    return _dailyDosage;
}

- (UILabel *)remainNum {
    if (!_remainNum) {
        _remainNum = [[UILabel alloc] init];
        _remainNum.font = FitFont(14);
        _remainNum.lineBreakMode = NSLineBreakByCharWrapping;
        _remainNum.numberOfLines = 0;
        _remainNum.textColor = [UIColor grayColor];
        _remainNum.textAlignment = NSTextAlignmentCenter;
    }
    return _remainNum;
}

- (UILabel *)percentage {
    if (!_percentage) {
        _percentage = [[UILabel alloc] init];
        _percentage.font = FitFont(14);
        _percentage.lineBreakMode = NSLineBreakByCharWrapping;
        _percentage.numberOfLines = 0;
        _percentage.textColor = [UIColor grayColor];
        _percentage.textAlignment = NSTextAlignmentCenter;
    }
    return _percentage;
}

@end

@interface dischargPlanCell ()
@property (nonatomic, strong) UIView *line;

@end

@implementation dischargPlanCell

- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier {
    if (self = [super initWithStyle:style reuseIdentifier:reuseIdentifier]) {
        [self buildCellView];
    }
    return self;
}

- (void)buildCellView{
    
    self.contentView.backgroundColor = WHITECOLOR;
    //槽车
    [self.contentView addSubview:self.lngCar];
    [self.lngCar mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.contentView.mas_top).offset(FitheightRealValue(0));
        make.left.equalTo(self.contentView.mas_left).offset(FitwidthRealValue(13));
        make.height.mas_equalTo(FitheightRealValue(50));
        make.width.mas_equalTo((CYTMainScreen_WIDTH - FitwidthRealValue(66)) / 5);
    }];
    
    //液源
    [self.contentView addSubview:self.liquidSource];
    [self.liquidSource mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.contentView.mas_top).offset(FitheightRealValue(0));
        make.left.equalTo(self.lngCar.mas_right).offset(FitwidthRealValue(10));
        make.height.mas_equalTo(FitheightRealValue(50));
        make.width.mas_equalTo((CYTMainScreen_WIDTH - FitwidthRealValue(66)) / 5);
    }];
    
    //卸液点1
    [self.contentView addSubview:self.address1];
    [self.address1 mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.contentView.mas_top).offset(FitheightRealValue(0));
        make.left.equalTo(self.liquidSource.mas_right).offset(FitwidthRealValue(10));
        make.height.mas_equalTo(FitheightRealValue(50));
        make.width.mas_equalTo((CYTMainScreen_WIDTH - FitwidthRealValue(66)) / 5);
    }];
    
    //卸液点2
    [self.contentView addSubview:self.address2];
    [self.address2 mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.contentView.mas_top).offset(FitheightRealValue(0));
        make.left.equalTo(self.address1.mas_right).offset(FitwidthRealValue(10));
        make.height.mas_equalTo(FitheightRealValue(50));
        make.width.mas_equalTo((CYTMainScreen_WIDTH - FitwidthRealValue(66)) / 5);
    }];
    
    //卸液点3
    [self.contentView addSubview:self.address3];
    [self.address3 mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.contentView.mas_top).offset(FitheightRealValue(0));
        make.left.equalTo(self.address2.mas_right).offset(FitwidthRealValue(10));
        make.height.mas_equalTo(FitheightRealValue(50));
        make.width.mas_equalTo((CYTMainScreen_WIDTH - FitwidthRealValue(66)) / 5);
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
    
    dischargPlanModel *model = (dischargPlanModel *)item;
    
    self.lngCar.text = model.dischargDataArr[0][@"qz_id"];
    self.liquidSource.text = model.dischargDataArr[0][@"short_name"];
    
    switch (model.dischargDataArr.count) {
        case 1:
            self.address1.text = model.dischargDataArr[model.dischargDataArr.count - 1][@"short_name"];
            self.address2.text = @"暂无";
            self.address3.text = @"暂无";
            break;
            
        case 2:
            self.address1.text = model.dischargDataArr[model.dischargDataArr.count - 2][@"short_name"];
            self.address2.text = model.dischargDataArr[model.dischargDataArr.count - 1][@"short_name"];
            self.address3.text = @"暂无";
            break;
            
        case 3:
            self.address1.text = model.dischargDataArr[model.dischargDataArr.count - 3][@"short_name"];
            self.address2.text = model.dischargDataArr[model.dischargDataArr.count - 2][@"short_name"];
            self.address3.text = model.dischargDataArr[model.dischargDataArr.count - 1][@"short_name"];
            break;
    }
    
}

- (UILabel *)lngCar {
    if (!_lngCar) {
        _lngCar = [[UILabel alloc] init];
        _lngCar.font = FitFont(14);
        _lngCar.lineBreakMode = NSLineBreakByCharWrapping;
        _lngCar.numberOfLines = 0;
        _lngCar.textColor = [UIColor grayColor];
        _lngCar.textAlignment = NSTextAlignmentCenter;

    }
    return _lngCar;
}

- (UILabel *)liquidSource {
    if (!_liquidSource) {
        _liquidSource = [[UILabel alloc] init];
        _liquidSource.font = FitFont(14);
        _liquidSource.lineBreakMode = NSLineBreakByCharWrapping;
        _liquidSource.numberOfLines = 0;
        _liquidSource.textColor = [UIColor grayColor];
        _liquidSource.textAlignment = NSTextAlignmentCenter;

    }
    return _liquidSource;
}

- (UILabel *)address1 {
    if (!_address1) {
        _address1 = [[UILabel alloc] init];
        _address1.font = FitFont(14);
        _address1.lineBreakMode = NSLineBreakByCharWrapping;
        _address1.numberOfLines = 0;
        _address1.textColor = [UIColor grayColor];
        _address1.textAlignment = NSTextAlignmentCenter;
    }
    return _address1;
}

- (UILabel *)address2 {
    if (!_address2) {
        _address2 = [[UILabel alloc] init];
        _address2.font = FitFont(14);
        _address2.lineBreakMode = NSLineBreakByCharWrapping;
        _address2.numberOfLines = 0;
        _address2.textColor = [UIColor grayColor];
        _address2.textAlignment = NSTextAlignmentCenter;

    }
    return _address2;
}

- (UILabel *)address3 {
    if (!_address3) {
        _address3 = [[UILabel alloc] init];
        _address3.font = FitFont(14);
        _address3.lineBreakMode = NSLineBreakByCharWrapping;
        _address3.numberOfLines = 0;
        _address3.textColor = [UIColor grayColor];
        _address3.textAlignment = NSTextAlignmentCenter;

    }
    return _address3;
}

@end
