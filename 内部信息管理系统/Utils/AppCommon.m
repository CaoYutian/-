//
//  AppCommon.m
//  内部信息管理系统
//
//  Created by Sunshine on 2017/7/10.
//  Copyright © 2017年 Sunshine. All rights reserved.
//

#import "AppCommon.h"

UIWindow *mainWindow() {
    id appDelegate = [UIApplication sharedApplication].delegate;
    if (appDelegate && [appDelegate respondsToSelector:@selector(window)]) {
        return [appDelegate window];
    }
    
    NSArray *windows = [UIApplication sharedApplication].windows;
    if ([windows count] == 1) {
        return [windows firstObject];
    }
    else {
        for (UIWindow *window in windows) {
            if (window.windowLevel == UIWindowLevelNormal) {
                return window;
            }
        }
    }
    return nil;
}

UIViewController *topMostViewController() {
    UIViewController *topViewController = mainWindow().rootViewController;
    UIViewController *temp = nil;
    while (YES) {
        temp = nil;
        if ([topViewController isKindOfClass:[UINavigationController class]]) {
            temp = ((UINavigationController *)topViewController).visibleViewController;
            
        } else if ([topViewController isKindOfClass:[UITabBarController class]]) {
            temp = ((UITabBarController *)topViewController).selectedViewController;
        }
        else if (topViewController.presentedViewController != nil) {
            temp = topViewController.presentedViewController;
        }
        
        if (temp != nil) {
            topViewController = temp;
        } else {
            break;
        }
    }
    return topViewController;
}

@implementation AppCommon

+ (void)pushViewController:(UIViewController*)vc animated:(BOOL)animated {
    [(UINavigationController*)[[[[UIApplication sharedApplication] windows] objectAtIndex:0] rootViewController] pushViewController:vc animated:animated];
}

+ (void)presentViewController:(UIViewController*)vc animated:(BOOL)animated {
    [(UINavigationController*)[[[[UIApplication sharedApplication] windows] objectAtIndex:0] rootViewController]
     presentViewController:vc
     animated:animated
     completion:nil];
}

+ (void)dismissViewControllerAnimated:(BOOL)animated
{
    [(UINavigationController*)[[[[UIApplication sharedApplication] windows] objectAtIndex:0] rootViewController] dismissViewControllerAnimated:YES completion:nil];
}

+ (void)pushWithVCClass:(Class)vcClass properties:(NSDictionary*)properties {
    id obj = [vcClass new];
    if(properties)
        [obj yy_modelSetWithDictionary:properties];
    [self pushViewController:obj animated:YES];
}

+ (void)pushWithVCClassName:(NSString*)className properties:(NSDictionary*)properties {
    [self pushWithVCClass:NSClassFromString(className) properties:properties];
}

+ (void)pushWithVCClass:(Class)vcClass {
    [self pushWithVCClass:vcClass properties:nil];
}

+ (void)pushWithVCClassName:(NSString*)className {
    [self pushWithVCClassName:className needLogin:NO];
}

+ (void)pushWithVCClassName:(NSString*)className needLogin:(BOOL)isNeedLogin {
    if (isNeedLogin && ![UserManager isLogedin]) {
        [self pushWithVCClassName:@"LoginViewController"];
    }
    else {
        [self pushWithVCClass:NSClassFromString(className) properties:nil];
    }
}

+ (void)popViewControllerAnimated:(BOOL)animated {
    [(UINavigationController*)[[[[UIApplication sharedApplication] windows] objectAtIndex:0] rootViewController] popViewControllerAnimated:animated];
}

+ (void)popToRootViewControllerAnimated:(BOOL)animated
{
    [(UINavigationController*)[[[[UIApplication sharedApplication] windows] objectAtIndex:0] rootViewController]  popToRootViewControllerAnimated:animated];
}

@end
