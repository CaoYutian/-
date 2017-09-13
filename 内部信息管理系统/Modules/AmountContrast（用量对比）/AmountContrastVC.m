//
//  AmountContrastVC.m
//  内部信息管理系统
//
//  Created by Sunshine on 2017/7/12.
//  Copyright © 2017年 Sunshine. All rights reserved.
//

#import "AmountContrastVC.h"
#import "DeliveryTimeView.h"
#import "AmountRequest.h"
#import "AmountModel.h"
#import "AmountCell.h"
#import "titleView.h"

@interface AmountContrastVC ()<UISearchBarDelegate,UITableViewDelegate,UITableViewDataSource>

@property (nonatomic, strong) AmountRequest *amountRequest;

@property (nonatomic, strong) UITableView *tableView;
@property (nonatomic, strong) NSMutableArray *dataArray;
@property (nonatomic, strong) AmountModel *data;
@property (nonatomic, strong) NSString *startTime;
@property (nonatomic, strong) NSString *endTime;
//空白页
@property (nonatomic, strong) CustomCommonEmptyView *emptyView;
@property (nonatomic, strong) titleView *titleV;

@end

@implementation AmountContrastVC

- (void)viewDidLoad {
    [super viewDidLoad];
    self.titleLabel.text = @"用量对比";
    self.automaticallyAdjustsScrollViewInsets = NO;
    
    self.searchBar.text = @"";
    self.startTime = @"";
    self.endTime = @"";
    
    self.amountRequest = [[AmountRequest alloc] initWithDelegate:self paramSource:self];
    [self.amountRequest loadDataWithHUDOnView:self.view];
}

- (void)loadSubViews {
    [super loadSubViews];
    [self.contentView mas_updateConstraints:^(MASConstraintMaker *make) {
        make.edges.equalTo(self.view).insets(UIEdgeInsetsMake(0, 0, 0, 0));
    }];
    
    self.chooseTime = [CYTUtiltyHelper addbuttonWithRect:CGRectMake(0, 44, CYTMainScreen_WIDTH, FitheightRealValue(50)) LabelText:@"请选择日期" TextFont:FitFont(16) NormalTextColor:[UIColor grayColor] highLightTextColor:[UIColor grayColor] tag:200 SuperView:self.contentView buttonTarget:self Action:@selector(chooseTimeAction)];
    self.chooseTime.backgroundColor = WHITECOLOR;
    
    self.searchBar = [[UISearchBar alloc] initWithFrame:CGRectMake(0, self.chooseTime.bottom, CYTMainScreen_WIDTH, FitheightRealValue(40))];
    self.searchBar.backgroundImage = [[UIImage alloc] init];
    self.searchBar.delegate = self;
    self.searchBar.placeholder = @"用户名";
    
    self.titleV = [[titleView alloc] initWithFrame:CGRectMake(0, self.searchBar.bottom, CYTMainScreen_WIDTH, FitheightRealValue(40)) titles:@[@"用户名",@"日流量",@"日液位变化",@"差值"]];

    [self.contentView addSubview:self.searchBar];
    [self.contentView addSubview:self.titleV];
    [self.contentView addSubview:self.tableView];
}

- (void)loadData {
    [self.amountRequest loadDataWithHUDOnView:nil];
}

#pragma mark - APIManagerParamSourceDelegate
- (NSDictionary *)paramsForApi:(APIRequest *)request{
    if (request == self.amountRequest) {
        return @{@"name":self.searchBar.text,@"s_date":self.startTime,@"e_date":self.endTime};
    }
    return nil;
}

#pragma mark - APIManagerApiCallBackDelegate
- (void)managerCallAPIDidSuccess:(APIRequest *)request{
    [self handleConcurrencyRequest];
    if (request == self.amountRequest) {
        self.dataArray = [(request.responseData) valueForKey:@"data"];
        [self.emptyView removeFromSuperview];
        [self.tableView reloadData];
        
        return;
    }
    
}

- (void)managerCallAPIDidFailed:(APIRequest *)request {
    [self.dataArray removeAllObjects];
    [self.tableView reloadData];
    [self.emptyView showInView:self.tableView];
}

-(void)handleConcurrencyRequest {
    [self.tableView.mj_header endRefreshing];
    [self.tableView.mj_footer endRefreshing];
}

- (void)chooseTimeAction {
    [self.searchBar resignFirstResponder];
    DeliveryTimeView *deliveryTimeView = [[DeliveryTimeView alloc] init];
    deliveryTimeView.isSingle = NO;
    [deliveryTimeView showInView:self.contentView];
    
    [deliveryTimeView getDeliveryTime:^(NSString *startTime, NSString *endTime) {
        [self.chooseTime setTitle:[NSString stringWithFormat:@"%@ 到 %@",startTime,endTime] forState:UIControlStateNormal];
        self.startTime = startTime;
        self.endTime = endTime;
        [self loadData];
    }];
    
}

#pragma mark - UITableViewDataSource
-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return self.dataArray.count;
}

-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    AmountCell *cell = [tableView dequeueReusableCellWithIdentifier:@"cell"];
    if (!cell) {
        cell = [[AmountCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:@"cell"];
    }
    [((AmountCell *)cell) setCellData:self.dataArray[indexPath.row] atIndexPath:indexPath];
    
    return cell;
}

#pragma mark - UITableViewDelegate
-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    return FitheightRealValue(50);
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    
}

#pragma mark searchBarDelegate
- (void)searchBarSearchButtonClicked:(UISearchBar *)searchBar {
    [self loadData];
    [self.searchBar resignFirstResponder];
}

- (void)searchBarTextDidBeginEditing:(UISearchBar *)searchBar {
    searchBar.showsCancelButton = YES;       //显示“取消”按钮
    for(UIView *view in  [[[self.searchBar subviews] objectAtIndex:0] subviews]) {
        if([view isKindOfClass:[NSClassFromString(@"UINavigationButton") class]]) {
            UIButton * cancel =(UIButton *)view;
            [cancel setTitle:@"取消" forState:UIControlStateNormal];
            [cancel setTitleColor:[UIColor orangeColor] forState:UIControlStateNormal];
        }
    }
}

-(void)searchBarCancelButtonClicked:(UISearchBar *)searchBar {
    searchBar.showsCancelButton = NO;
    searchBar.text = nil;
    [searchBar resignFirstResponder];
}

- (UITableView *)tableView {
    if (!_tableView) {
        _tableView = [[UITableView alloc] initWithFrame:CGRectMake(0, self.titleV.bottom, CYTMainScreen_WIDTH, CYTMainScreen_HEIGHT - FitheightRealValue(130) - 49 - 64) style:UITableViewStylePlain];
        [_tableView registerClass:[AmountCell class] forCellReuseIdentifier:@"cell"];
        _tableView.showsVerticalScrollIndicator = NO;
        _tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
        _tableView.delegate = self;
        _tableView.dataSource = self;
    }
    return _tableView;
}

- (NSMutableArray *)dataArray {
    if (!_dataArray) {
        _dataArray = [[NSMutableArray alloc] init];
    }
    return _dataArray;
}

- (CustomCommonEmptyView *)emptyView {
    if (!_emptyView) {
        CustomCommonEmptyView *empty = [[CustomCommonEmptyView alloc] initWithTitle:@"暂无数据" secondTitle:@"请选择其他日期!" iconname:@"emptyPic"];
        [self.tableView addSubview:empty];
        _emptyView = empty;
    }
    return _emptyView;
}

@end
