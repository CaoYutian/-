//
//  TankMonitoringDetailVC.m
//  内部信息管理系统
//
//  Created by Sunshine on 2017/7/21.
//  Copyright © 2017年 Sunshine. All rights reserved.
//

#import "TankMonitoringDetailVC.h"
#import "TankMDetailTopView.h"
#import "TankMonitoringDetailModel.h"
#import "TankMonitoringDetailRequest.h"
#import "TankEstimatedAmountRequest.h"

#import "TankMDetailCell.h"


@interface TankMonitoringDetailVC ()<UITableViewDelegate,UITableViewDataSource,UITextFieldDelegate>

@property (nonatomic, strong) TankMonitoringDetailRequest *tankMonitoringDetailRequest;
@property (nonatomic, strong) TankEstimatedAmountRequest *tankEstimatedAmountRequest;

@property (nonatomic, strong) UITableView *tableView;
@property (nonatomic, strong) NSMutableArray *dataArray;
@property (nonatomic, strong) TankMonitoringDetailModel *data;

@property (nonatomic, strong) TankMDetailTopView *topView;

@end

@implementation TankMonitoringDetailVC

- (void)viewDidLoad {
    [super viewDidLoad];

    self.tankMonitoringDetailRequest = [[TankMonitoringDetailRequest alloc] initWithDelegate:self paramSource:self];
    [self.tankMonitoringDetailRequest loadDataWithHUDOnView:self.contentView];

    self.tankEstimatedAmountRequest = [[TankEstimatedAmountRequest alloc] initWithDelegate:self paramSource:self];
}

- (void)loadSubViews {
    [super loadSubViews];
    [self.contentView mas_updateConstraints:^(MASConstraintMaker *make) {
        make.edges.equalTo(self.view).insets(UIEdgeInsetsMake(0, 0, 0, 0));
    }];
    
    self.topView = [[TankMDetailTopView alloc] initWithFrame:CGRectMake(0, 64, CYTMainScreen_WIDTH, FitheightRealValue(140))];
    self.topView.estimatedAmountTf.delegate = self;
    [self.topView callBack:^(NSString *date) {
        [self.tankMonitoringDetailRequest loadDataWithHUDOnView:self.contentView];
    }];
    
    [self.contentView addSubview:self.topView];
    [self.contentView addSubview:self.tableView];

}

#pragma mark - APIManagerParamSourceDelegate
- (NSDictionary *)paramsForApi:(APIRequest *)request{
    if (request == self.tankMonitoringDetailRequest) {
        return @{@"qz_id":self.qz_id, @"date":self.topView.date.text};
    }
    
    if (request == self.tankEstimatedAmountRequest) {
        return @{@"qz_id":self.qz_id, @"vl":self.topView.estimatedAmountTf.text};
    }
    
    return nil;
}

#pragma mark - APIManagerApiCallBackDelegate
- (void)managerCallAPIDidSuccess:(APIRequest *)request{
    [self handleConcurrencyRequest];
    if (request == self.tankMonitoringDetailRequest) {
    self.data = [request.responseData valueForKey:@"data"];
    self.dataArray = [self.data.person mutableCopy];
    [self.topView setData:self.data];
    self.titleLabel.text = self.data.all_name;

    [self.tableView reloadData];
    return;
    }
    
    if (request == self.tankEstimatedAmountRequest) {
        NSLog(@"====成功");
    }
}

- (void)managerCallAPIDidFailed:(APIRequest *)request {

}

-(void)handleConcurrencyRequest {
    [self.tableView.mj_header endRefreshing];
    [self.tableView.mj_footer endRefreshing];
}

#pragma mark - textFieldDelegate
- (void)textFieldDidEndEditing:(UITextField *)textField {
    if (self.topView.estimatedAmountTf.text.length) {
        [self.tankEstimatedAmountRequest loadDataWithHUDOnView:self.contentView];
    }
}

#pragma mark - UITableViewDataSource
-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return self.dataArray.count;
}

-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    TankMDetailCell *cell = [tableView dequeueReusableCellWithIdentifier:@"cell"];
    if (!cell) {
        cell = [[TankMDetailCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:@"cell"];
    }
    [((TankMDetailCell *)cell) setCellData:self.dataArray[indexPath.row] atIndexPath:indexPath];
    
    return cell;
}

#pragma mark - UITableViewDelegate
-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    return FitheightRealValue(50);
}

- (UITableView *)tableView
{
    if (!_tableView) {
        _tableView = [[UITableView alloc] initWithFrame:CGRectMake(0, self.topView.bottom + FitheightRealValue(10), CYTMainScreen_WIDTH, CYTMainScreen_HEIGHT - FitheightRealValue(150) - 64) style:UITableViewStylePlain];
        [_tableView registerClass:[TankMDetailCell class] forCellReuseIdentifier:@"cell"];
        _tableView.showsVerticalScrollIndicator = NO;
        _tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
        _tableView.delegate = self;
        _tableView.dataSource = self;
    }
    return _tableView;
}


@end
