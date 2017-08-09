//
//  AppTabBarController.m
//  内部信息管理系统
//
//  Created by Sunshine on 2017/7/10.
//  Copyright © 2017年 Sunshine. All rights reserved.
//

#import "AppTabBarController.h"
#import "AppTabBar.h"

#import "HyPopMenuView.h"
#import "TankMonitoringVC.h"
#import "ReconciliationVC.h"
#import "AmountContrastVC.h"
#import "DosageAnalysisVC.h"
#import "PersonalCenterVC.h"

@interface AppTabBarController ()<AppTabBarDelegate,HyPopMenuViewDelegate>
@property(nonatomic,strong)HyPopMenuView *menu;

@end

@implementation AppTabBarController

- (instancetype)init
{
    self = [super init];
    if (self) {
        [self createTabBar];
    }
    return self;
}

- (void)createTabBar {
    
    //首页
    TankMonitoringVC *TankMonitoring = [[TankMonitoringVC alloc] init];
    TankMonitoring.tabBarItem.title = @"储罐监控";
    TankMonitoring.tabBarItem.image = [UIImage imageNamed:@"ic_tabbar_tankm"];
    TankMonitoring.tabBarItem.selectedImage = [[UIImage imageNamed:@"ic_tabbar_tankm2"] imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal];
    
    ReconciliationVC *Reconciliation = [[ReconciliationVC alloc] init];
    Reconciliation.tabBarItem.title = @"采购对账";
    Reconciliation.tabBarItem.image = [UIImage imageNamed:@"ic_tabbar_reconciliation"];
    Reconciliation.tabBarItem.selectedImage = [[UIImage imageNamed:@"ic_tabbar_reconciliation2"] imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal];
    
    AmountContrastVC *AmountContrast = [[AmountContrastVC alloc] init];
    AmountContrast.tabBarItem.title = @"用量对比";
    AmountContrast.tabBarItem.image = [UIImage imageNamed:@"ic_tabbar_analysis"];
    AmountContrast.tabBarItem.selectedImage = [[UIImage imageNamed:@"ic_tabbar_analysis2"] imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal];
    
    DosageAnalysisVC *DosageAnalysis = [[DosageAnalysisVC alloc] init];
    DosageAnalysis.tabBarItem.title = @"用量分析";
    DosageAnalysis.tabBarItem.image = [UIImage imageNamed:@"ic_tabbar_analysis"];
    DosageAnalysis.tabBarItem.selectedImage = [[UIImage imageNamed:@"ic_tabbar_analysis2"] imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal];
    
    PersonalCenterVC *PersonalCenter = [[PersonalCenterVC alloc] init];
    PersonalCenter.tabBarItem.title = @"个人中心";
    PersonalCenter.tabBarItem.image = [UIImage imageNamed:@"ic_tabbar_personal"];
    PersonalCenter.tabBarItem.selectedImage = [[UIImage imageNamed:@"ic_tabbar_personal2"] imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal];
    
    //创建自己的tabbar，然后用kvc将自己的tabbar和系统的tabBar替换下
//    AppTabBar *tabbar = [[AppTabBar alloc] init];
//    tabbar.myDelegate = self;
//    //kvc实质是修改了系统的_tabBar
//    [self setValue:tabbar forKeyPath:@"tabBar"];
    
    self.tabBar.tintColor = NavigationBarBackgroundColor;
    self.viewControllers = @[TankMonitoring,Reconciliation,AmountContrast,DosageAnalysis,PersonalCenter];
    
//    //中间+号弹出视图
//    _menu = [HyPopMenuView sharedPopMenuManager];
//
//    PopMenuModel *model1 = [PopMenuModel
//                            allocPopMenuModelWithImageNameString:@"tabbar_compose_camera"
//                            AtTitleString:@"采购对账"
//                            AtTextColor:[UIColor grayColor]
//                            AtTransitionType:PopMenuTransitionTypeCustomizeApi
//                            AtTransitionRenderingColor:nil];
//
//    PopMenuModel *model2 = [PopMenuModel
//                            allocPopMenuModelWithImageNameString:@"tabbar_compose_review"
//                            AtTitleString:@"用量对比"
//                            AtTextColor:[UIColor grayColor]
//                            AtTransitionType:PopMenuTransitionTypeCustomizeApi
//                            AtTransitionRenderingColor:nil];
//
//    PopMenuModel *model3 = [PopMenuModel
//                            allocPopMenuModelWithImageNameString:@"tabbar_compose_idea"
//                            AtTitleString:@"用量分析"
//                            AtTextColor:[UIColor grayColor]
//                            AtTransitionType:PopMenuTransitionTypeCustomizeApi
//                            AtTransitionRenderingColor:nil];
//
//    _menu.dataSource = @[model1, model2, model3];
//    _menu.delegate = self;
//    _menu.popMenuSpeed = 12.0f;
//    _menu.automaticIdentificationColor = false;
//    _menu.animationType = HyPopMenuViewAnimationTypeViscous;
}

- (void)tabBar:(UITabBar *)tabBar didSelectItem:(UITabBarItem *)item {
    NSInteger index = [self.tabBar.items indexOfObject:item];
    [self animationWithIndex:index];
    if([item.title isEqualToString:@""]) {
        
    }
}

- (void)animationWithIndex:(NSInteger)index {
    NSMutableArray *tabbarbuttonArray = [NSMutableArray array];
    for (UIView *tabBarButton in self.tabBar.subviews) {
        if ([tabBarButton isKindOfClass:NSClassFromString(@"UITabBarButton")]) {
            [tabbarbuttonArray addObject:tabBarButton];
        }
    }
    CABasicAnimation *pulse = [CABasicAnimation animationWithKeyPath:@"transform.scale"];
    pulse.timingFunction = [CAMediaTimingFunction functionWithName:kCAMediaTimingFunctionEaseInEaseOut];
    pulse.duration = 0.2;
    pulse.repeatCount = 1;
    pulse.autoreverses= YES;
    pulse.fromValue = [NSNumber numberWithFloat:0.7];
    pulse.toValue = [NSNumber numberWithFloat:1.0];
    [[tabbarbuttonArray[index] layer]
     addAnimation:pulse forKey:nil];
}

//点击中间按钮的代理方法
#pragma mark - BITabBarDelegate
- (void)tabBarPlusBtnClick:(AppTabBar *)tabBar {
    _menu.backgroundType = HyPopMenuViewBackgroundTypeLightBlur;
    [_menu openMenu];
}

- (void)popMenuView:(HyPopMenuView*)popMenuView didSelectItemAtIndex:(NSUInteger)index {
    if (index == 0) {
//        [AppCommon pushWithVCClassName:@"SelectActivityTypeViewController"];
        
    }else if (index == 1) {
//        PublishViewController *publishVC = [[PublishViewController alloc] init];
//        publishVC.publishType = SelectPublishTypeCircle;
//        [AppCommon pushViewController:publishVC animated:YES];
        
    }else {
//        PublishViewController *publishVC = [[PublishViewController alloc] init];
//        publishVC.publishType = SelectPublishTypeQuiz;
//        [AppCommon pushViewController:publishVC animated:YES];
    }
}

@end
