//
//  AppTabBar.m
//  内部信息管理系统
//
//  Created by Sunshine on 2017/7/11.
//  Copyright © 2017年 Sunshine. All rights reserved.
//

#import "AppTabBar.h"
#define TabBarMagin 12

@interface AppTabBar ()
/** plus按钮 */
@property (nonatomic, weak) UIButton *plusBtn ;
/** 记录上一次被点击按钮的tag */
@property (nonatomic, assign) NSInteger previousClickedTag;
@end

@implementation AppTabBar

- (instancetype)initWithFrame:(CGRect)frame
{
    if (self=[super initWithFrame:frame]) {
        
        self.backgroundColor = [UIColor whiteColor];
        [self setShadowImage:[UIImage createImageWithColor:[UIColor clearColor]]];
        
        UIButton *plusBtn = [[UIButton alloc] init];
        [plusBtn setBackgroundImage:[UIImage imageNamed:@"ic_tabbar_add_bg"] forState:UIControlStateNormal];
        [plusBtn setBackgroundImage:[UIImage imageNamed:@"ic_tabbar_add_bg"] forState:UIControlStateHighlighted];
        
        self.plusBtn = plusBtn;
        
        
        [plusBtn addTarget:self action:@selector(plusBtnDidClick) forControlEvents:UIControlEventTouchUpInside];
        
        [self addSubview:plusBtn];
    }
    return self;
}

- (void)layoutSubviews
{
    [super layoutSubviews];
    //系统自带的按钮类型是UITabBarButton，找出这些类型的按钮，然后重新排布位置，空出中间的位置
    Class class = NSClassFromString(@"UITabBarButton");
    CGFloat width = self.plusBtn.currentBackgroundImage.size.width;
    CGFloat height = self.plusBtn.currentBackgroundImage.size.height;
    self.plusBtn.frame = CGRectMake((self.width-width)/2.0, (self.height-height)/2.0-2*TabBarMagin, width, height);
    UIImageView *plusImageView = [[UIImageView alloc] init];
    [self.plusBtn addSubview:plusImageView];
    plusImageView.image = [UIImage imageNamed:@"ic_tabbar_add"];
    [plusImageView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerX.equalTo(self.plusBtn);
        make.centerY.equalTo(self.plusBtn).offset(3);
    }];
    
    //    UILabel *label = [[UILabel alloc] init];
    //    label.text = @"发布";
    //    label.font = [UIFont fontWithName:@"STHeitiSC-Light" size:10];
    //    [label sizeToFit];
    //    label.textColor = [UIColor grayColor];
    //    [self addSubview:label];
    //    label.centerX = self.plusBtn.centerX;
    //    label.centerY = CGRectGetMaxY(self.plusBtn.frame) + TabBarMagin ;
    
    int btnIndex = 0;
    for (UIView *btn in self.subviews) {//遍历tabbar的子控件
        if ([btn isKindOfClass:class]) {//如果是系统的UITabBarButton，那么就调整子控件位置，空出中间位置
            //每一个按钮的宽度==tabbar的五分之一
            btn.width = self.width / 5;
            
            btn.left = btn.width * btnIndex;
            
            btnIndex++;
            //如果是索引是2(从0开始的)，直接让索引++，目的就是让消息按钮的位置向右移动，空出来发布按钮的位置
            if (btnIndex == 2) {
                btnIndex++;
            }
        }
    }
    
    //遍历子控件
    NSInteger i = 0;
    for (UIButton *tabbarButton in self.subviews) {
        if ([tabbarButton isKindOfClass:NSClassFromString(@"UITabBarButton")]) {
            //绑定tag 标识
            tabbarButton.tag = i;
            i++;
            
            //监听tabbar的点击.
            [tabbarButton addTarget:self action:@selector(tabbarButtonClick:) forControlEvents:UIControlEventTouchUpInside];
        }
    }
    
    [self bringSubviewToFront:self.plusBtn];
}

#pragma mark -- tabbar按钮的点击
- (void)tabbarButtonClick:(UIControl *)tabbarBtn{
    //判断当前按钮是否为上一个按钮
    if (self.previousClickedTag == tabbarBtn.tag) {
        
        [[NSNotificationCenter defaultCenter] postNotificationName:
         @"TabbarButtonClickDidRepeatNotification" object:nil];
    }
    self.previousClickedTag = tabbarBtn.tag;
}

//点击了发布按钮

- (void)plusBtnDidClick {
    //如果tabbar的代理实现了对应的代理方法，那么就调用代理的该方法
    if ([self.delegate respondsToSelector:@selector(tabBarPlusBtnClick:)]) {
        [self.myDelegate tabBarPlusBtnClick:self];
    }
    
}

//重写hitTest方法，去监听发布按钮的点击，目的是为了让凸出的部分点击也有反应
- (UIView *)hitTest:(CGPoint)point withEvent:(UIEvent *)event {
    
    //这一个判断是关键，不判断的话push到其他页面，点击发布按钮的位置也是会有反应的，这样就不好了
    //self.isHidden == NO 说明当前页面是有tabbar的，那么肯定是在导航控制器的根控制器页面
    //在导航控制器根控制器页面，那么我们就需要判断手指点击的位置是否在发布按钮身上
    //是的话让发布按钮自己处理点击事件，不是的话让系统去处理点击事件就可以了
    if (self.isHidden == NO) {
        
        //将当前tabbar的触摸点转换坐标系，转换到发布按钮的身上，生成一个新的点
        CGPoint newP = [self convertPoint:point toView:self.plusBtn];
        
        //判断如果这个新的点是在发布按钮身上，那么处理点击事件最合适的view就是发布按钮
        if ( [self.plusBtn pointInside:newP withEvent:event]) {
            return self.plusBtn;
        }else{//如果点不在发布按钮身上，直接让系统处理就可以了
            
            return [super hitTest:point withEvent:event];
        }
    }
    
    else {//tabbar隐藏了，那么说明已经push到其他的页面了，这个时候还是让系统去判断最合适的view处理就好了
        return [super hitTest:point withEvent:event];
    }
}

@end
