//
//  LoginTranslation.h
//  内部信息管理系统
//
//  Created by Sunshine on 2017/8/4.
//  Copyright © 2017年 Sunshine. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface LoginTranslation : NSObject<UIViewControllerAnimatedTransitioning>

@property (assign, nonatomic) BOOL reverse;

- (instancetype)initWithView:(UIView*)btnView;
- (void)stopAnimation;

@end
