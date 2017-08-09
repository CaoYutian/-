//
//  TankMonitoringVC.m
//  内部信息管理系统
//
//  Created by Sunshine on 2017/7/12.
//  Copyright © 2017年 Sunshine. All rights reserved.
//

#import "TankMonitoringVC.h"
#import "lngMonitoringModel.h"
#import "lngMonitoringCell.h"
#import "TankMonitoringRequest.h"
#import "TankMonitoringDetailVC.h"


@interface TankMonitoringVC ()<UITableViewDelegate,UITableViewDataSource>

@property (nonatomic, strong) TankMonitoringRequest *tankMonitoringRequest;
@property (nonatomic, strong) UITableView *tableView;
@property (nonatomic, strong) NSMutableArray *dataArray;
@property (nonatomic, strong) lngMonitoringModel *data;


@end

@implementation TankMonitoringVC

- (void)viewDidLoad {
    [super viewDidLoad];
    self.titleLabel.text = @"储罐监控";
    self.automaticallyAdjustsScrollViewInsets = NO;

    self.tankMonitoringRequest = [[TankMonitoringRequest alloc] initWithDelegate:self paramSource:self];
    [self.tankMonitoringRequest loadDataWithHUDOnView:self.view];
    
}

- (void)loadSubViews {
    [super loadSubViews];
    [self.contentView mas_updateConstraints:^(MASConstraintMaker *make) {
        make.edges.equalTo(self.view).insets(UIEdgeInsetsMake(0, 0, 0, 0));
    }];
    
    [self.contentView addSubview:self.tableView];
    
}

#pragma mark - APIManagerParamSourceDelegate
- (NSDictionary *)paramsForApi:(APIRequest *)request{
    if (request == self.tankMonitoringRequest) {
        return @{@"uid":[UserManager sharedInstance].userData.user_id};
    }
    return nil;
}

#pragma mark - APIManagerApiCallBackDelegate
- (void)managerCallAPIDidSuccess:(APIRequest *)request{
    [self handleConcurrencyRequest];
    if (request == self.tankMonitoringRequest) {
        self.dataArray = [[((TankMonitoringResponse *)request.responseData) valueForKey:@"data"] mutableCopy];
        
        [self.tableView reloadData];
        return;
    }
}

- (void)managerCallAPIDidFailed:(APIRequest *)request {
    [self handleConcurrencyRequest];
    NSLog(@"失败");
}

-(void)handleConcurrencyRequest {
    [self.tableView.mj_header endRefreshing];
    [self.tableView.mj_footer endRefreshing];
}

#pragma mark - UITableViewDataSource
-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return self.dataArray.count;
}

-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    lngMonitoringCell *cell = [tableView dequeueReusableCellWithIdentifier:@"cell"];
    if (!cell) {
        cell = [[lngMonitoringCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:@"cell"];
    }
    [((lngMonitoringCell *)cell) setCellData:self.dataArray[indexPath.row] atIndexPath:indexPath];
    
    return cell;
}

#pragma mark - UITableViewDelegate
-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    return FitheightRealValue(65);
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    self.data = (lngMonitoringModel *)self.dataArray[indexPath.row];
    TankMonitoringDetailVC *tankDetailVC = [[TankMonitoringDetailVC alloc] init];
    tankDetailVC.qz_id = self.data.qz_id;
    [AppCommon pushViewController:tankDetailVC animated:YES];
}

- (UITableView *)tableView {
    if (!_tableView) {
        _tableView = [[UITableView alloc] initWithFrame:CGRectMake(0, 44, CYTMainScreen_WIDTH, CYTMainScreen_HEIGHT - 64 - 49) style:UITableViewStylePlain];
        [_tableView registerClass:[lngMonitoringCell class] forCellReuseIdentifier:@"cell"];
        _tableView.showsVerticalScrollIndicator = NO;
        _tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
        _tableView.delegate = self;
        _tableView.dataSource = self;
    }
    return _tableView;
}

@end
