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
#import "HttpTools.h"
#import "titleView.h"

@interface DosageAnalysisVC ()<UISearchBarDelegate,UITableViewDelegate,UITableViewDataSource,MAMapViewDelegate, AMapSearchDelegate>

@property (nonatomic, strong) DosageARequest *dosageARequest;

@property (nonatomic, strong) UITableView *tableView;
@property (nonatomic, strong) NSMutableArray *dataArray;
@property (nonatomic, strong) NSMutableArray *dataArray2;
@property (nonatomic, strong) NSMutableArray *coordinateArr;

@property (nonatomic, strong) MBProgressHUD *HD;
@property (nonatomic, strong) titleView *titleV;
@property (nonatomic, strong) ActionAlertView *alertView;
@property (nonatomic, strong) dischargPlanModel *dataModel;

@end

@implementation DosageAnalysisVC

- (void)viewDidLoad {
    [super viewDidLoad];
    self.titleLabel.text = @"用量分析";

    self.automaticallyAdjustsScrollViewInsets = NO;
}

- (void)loadSubViews {
    [super loadSubViews];
    [self.contentView mas_updateConstraints:^(MASConstraintMaker *make) {
        make.edges.equalTo(self.view).insets(UIEdgeInsetsMake(0, 0, 49, 0));
    }];
    
    [self.contentView addSubview:self.tableView];
    self.tableView.tableFooterView = self.mapView;
}

- (void)loadData {
    [self.contentView addSubview:self.HD];
    [self.HD showAnimated:YES];
    NSMutableDictionary *dict = [NSMutableDictionary dictionary];
    if (self.alertView.InputBox.text.length) {
        [dict setObject:self.alertView.InputBox.text forKey:@"name"];
    }else {
        [dict setObject:@"" forKey:@"name"];
    }
    HttpTools *httpTool = [[HttpTools alloc] init];
    NSDictionary *newDict = [httpTool signatureParams:dict];
    [HttpTools POST:Fenxie_index parameters:newDict success:^(NSURLSessionDataTask *task, id responseObject) {
        if (responseObject[@"data"]) {
            for (NSDictionary *needDic in responseObject[@"data"][@"need"]) {
                DosageAModel *needModel = [[DosageAModel alloc] init];
                needModel.qz_id = needDic[@"qz_id"];
                needModel.short_name = needDic[@"short_name"];
                needModel.agv_vl = needDic[@"agv_vl"];
                needModel.t_yw = needDic[@"t_yw"];
                [self.dataArray addObject:needModel];
            }
            
            for (NSArray *dataArr in responseObject[@"data"][@"data"]) {
                if (dataArr.count >1) {
                    [self.coordinateArr addObject:dataArr];
                }
                self.dataModel = [[dischargPlanModel alloc] init];
                self.dataModel.dischargDataArr = dataArr;
                [self.dataArray2 addObject:self.dataModel];
            }

        }

        [self RoutePlanning:0];
        [self.tableView reloadData];
        [self.HD hideAnimated:YES];
    } failure:^(NSURLSessionDataTask *task, NSError *error) {
        [self.HD hideAnimated:YES];
    }];
}

- (void)RoutePlanning:(NSInteger)Index {
    
    self.search = [[AMapSearchAPI alloc] init];
    self.search.delegate = self;
    
    if ([self.coordinateArr[Index] count] == 2) {
        NSString *startPointLat = self.coordinateArr[Index][0][@"lat"];
        NSString *startPointLon = self.coordinateArr[Index][0][@"lon"];
        NSString *endPointLat = self.coordinateArr[Index][1][@"lat"];
        NSString *endPointLon = self.coordinateArr[Index][1][@"lon"];
        
        self.startPoint = CLLocationCoordinate2DMake([startPointLat doubleValue], [startPointLon doubleValue]);
        self.endPoint = CLLocationCoordinate2DMake([endPointLat doubleValue], [endPointLon doubleValue]);
    }
    if ([self.coordinateArr[Index] count] == 3) {
        NSString *startPointLat = self.coordinateArr[Index][0][@"lat"];
        NSString *startPointLon = self.coordinateArr[Index][0][@"lon"];
        NSString *wayPointLat = self.coordinateArr[Index][1][@"lat"];
        NSString *wayPointLon = self.coordinateArr[Index][1][@"lon"];
        NSString *endPointLat = self.coordinateArr[Index][2][@"lat"];
        NSString *endPointLon = self.coordinateArr[Index][2][@"lon"];
        
        self.startPoint = CLLocationCoordinate2DMake([startPointLat doubleValue], [startPointLon doubleValue]);
        self.wayPoint = CLLocationCoordinate2DMake([wayPointLat doubleValue], [wayPointLon doubleValue]);
        self.endPoint = CLLocationCoordinate2DMake([endPointLat doubleValue], [endPointLon doubleValue]);
    }
    [self addDefaultAnnotationsStartPoints:self.startPoint endPoints:self.endPoint wayPoints:self.wayPoint];
    [self searchRoutePlanningBusCrossCity:self.startPoint endPoints:self.endPoint wayPoints:self.wayPoint];
}

- (void)addDefaultAnnotationsStartPoints:(CLLocationCoordinate2D)startPoints endPoints:(CLLocationCoordinate2D)endPoints wayPoints:(CLLocationCoordinate2D)wayPoints{
    
    MAPointAnnotation *startAnnotation = [[MAPointAnnotation alloc] init];
    startAnnotation.coordinate = startPoints;
    startAnnotation.title      = (NSString*)RoutePlanningViewControllerStartTitle;
    startAnnotation.subtitle   = [NSString stringWithFormat:@"{%f, %f}", startPoints.latitude, startPoints.longitude];
    self.startAnnotation = startAnnotation;
    
    MAPointAnnotation *destinationAnnotation = [[MAPointAnnotation alloc] init];
    destinationAnnotation.coordinate = endPoints;
    destinationAnnotation.title      = (NSString*)RoutePlanningViewControllerDestinationTitle;
    destinationAnnotation.subtitle   = [NSString stringWithFormat:@"{%f, %f}", endPoints.latitude, endPoints.longitude];
    self.destinationAnnotation = destinationAnnotation;
    
    if (wayPoints.longitude > 0) {
        MAPointAnnotation *wayAnnotation = [[MAPointAnnotation alloc] init];
        wayAnnotation.coordinate = wayPoints;
        wayAnnotation.title      = (NSString*)RoutePlanningViewControllerDestinationTitle;
        wayAnnotation.subtitle   = [NSString stringWithFormat:@"{%f, %f}", wayPoints.latitude, wayPoints.longitude];
        [self.mapView addAnnotation:wayAnnotation];
    }
    
    [self.mapView addAnnotation:startAnnotation];
    [self.mapView addAnnotation:destinationAnnotation];
    
}

#pragma mark - do search
- (void)searchRoutePlanningBusCrossCity:(CLLocationCoordinate2D)startPoints endPoints:(CLLocationCoordinate2D)endPoints wayPoints:(CLLocationCoordinate2D)wayPoints {
    
    AMapDrivingRouteSearchRequest *navi = [[AMapDrivingRouteSearchRequest alloc] init];
    /* 出发点. */
    navi.origin = [AMapGeoPoint locationWithLatitude:startPoints.latitude
                                           longitude:startPoints.longitude];
    /* 目的地. */
    navi.destination = [AMapGeoPoint locationWithLatitude:endPoints.latitude
                                                longitude:endPoints.longitude];
    if (wayPoints.longitude > 0) {
        AMapGeoPoint *wayGeoPoint = [AMapGeoPoint locationWithLatitude:wayPoints.latitude longitude:wayPoints.longitude];
        navi.waypoints = @[wayGeoPoint];
    }
    
    [self.search AMapDrivingRouteSearch:navi];
}

- (void)updateTotal {
    self.totalCourse = self.route.transits.count;
}

- (BOOL)increaseCurrentCourse {
    BOOL result = NO;
    
    if (self.currentCourse < self.totalCourse - 1)
    {
        self.currentCourse++;
        
        result = YES;
    }
    
    return result;
}

- (BOOL)decreaseCurrentCourse {
    BOOL result = NO;
    
    if (self.currentCourse > 0) {
        self.currentCourse--;
        
        result = YES;
    }
    
    return result;
}

/* 展示当前路线方案. */
- (void)presentCurrentCourse:(AMapGeoPoint *)startPoint endPoint:(AMapGeoPoint *)endPoint {
    
    MANaviRoute *naviRoute = [MANaviRoute naviRouteForPath:self.route.paths[self.currentCourse] withNaviType:MANaviAnnotationTypeDrive showTraffic:YES startPoint:startPoint endPoint:endPoint];
    self.naviRoute = naviRoute;
    [naviRoute addToMapView:self.mapView];
    
    /* 缩放地图使其适应polylines的展示. */
    [self.mapView setVisibleMapRect:[CommonUtility mapRectForOverlays:naviRoute.routePolylines]
                        edgePadding:UIEdgeInsetsMake(RoutePlanningPaddingEdge, RoutePlanningPaddingEdge, RoutePlanningPaddingEdge, RoutePlanningPaddingEdge)
                           animated:YES];
    self.planIndex ++;
    if (self.planIndex < self.coordinateArr.count) {
        [self RoutePlanning:self.planIndex];
    }
}

/* 清空地图上已有的路线. */
- (void)clear {
    [self.naviRoute removeFromMapView];
}

#pragma mark - MAMapViewDelegate
- (MAOverlayRenderer *)mapView:(MAMapView *)mapView rendererForOverlay:(id<MAOverlay>)overlay {
    if ([overlay isKindOfClass:[LineDashPolyline class]]) {
        MAPolylineRenderer *polylineRenderer = [[MAPolylineRenderer alloc] initWithPolyline:((LineDashPolyline *)overlay).polyline];
        polylineRenderer.lineWidth   = 8;
        polylineRenderer.lineDash = YES;
        polylineRenderer.strokeColor = [UIColor redColor];
        
        return polylineRenderer;
    }
    if ([overlay isKindOfClass:[MANaviPolyline class]]) {
        MANaviPolyline *naviPolyline = (MANaviPolyline *)overlay;
        MAPolylineRenderer *polylineRenderer = [[MAPolylineRenderer alloc] initWithPolyline:naviPolyline.polyline];
        polylineRenderer.lineWidth = 8;
        
        if (naviPolyline.type == MANaviAnnotationTypeWalking){
            polylineRenderer.strokeColor = self.naviRoute.walkingColor;
        }
        else if (naviPolyline.type == MANaviAnnotationTypeRailway){
            polylineRenderer.strokeColor = self.naviRoute.railwayColor;
        }
        else{
            polylineRenderer.strokeColor = self.naviRoute.routeColor;
        }
        
        return polylineRenderer;
    }
    if ([overlay isKindOfClass:[MAMultiPolyline class]]) {
        MAMultiColoredPolylineRenderer * polylineRenderer = [[MAMultiColoredPolylineRenderer alloc] initWithMultiPolyline:(MAMultiPolyline *)overlay];
        
        polylineRenderer.lineWidth = 10;
        polylineRenderer.strokeColors = [self.naviRoute.multiPolylineColors copy];
        polylineRenderer.gradient = YES;
        
        return polylineRenderer;
    }
    
    return nil;
}

- (MAAnnotationView *)mapView:(MAMapView *)mapView viewForAnnotation:(id<MAAnnotation>)annotation
{
    if ([annotation isKindOfClass:[MAPointAnnotation class]]){
        static NSString *routePlanningCellIdentifier = @"RoutePlanningCellIdentifier";
        
        MAAnnotationView *poiAnnotationView = (MAAnnotationView*)[self.mapView dequeueReusableAnnotationViewWithIdentifier:routePlanningCellIdentifier];
        if (poiAnnotationView == nil){
            poiAnnotationView = [[MAAnnotationView alloc] initWithAnnotation:annotation
                                                             reuseIdentifier:routePlanningCellIdentifier];
        }
        
        poiAnnotationView.canShowCallout = YES;
        poiAnnotationView.image = nil;
        
        if ([annotation isKindOfClass:[MANaviAnnotation class]]) {
            switch (((MANaviAnnotation*)annotation).type)
            {
                case MANaviAnnotationTypeRailway:
                    poiAnnotationView.image = [UIImage imageNamed:@"railway_station"];
                    break;
                    
                case MANaviAnnotationTypeBus:
                    poiAnnotationView.image = [UIImage imageNamed:@"bus"];
                    break;
                    
                case MANaviAnnotationTypeDrive:
                    poiAnnotationView.image = [UIImage imageNamed:@"car"];
                    break;
                    
                case MANaviAnnotationTypeWalking:
                    poiAnnotationView.image = [UIImage imageNamed:@"man"];
                    break;
                    
                default:
                    break;
            }
        }else{
            /* 起点. */
            if ([[annotation title] isEqualToString:(NSString*)RoutePlanningViewControllerStartTitle]){
                poiAnnotationView.image = [UIImage imageNamed:@"startPoint"];
            }
            /* 终点. */
            else if([[annotation title] isEqualToString:(NSString*)RoutePlanningViewControllerDestinationTitle]) {
                poiAnnotationView.image = [UIImage imageNamed:@"endPoint"];
            }
        }
        return poiAnnotationView;
    }
    return nil;
}

#pragma mark - AMapSearchDelegate
- (void)AMapSearchRequest:(id)request didFailWithError:(NSError *)error {
    NSLog(@"Error: %@", error);
}

/* 路径规划搜索回调. */
- (void)onRouteSearchDone:(AMapRouteSearchBaseRequest *)request response:(AMapRouteSearchResponse *)response {
    if (response.route == nil){
        return;
    }
    
    self.route = response.route;
    [self updateTotal];
    self.currentCourse = 0;
    if (response.count > 0){
        [self presentCurrentCourse:request.origin endPoint:request.destination];
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
    UIView *headerView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, CYTMainScreen_WIDTH, FitheightRealValue(80))];
    NSArray *titles = @[@"推荐分卸点:",@"分卸方案:"];
    NSArray *subTitles = @[@[@"用户名",@"日均用量",@"剩余吨位",@"百分比"],@[@"槽车",@"液源",@"卸液点1",@"卸液点2",@"卸液点3"]];
    UILabel *titleLb = [CYTUtiltyHelper addLabelWithFrame:CGRectMake(FitwidthRealValue(13), 0, CYTMainScreen_WIDTH - FitwidthRealValue(26), FitheightRealValue(40)) LabelFont:FitFont(16) LabelTextColor:BLACKCOLOR LabelTextAlignment:NSTextAlignmentLeft SuperView:headerView LabelTag:400 + section LabelText:titles[section]];
    self.titleV = [[titleView alloc] initWithFrame:CGRectMake(0, titleLb.bottom, CYTMainScreen_WIDTH, FitheightRealValue(40)) titles:subTitles[section]];
    [headerView addSubview:self.titleV];
    headerView.backgroundColor = WHITECOLOR;
    UIView *line = [[UIView alloc] initWithFrame:CGRectMake(0, FitheightRealValue(79), CYTMainScreen_WIDTH, FitheightRealValue(1))];
    line.backgroundColor = [UIColor lightGrayColor];
    [headerView addSubview:line];
    return headerView;
}

- (UIView *)tableView:(UITableView *)tableView viewForFooterInSection:(NSInteger)section {
    if (section == 0) {
        UIView *footView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, CYTMainScreen_WIDTH, FitheightRealValue(50))];
        
        UIButton *unloadPoint = [CYTUtiltyHelper addbuttonWithRect:CGRectMake(FitheightRealValue(20), FitheightRealValue(5), CYTMainScreen_WIDTH - FitwidthRealValue(40), FitheightRealValue(40)) LabelText:@"添加分卸点" TextFont:FitFont(15) NormalTextColor:WHITECOLOR highLightTextColor:WHITECOLOR NormalBgColor:NavigationBarBackgroundColor highLightBgColor:NavigationBarBackgroundColor tag:402 SuperView:footView buttonTarget:self Action:@selector(addUnloadAddress)];
        unloadPoint.layer.cornerRadius = FitheightRealValue(20);
        unloadPoint.layer.masksToBounds = YES;
        
        UIView *line = [[UIView alloc] initWithFrame:CGRectMake(0, FitheightRealValue(49), CYTMainScreen_WIDTH, FitheightRealValue(1))];
        line.backgroundColor = MainBackgroundColor;
        footView.backgroundColor = MainBackgroundColor;
        [footView addSubview:line];
        return footView;
    }else {
        return NULL;
    }

}

- (CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section {
    CGFloat height = section == 0 ? FitheightRealValue(50) : 0;
    return height;
}

- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section {
    return FitheightRealValue(80);
}

#pragma mark addUnloadAddress
- (void)addUnloadAddress {
    WS(weakSelf);
    weakSelf.alertView = [[ActionAlertView alloc] initWithTitle:@"添加分卸点" message:nil placeholder:@"请输入需要添加的分卸点" sureBtn:@"确定" cancleBtn:@"取消"];
    weakSelf.alertView.resultIndex = ^(NSInteger index){
        if (index == 2) {
            [weakSelf performBlock:^{
                [weakSelf.dataArray removeAllObjects];
                [weakSelf.dataArray2 removeAllObjects];
                [self loadData];
            } afterDelay:1.0];
        }
    };
    [weakSelf.alertView showAlertView];
    
}

- (UITableView *)tableView {
    if (!_tableView) {
        _tableView = [[UITableView alloc] initWithFrame:CGRectMake(0, 49, CYTMainScreen_WIDTH, CYTMainScreen_HEIGHT - 49 - 64) style:UITableViewStylePlain];
        [_tableView registerClass:[DosageACell class] forCellReuseIdentifier:@"cell"];
        [_tableView registerClass:[dischargPlanCell class] forCellReuseIdentifier:@"dischargPlanCell"];
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

- (NSMutableArray *)dataArray2 {
    if (!_dataArray2) {
        _dataArray2 = [[NSMutableArray alloc] init];
    }
    return _dataArray2;
}

- (NSMutableArray *)coordinateArr {
    if (!_coordinateArr) {
        _coordinateArr = [[NSMutableArray alloc] init];
    }
    return _coordinateArr;
}

-(MBProgressHUD *)HD{
    if (!_HD) {
        _HD = [[MBProgressHUD alloc]initWithView:self.contentView];
    }
    return _HD;
}

- (MAMapView *)mapView {
    if (!_mapView) {
        _mapView = [[MAMapView alloc] init];
        _mapView.size = CGSizeMake(CYTMainScreen_WIDTH, CYTMainScreen_WIDTH);
        _mapView.delegate = self;
    }
    return _mapView;
}

@end
