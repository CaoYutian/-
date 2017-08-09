//
//  AppTabBar.h
//  内部信息管理系统
//
//  Created by Sunshine on 2017/7/11.
//  Copyright © 2017年 Sunshine. All rights reserved.
//

#import <UIKit/UIKit.h>

@class AppTabBar;

@protocol AppTabBarDelegate <NSObject>
@optional
- (void)tabBarPlusBtnClick:(AppTabBar *)tabBar;
@end

@interface AppTabBar : UITabBar
/** tabbar的代理 */
@property (nonatomic, weak) id<AppTabBarDelegate> myDelegate ;

@end
