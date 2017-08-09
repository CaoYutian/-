//
//  UIView+TransitionAnimation.h
//
//  Created by HY on 14-10-1.
//  Copyright (c) 2014年 HY. All rights reserved.
//  动画效果类库

#import <UIKit/UIKit.h>
//专门的动画库
#import <QuartzCore/QuartzCore.h>

typedef enum : NSUInteger {
    TransitionPageCurl,     //向上翻一页
    TransitionPageUnCurl,   //向下翻一页
    TransitionRippleEffect, //滴水效果
    TransitionSuckEffect,   //收缩效果，如一块布被抽走
    TransitionCube,         //立方体效果
    TransitionOglFlip,      //上下翻转效果
    TransitionFade,         //交叉淡化过渡
    TransitionMoveIn,       //新视图移到旧视图上面
    TransitionPush,         //新视图把旧视图推出去
    TransitionReveal,       //将旧视图移开,显示下面的新视图
    TransitionCameraIrisHollowOpen,  //相机开
    TransitionCameraIrisHollowClose  //相机关
} TransitionType;

typedef enum : NSUInteger {
    From_LEFT,
    From_RIGHT,
    From_TOP,
    From_BOTTOM
} TransitionSubType;

@interface UIView(TransitionAnimation)

- (void)addTransitionAnimationWithDuration:(CGFloat)duration andType:(TransitionType)type andSubTupe:(TransitionSubType)subType;

@end
