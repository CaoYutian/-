//
//  PersonalCenterVC.m
//  内部信息管理系统
//
//  Created by Sunshine on 2017/7/12.
//  Copyright © 2017年 Sunshine. All rights reserved.
//

#import "PersonalCenterVC.h"

#import <MAMapKit/MAMapKit.h>
#import <AMapFoundationKit/AMapFoundationKit.h>
#import <AMapSearchKit/AMapSearchKit.h>
#import "CommonUtility.h"
#import "MANaviRoute.h"

static const NSString *RoutePlanningViewControllerStartTitle       = @"起点";
static const NSString *RoutePlanningViewControllerDestinationTitle = @"终点";
static const NSInteger RoutePlanningPaddingEdge                    = 20;

@interface PersonalCenterVC ()<MAMapViewDelegate, AMapSearchDelegate>
/* 路径规划类型 */
@property (nonatomic, strong) MAMapView *mapView;
@property (nonatomic, strong) AMapSearchAPI *search;

@property (nonatomic, strong) AMapRoute *route;

/* 当前路线方案索引值. */
@property (nonatomic) NSInteger currentCourse;
/* 路线方案个数. */
@property (nonatomic) NSInteger totalCourse;

/* 起始点经纬度. */
@property (nonatomic, assign) CLLocationCoordinate2D startPoint;
/* 终点经纬度. */
@property (nonatomic, assign) CLLocationCoordinate2D endPoint;

/* 用于显示当前路线方案. */
@property (nonatomic) MANaviRoute * naviRoute;
@property (nonatomic, strong) MAPointAnnotation *startAnnotation;
@property (nonatomic, strong) MAPointAnnotation *destinationAnnotation;
@property (nonatomic, assign) NSInteger planIndex;


@end

@implementation PersonalCenterVC

- (void)viewDidLoad {
    [super viewDidLoad];
    self.titleLabel.text = @"个人中心";
//    UIButton *exitBtn = [CYTUtiltyHelper addbuttonWithRect:CGRectMake(FitheightRealValue(20), FitheightRealValue(80), CYTMainScreen_WIDTH - FitwidthRealValue(40), FitheightRealValue(40)) LabelText:@"切换账号" TextFont:FitFont(15) NormalTextColor:WHITECOLOR highLightTextColor:WHITECOLOR NormalBgColor:NavigationBarBackgroundColor highLightBgColor:NavigationBarBackgroundColor tag:300 SuperView:self.contentView buttonTarget:self Action:@selector(exitAction)];
//    exitBtn.layer.cornerRadius = FitheightRealValue(20);
//    exitBtn.layer.masksToBounds = YES;
    
    self.planIndex = 0;
    
    self.mapView = [[MAMapView alloc] initWithFrame:self.view.bounds];
    self.mapView.autoresizingMask = UIViewAutoresizingFlexibleWidth | UIViewAutoresizingFlexibleHeight;
    self.mapView.delegate = self;
    
    [self.view addSubview:self.mapView];
    
    [self RoutePlanning:self.planIndex];
}

- (void)RoutePlanning:(NSInteger)Index {

    if (Index == 0) {
        self.startPoint = CLLocationCoordinate2DMake(40.818311, 111.670801);
        self.endPoint = CLLocationCoordinate2DMake(44.433942, 125.184449);
        
        self.search = [[AMapSearchAPI alloc] init];
        self.search.delegate = self;
        
        [self addDefaultAnnotationsStartPoints:self.startPoint endPoints:self.endPoint];
        [self searchRoutePlanningBusCrossCity:self.startPoint endPoints:self.endPoint];
    }
    if (Index == 1){
        self.startPoint = CLLocationCoordinate2DMake(37.584119, 110.076304);
        self.endPoint = CLLocationCoordinate2DMake(39.013628, 116.573331);
        
        self.search = [[AMapSearchAPI alloc] init];
        self.search.delegate = self;
        
        [self addDefaultAnnotationsStartPoints:self.startPoint endPoints:self.endPoint];
        [self searchRoutePlanningBusCrossCity:self.startPoint endPoints:self.endPoint];
    }
    
    if (Index == 2){
        self.startPoint = CLLocationCoordinate2DMake(35.584119, 111.076304);
        self.endPoint = CLLocationCoordinate2DMake(38.013628, 117.573331);
        
        self.search = [[AMapSearchAPI alloc] init];
        self.search.delegate = self;
        
        [self addDefaultAnnotationsStartPoints:self.startPoint endPoints:self.endPoint];
        [self searchRoutePlanningBusCrossCity:self.startPoint endPoints:self.endPoint];
    }
    
    if (Index == 3){
        self.startPoint = CLLocationCoordinate2DMake(38.584119, 110.076304);
        self.endPoint = CLLocationCoordinate2DMake(36.013628, 118.573331);
        
        self.search = [[AMapSearchAPI alloc] init];
        self.search.delegate = self;
        
        [self addDefaultAnnotationsStartPoints:self.startPoint endPoints:self.endPoint];
        [self searchRoutePlanningBusCrossCity:self.startPoint endPoints:self.endPoint];
    }
    
    if (Index == 4){
        self.startPoint = CLLocationCoordinate2DMake(39.130265, 116.83165);
        self.endPoint = CLLocationCoordinate2DMake(38.130265, 115.83165);
        
        self.search = [[AMapSearchAPI alloc] init];
        self.search.delegate = self;
        
        [self addDefaultAnnotationsStartPoints:self.startPoint endPoints:self.endPoint];
        [self searchRoutePlanningBusCrossCity:self.startPoint endPoints:self.endPoint];
    }
    
}

- (void)addDefaultAnnotationsStartPoints:(CLLocationCoordinate2D)startPoints endPoints:(CLLocationCoordinate2D)endPoints {
    
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
    
    [self.mapView addAnnotation:startAnnotation];
    [self.mapView addAnnotation:destinationAnnotation];

}

#pragma mark - do search
- (void)searchRoutePlanningBusCrossCity:(CLLocationCoordinate2D)startPoints endPoints:(CLLocationCoordinate2D)endPoints {
    AMapTransitRouteSearchRequest *navi = [[AMapTransitRouteSearchRequest alloc] init];
    
    navi.requireExtension = YES;
    navi.city             = @"呼和浩特";
    navi.destinationCity  = @"农安县";
    
    /* 出发点. */
    navi.origin = [AMapGeoPoint locationWithLatitude:startPoints.latitude
                                           longitude:startPoints.longitude];
    /* 目的地. */
    navi.destination = [AMapGeoPoint locationWithLatitude:endPoints.latitude
                                                longitude:endPoints.longitude];
    
    [self.search AMapTransitRouteSearch:navi];
}

- (void)updateTotal {
    self.totalCourse = self.route.transits.count;
}

- (BOOL)increaseCurrentCourse {
    BOOL result = NO;
    
    if (self.currentCourse < self.totalCourse - 1){
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
    
    MANaviRoute *naviRoute = [MANaviRoute naviRouteForTransit:self.route.transits[self.currentCourse] startPoint:startPoint endPoint:endPoint];
    self.naviRoute = naviRoute;
//    self.naviRoute = [MANaviRoute naviRouteForTransit:self.route.transits[self.currentCourse] startPoint:startPoint endPoint:endPoint];
    [naviRoute addToMapView:self.mapView];
    
    /* 缩放地图使其适应polylines的展示. */
    [self.mapView setVisibleMapRect:[CommonUtility mapRectForOverlays:naviRoute.routePolylines]
                        edgePadding:UIEdgeInsetsMake(RoutePlanningPaddingEdge, RoutePlanningPaddingEdge, RoutePlanningPaddingEdge, RoutePlanningPaddingEdge)
                           animated:YES];
    
    self.planIndex ++;
    [self RoutePlanning:self.planIndex];
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

- (MAAnnotationView *)mapView:(MAMapView *)mapView viewForAnnotation:(id<MAAnnotation>)annotation {
    if ([annotation isKindOfClass:[MAPointAnnotation class]]) {
        static NSString *routePlanningCellIdentifier = @"RoutePlanningCellIdentifier";
        
        MAAnnotationView *poiAnnotationView = (MAAnnotationView*)[self.mapView dequeueReusableAnnotationViewWithIdentifier:routePlanningCellIdentifier];
        if (poiAnnotationView == nil) {
            poiAnnotationView = [[MAAnnotationView alloc] initWithAnnotation:annotation
                                                             reuseIdentifier:routePlanningCellIdentifier];
        }
        
        poiAnnotationView.canShowCallout = YES;
        poiAnnotationView.image = nil;
        
        if ([annotation isKindOfClass:[MANaviAnnotation class]]) {
            switch (((MANaviAnnotation*)annotation).type) {
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
        }
        else{
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


- (void)exitAction {
    [UserManager removeLocalUserLoginInfo];
    [kAppDelegate loadLoginVC];
}

@end
