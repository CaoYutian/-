//
//  UIView+TransitionAnimation.m
//
//  Created by HY on 14-10-1.
//  Copyright (c) 2014年 HY. All rights reserved.
//

#import "UIView+TransitionAnimation.h"

@implementation UIView(TransitionAnimation)

- (void)addTransitionAnimationWithDuration:(CGFloat)duration andType:(TransitionType)type andSubTupe:(TransitionSubType)subType{
    
    NSArray * types = @[@"pageCurl",@"pageUnCurl",@"rippleEffect",@"suckEffect",@"cube",@"oglFlip",@"fade",@"moveIn",@"push",@"reveal",@"cameraIrisHollowOpen",@"cameraIrisHollowClose"];
    
    NSArray * subTypes = @[@"fromLeft",@"fromRight",@"fromTop",@"fromBottom"];
    
    //使用动画库<QuartzCore/QuartzCore.h>(在layer层的动画，基本哪里都能用)
    //每次要写比较麻烦，可以通过类别做成类库方便调用
    //跳转动画
    CATransition * transition = [CATransition animation];
    //持续时间
    transition.duration = duration;
    //动画效果
    //字符串
    transition.type = types[type];  //还有一些是字符串的
    //动画方向
    transition.subtype = subTypes[subType];
    //添加到layer上
    [self.layer addAnimation:transition forKey:nil];
    //外部调用需要用window来调用
}

@end
