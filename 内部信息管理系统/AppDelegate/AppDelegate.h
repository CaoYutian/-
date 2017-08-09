//
//  AppDelegate.h
//  内部信息管理系统
//
//  Created by Sunshine on 2017/7/10.
//  Copyright © 2017年 Sunshine. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "AppTabBarController.h"
#import "AppNavigationController.h"

@interface AppDelegate : UIResponder <UIApplicationDelegate>

@property (strong, nonatomic) UIWindow *window;
@property (strong, nonatomic) AppNavigationController *nav;
@property (strong, nonatomic) AppTabBarController *tabBarController;

-(void)loadLoginVC;
-(void)loadMainVC;
-(void)loadOperaVC;

@end

