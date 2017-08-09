//
//  ReconciliationVC.m
//  内部信息管理系统
//
//  Created by Sunshine on 2017/7/12.
//  Copyright © 2017年 Sunshine. All rights reserved.
//

#import "ReconciliationVC.h"
#import "DeliveryTimeView.h"
#import "ReconciliationRequest.h"
#import "ReconciliationModel.h"
#import "ReconTCell.h"
#import "HttpTools.h"

@interface ReconciliationVC ()<UISearchBarDelegate,UITableViewDelegate,UITableViewDataSource>

@property (nonatomic, strong) ReconciliationRequest *reconciliationRequest;

@property (nonatomic, strong) UITableView *tableView;
@property (nonatomic, strong) UIButton *submitBtn;
@property (nonatomic, strong) NSMutableArray *dataArray;
@property (nonatomic, strong) ReconciliationModel *data;
@property (nonatomic, strong) NSMutableArray *optionArray;

@property (nonatomic, strong) NSMutableArray *bigArr;
@property (nonatomic, strong) NSString *signStr;


//空白页
@property (nonatomic, strong) CustomCommonEmptyView *emptyView;

@property (nonatomic, strong) NSString *startTime;
@property (nonatomic, strong) NSString *endTime;

@end

@implementation ReconciliationVC

- (void)viewDidLoad {
    [super viewDidLoad];
    self.titleLabel.text = @"采购对账";
    self.automaticallyAdjustsScrollViewInsets = NO;
    self.searchBar.text = @"";
    self.startTime = @"";
    self.endTime = @"";

    self.reconciliationRequest = [[ReconciliationRequest alloc] initWithDelegate:self paramSource:self];
    [self loadData];
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
    self.searchBar.placeholder = @"车牌号/用户名";
    [self.contentView addSubview:self.searchBar];
    
    [self.contentView addSubview:self.tableView];
    [self.contentView addSubview:self.submitBtn];
    
}

- (void)loadData {
    [self.reconciliationRequest loadDataWithHUDOnView:self.view];
}

#pragma mark - APIManagerParamSourceDelegate
- (NSDictionary *)paramsForApi:(APIRequest *)request{
    if (request == self.reconciliationRequest) {
        return @{@"name":self.searchBar.text,@"s_date":self.startTime,@"e_date":self.endTime};
    }
    return nil;
}

#pragma mark - APIManagerApiCallBackDelegate
- (void)managerCallAPIDidSuccess:(APIRequest *)request{
    [self handleConcurrencyRequest];
    if (request == self.reconciliationRequest) {
        self.dataArray = [[request.responseData valueForKey:@"data"] mutableCopy];
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
    [self.optionArray removeAllObjects];
    for (NSInteger i = 0; i < self.dataArray.count; i++) {
        [self.optionArray addObject:@"NO"];
    }
    return self.dataArray.count;
}

-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    ReconTCell *cell = [tableView dequeueReusableCellWithIdentifier:@"cell"];
    if (!cell) {
        cell = [[ReconTCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:@"cell"];
    }
    [cell.condition setImage:IMAGENAMED(@"unselected") forState:UIControlStateNormal];
    [cell.condition setImage:IMAGENAMED(@"selected") forState:UIControlStateSelected];
    cell.condition.tag = indexPath.row;
    [cell.condition addTarget:self action:@selector(optionClick:) forControlEvents:UIControlEventTouchUpInside];

    if ([_optionArray[indexPath.row] isEqualToString:@"NO"]) {
        cell.condition.selected = NO;
    }else{
        cell.condition.selected = YES;
    }
    [((ReconTCell *)cell) setCellData:self.dataArray[indexPath.row] atIndexPath:indexPath];
    
    return cell;
}

#pragma mark - UITableViewDelegate
-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    return FitheightRealValue(50);
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    
}

- (void)optionClick :(UIButton *)btn {
    self.data = self.dataArray[btn.tag];
    if (btn.selected == YES) {
        [self.optionArray replaceObjectAtIndex:btn.tag withObject:@"NO"];
        NSMutableDictionary *para = [NSMutableDictionary dictionary];
        [para setObject:self.data.gongqi_id forKey:@"gongqi_id"];
        [para setObject:self.data.xcl forKey:@"xcl"];
        [para setObject:self.data.ywwc forKey:@"ywwc"];
        [self.bigArr removeObject:para];
    }else{
        [self.optionArray replaceObjectAtIndex:btn.tag withObject:@"YES"];
        NSMutableDictionary *para = [NSMutableDictionary dictionary];
        [para setObject:self.data.gongqi_id forKey:@"gongqi_id"];
        [para setObject:self.data.xcl forKey:@"xcl"];
        [para setObject:self.data.ywwc forKey:@"ywwc"];
        [self.bigArr addObject:para];
    }
    btn.selected = !btn.selected;

}

#pragma mark 数组转字符串
 - (NSString*)encodeString:(NSString*)unencodedString{
    if(CYT_SYSTEM_VERSION >=9.0) {
        return[unencodedString stringByAddingPercentEncodingWithAllowedCharacters:[NSCharacterSet URLPathAllowedCharacterSet]];
    }
    
    NSString*encodedString = (NSString*)CFBridgingRelease(CFURLCreateStringByAddingPercentEscapes(kCFAllocatorDefault,(CFStringRef)unencodedString,NULL,(CFStringRef)@"!*'();:@&=+$,/?%#[]",kCFStringEncodingUTF8));
    
    return encodedString;
}

#pragma mark submitAction
- (void)submitAction {
    NSMutableDictionary *dict = [NSMutableDictionary dictionary];
    
    NSData *data=[NSJSONSerialization dataWithJSONObject:self.bigArr options:NSJSONWritingPrettyPrinted error:nil];
    NSString *jsonStr=[[NSString alloc]initWithData:data encoding:NSUTF8StringEncoding];
    NSString *urlEncodeStr = [self encodeString:jsonStr];
    self.signStr = [NSString stringWithFormat:@"%@%@&%@",@"data=",urlEncodeStr,@"key=appsecret"];
    NSString *sign = [CommonUtils MD5:self.signStr];
    self.signStr = [sign uppercaseString];

    [dict setObject:urlEncodeStr forKey:@"data"];
    [dict setObject:self.signStr forKey:@"sign"];
    [HttpTools POST:Caigouduizhang_save parameters:dict success:^(NSURLSessionDataTask *task, id responseObject) {
        if ([responseObject[@"err"] integerValue] == 1) {
            [self loadData];
            [self.bigArr removeAllObjects];
        }else {
            
        }
    } failure:^(NSURLSessionDataTask *task, NSError *error) {
        [MBProgressHUD showMsgHUD:@"提交失败"];
    }];
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

- (void)searchBarTextDidEndEditing:(UISearchBar *)searchBar {
    [self loadData];
    [searchBar resignFirstResponder];
}

#pragma mark scroview的协议代理
//向上滑是正值，向下滑动是负值
- (void)scrollViewWillEndDragging:(UIScrollView *)scrollView withVelocity:(CGPoint)velocity targetContentOffset:(inout CGPoint *)targetContentOffset {
    if (velocity.y > 0 ) {
        [UIView animateWithDuration:0.25 animations:^{
            self.navBar.frame = CGRectMake(0, -64, CYTMainScreen_WIDTH, 64);
            self.chooseTime.frame = CGRectMake(0, 0, CYTMainScreen_WIDTH, FitheightRealValue(50));
            self.searchBar.frame = CGRectMake(0, self.chooseTime.bottom, CYTMainScreen_WIDTH, FitheightRealValue(40));
            self.tableView.frame = CGRectMake(0, self.searchBar.bottom, CYTMainScreen_WIDTH, CYTMainScreen_HEIGHT - FitheightRealValue(140) - 49);
        }];
    }else if (velocity.y <= 0) {
        [UIView animateWithDuration:0.25 animations:^{
            self.navBar.frame = CGRectMake(0, 0, CYTMainScreen_WIDTH, 64);
            self.chooseTime.frame = CGRectMake(0, 44, CYTMainScreen_WIDTH, FitheightRealValue(50));
            self.searchBar.frame = CGRectMake(0, self.chooseTime.bottom, CYTMainScreen_WIDTH, FitheightRealValue(40));
            self.tableView.frame = CGRectMake(0, self.searchBar.bottom, CYTMainScreen_WIDTH, CYTMainScreen_HEIGHT - FitheightRealValue(140) - 49 - 64);
        }];
    }
    
}

- (UITableView *)tableView {
    if (!_tableView) {
        _tableView = [[UITableView alloc] initWithFrame:CGRectMake(0, self.searchBar.bottom, CYTMainScreen_WIDTH, CYTMainScreen_HEIGHT - FitheightRealValue(140) - 49 - 64) style:UITableViewStylePlain];
        [_tableView registerClass:[ReconTCell class] forCellReuseIdentifier:@"cell"];
        _tableView.showsVerticalScrollIndicator = NO;
        _tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
        _tableView.delegate = self;
        _tableView.dataSource = self;
    }
    return _tableView;
}

- (UIButton *)submitBtn {
    if (!_submitBtn) {
        _submitBtn = [CYTUtiltyHelper addbuttonWithRect:CGRectMake(FitheightRealValue(20), self.tableView.bottom + FitheightRealValue(5), CYTMainScreen_WIDTH - FitwidthRealValue(40), FitheightRealValue(40)) LabelText:@"提交" TextFont:FitFont(15) NormalTextColor:WHITECOLOR highLightTextColor:WHITECOLOR NormalBgColor:NavigationBarBackgroundColor highLightBgColor:NavigationBarBackgroundColor tag:300 SuperView:self.contentView buttonTarget:self Action:@selector(submitAction)];
        _submitBtn.layer.cornerRadius = FitheightRealValue(20);
        _submitBtn.layer.masksToBounds = YES;
    }
    return _submitBtn;
}

- (CustomCommonEmptyView *)emptyView {
    if (!_emptyView) {
        CustomCommonEmptyView *empty = [[CustomCommonEmptyView alloc] initWithTitle:@"暂无数据" secondTitle:@"请选择其他日期!" iconname:@"emptyPic"];
        [self.tableView addSubview:empty];
        _emptyView = empty;
    }
    return _emptyView;
}

//选中状态数组
- (NSMutableArray *)optionArray {
    if (_optionArray == nil) {
        _optionArray = [[NSMutableArray alloc]init];
    }
    return _optionArray;
}

- (NSMutableArray *)bigArr {
    if (!_bigArr) {
        _bigArr = [[NSMutableArray alloc] init];
    }
    return _bigArr;
}

@end
