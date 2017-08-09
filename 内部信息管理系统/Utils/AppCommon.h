//
//  AppCommon.h
//  内部信息管理系统
//
//  Created by Sunshine on 2017/7/10.
//  Copyright © 2017年 Sunshine. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>

UIWindow *mainWindow();

UIViewController *topMostViewController();

@interface AppCommon : NSObject

//统一调用此方法来push
+ (void)pushViewController:(UIViewController*)vc animated:(BOOL)animate;
+ (void)presentViewController:(UIViewController*)vc animated:(BOOL)animated;
+ (void)dismissViewControllerAnimated:(BOOL)animated;
+ (void)pushWithVCClass:(Class)vcClass properties:(NSDictionary*)properties;
+ (void)pushWithVCClassName:(NSString*)className properties:(NSDictionary*)properties;
+ (void)pushWithVCClass:(Class)vcClass;
+ (void)pushWithVCClassName:(NSString*)className;
+ (void)pushWithVCClassName:(NSString*)className needLogin:(BOOL)isNeedLogin;
+ (void)popViewControllerAnimated:(BOOL)animated;
+ (void)popToRootViewControllerAnimated:(BOOL)animated;

@end
