//
//  DosageAnalysisVC.m
//  内部信息管理系统
//
//  Created by Sunshine on 2017/7/12.
//  Copyright © 2017年 Sunshine. All rights reserved.
//

#import "DosageAnalysisVC.h"
#import "DeliveryTimeView.h"
#import "DosageARequest.h"
#import "DosageAModel.h"
#import "DosageACell.h"

@interface DosageAnalysisVC ()<UISearchBarDelegate,UITableViewDelegate,UITableViewDataSource>

@property (nonatomic, strong) DosageARequest *dosageARequest;

@property (nonatomic, strong) UITableView *tableView;
@property (nonatomic, strong) NSMutableArray *dataArray;
@property (nonatomic, strong) NSMutableArray *dataArray2;

@property (nonatomic, strong) DosageAModel *data;

@end

@implementation DosageAnalysisVC

- (void)viewDidLoad {
    [super viewDidLoad];
    self.titleLabel.text = @"用量分析";

    self.automaticallyAdjustsScrollViewInsets = NO;
    
    self.dosageARequest = [[DosageARequest alloc] initWithDelegate:self paramSource:self];
    [self.dosageARequest loadDataWithHUDOnView:self.view];
}

- (void)loadSubViews {
    [super loadSubViews];
    [self.contentView mas_updateConstraints:^(MASConstraintMaker *make) {
        make.edges.equalTo(self.view).insets(UIEdgeInsetsMake(0, 0, 49, 0));
    }];
    
    [self.contentView addSubview:self.tableView];
}

- (void)loadData {
    [self.dosageARequest loadDataWithHUDOnView:nil];
}

#pragma mark - APIManagerParamSourceDelegate
- (NSDictionary *)paramsForApi:(APIRequest *)request{
    if (request == self.dosageARequest) {
        return @{@"account_type":@"2"};
    }
    return nil;
}

#pragma mark - APIManagerApiCallBackDelegate
- (void)managerCallAPIDidSuccess:(APIRequest *)request{
    [self handleConcurrencyRequest];
    if (request == self.dosageARequest) {
        
        return;
    }
    
}


- (void)managerCallAPIDidFailed:(APIRequest *)request {
    [self handleConcurrencyRequest];
    if (request == self.dosageARequest) {

        DosageAModel *goodsData = [[DosageAModel alloc] init];
        goodsData.all_name = @"xx包装";
        goodsData.vl = @"3000m³";
        goodsData.yw_change = @"22.5吨";
        goodsData.cz = @"20%";
        self.dataArray = [NSMutableArray arrayWithObjects:goodsData,goodsData,goodsData,goodsData, nil];
        
        dischargPlanModel *model = [[dischargPlanModel alloc] init];
        model.lngCar = @"槽车A";
        model.liquidSource = @"液源";
        model.address1 = @"卸液点1";
        model.address2 = @"卸液点2";
        model.address3 = @"卸液点3";
        self.dataArray2 = [NSMutableArray arrayWithObjects:model,model, nil];

        [self.tableView reloadData];
        
        return;
    }
    
}

-(void)handleConcurrencyRequest {
    [self.tableView.mj_header endRefreshing];
    [self.tableView.mj_footer endRefreshing];
}

#pragma mark - UITableViewDataSource
-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    if (section == 0) {
        return self.dataArray.count;
    }else {
        return self.dataArray2.count;
    }
}

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return 2;
}

-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    if (indexPath.section == 0) {
        DosageACell *cell = [tableView dequeueReusableCellWithIdentifier:@"cell"];
        if (!cell) {
            cell = [[DosageACell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:@"cell"];
        }
        [((DosageACell *)cell) setCellData:self.dataArray[indexPath.row] atIndexPath:indexPath];
        
        return cell;
    }else {
        dischargPlanCell *cell = [tableView dequeueReusableCellWithIdentifier:@"dischargPlanCell"];
        if (!cell) {
            cell = [[dischargPlanCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:@"dischargPlanCell"];
        }
        [((dischargPlanCell *)cell) setCellData:self.dataArray2[indexPath.row] atIndexPath:indexPath];
        
        return cell;
    }

}

#pragma mark - UITableViewDelegate
-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    return FitheightRealValue(50);
}

- (UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section {
    UIView *headerView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, CYTMainScreen_WIDTH, FitheightRealValue(50))];
    NSArray *titles = @[@"推荐分卸点:",@"分卸方案:"];
    [CYTUtiltyHelper addLabelWithFrame:CGRectMake(FitwidthRealValue(13), 0, CYTMainScreen_WIDTH - FitwidthRealValue(26), FitheightRealValue(50)) LabelFont:FitFont(16) LabelTextColor:BLACKCOLOR LabelTextAlignment:NSTextAlignmentLeft SuperView:headerView LabelTag:400 + section LabelText:titles[section]];
    headerView.backgroundColor = WHITECOLOR;
    UIView *line = [[UIView alloc] initWithFrame:CGRectMake(0, FitheightRealValue(49), CYTMainScreen_WIDTH, FitheightRealValue(1))];
    line.backgroundColor = MainBackgroundColor;
    [headerView addSubview:line];
    return headerView;
}

- (UIView *)tableView:(UITableView *)tableView viewForFooterInSection:(NSInteger)section {
    if (section == 0) {
        UIView *footView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, CYTMainScreen_WIDTH, FitheightRealValue(50))];
        [CYTUtiltyHelper addbuttonWithRect:CGRectMake(0, 0, CYTMainScreen_WIDTH, FitheightRealValue(40)) LabelText:@"添加分卸点" TextFont:FitFont(16) NormalTextColor:BLACKCOLOR highLightTextColor:BLACKCOLOR tag:402 SuperView:footView buttonTarget:self Action:@selector(addUnloadAddress)];
        UIView *line = [[UIView alloc] initWithFrame:CGRectMake(0, FitheightRealValue(40), CYTMainScreen_WIDTH, FitheightRealValue(10))];
        line.backgroundColor = MainBackgroundColor;
        [footView addSubview:line];
        return footView;
    }else {
        return NULL;
    }

}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    
}

- (CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section {
    CGFloat height = section == 0 ? FitheightRealValue(50) : 0;
    return height;
}

- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section {
    return FitheightRealValue(50);
}

#pragma mark addUnloadAddress
- (void)addUnloadAddress {
    
}

- (UITableView *)tableView {
    if (!_tableView) {
        _tableView = [[UITableView alloc] initWithFrame:CGRectMake(0, 49, CYTMainScreen_WIDTH, CYTMainScreen_HEIGHT - 49) style:UITableViewStylePlain];
        [_tableView registerClass:[DosageACell class] forCellReuseIdentifier:@"cell"];
        [_tableView registerClass:[dischargPlanCell class] forCellReuseIdentifier:@"dischargPlanCell"];
        _tableView.showsVerticalScrollIndicator = NO;
        _tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
        _tableView.delegate = self;
        _tableView.dataSource = self;
    }
    return _tableView;
}


@end
