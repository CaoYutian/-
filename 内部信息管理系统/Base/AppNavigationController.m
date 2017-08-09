//
//  AppNavigationController.m
//  内部信息管理系统
//
//  Created by Sunshine on 2017/7/10.
//  Copyright © 2017年 Sunshine. All rights reserved.
//

#import "AppNavigationController.h"

@interface AppNavigationController ()<UIGestureRecognizerDelegate>
@property(nonatomic, strong) NSMutableArray *blackList;

@end

@implementation AppNavigationController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.navigationBar.barTintColor = NavigationBarBackgroundColor;
    self.navigationBar.translucent = NO;
    
    // 设置导航默认标题的颜色及字体大小
    self.navigationBar.titleTextAttributes = @{NSForegroundColorAttributeName: [UIColor whiteColor],
                                               NSFontAttributeName : FONT_NORMAL};
    [[UINavigationBar appearance] setTintColor:[UIColor whiteColor]];
    
    //  获取事件处理对象.以便自己添加的手势可以把事件处理委托给它.
    id target = self.interactivePopGestureRecognizer.delegate;
    //  获取委托对象里的处理方法.
    SEL handler = NSSelectorFromString(@"handleNavigationTransition:");
    //  获取添加系统边缘触发手势的View
    UIView *targetView = self.interactivePopGestureRecognizer.view;
    
    //  创建pan手势 作用范围是全屏
    UIPanGestureRecognizer * fullScreenGes = [[UIPanGestureRecognizer alloc]initWithTarget:target action:handler];
    fullScreenGes.delegate = self;
    [targetView addGestureRecognizer:fullScreenGes];
    
    // 关闭边缘触发手势 防止和原有边缘手势冲突
    [self.interactivePopGestureRecognizer setEnabled:NO];
}

#pragma mark - UIGestureRecognizerDelegate
//  防止导航控制器只有一个rootViewcontroller时触发手势
- (BOOL)gestureRecognizerShouldBegin:(UIPanGestureRecognizer *)gestureRecognizer {
    // 根据具体控制器对象决定是否开启全屏右滑返回
    for (UIViewController *viewController in self.blackList) {
        if ([self topViewController] == viewController) {
            return NO;
        }
    }
    
    // 解决右滑和UITableView左滑删除的冲突
    CGPoint translation = [gestureRecognizer translationInView:gestureRecognizer.view];
    if (translation.x <= 0) {
        return NO;
    }
    
    return self.childViewControllers.count == 1 ? NO : YES;
}

#pragma mark - Lazy load
- (NSMutableArray *)blackList {
    if (!_blackList) {
        _blackList = [NSMutableArray array];
    }
    return _blackList;
}

@end
