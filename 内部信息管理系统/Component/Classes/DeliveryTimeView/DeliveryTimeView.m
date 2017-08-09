//
//  DeliveryTimeView.m
//  YQW
//
//  Created by Sunshine on 2017/6/14.
//  Copyright © 2017年 Sunshine. All rights reserved.
//

#import "DeliveryTimeView.h"
#import "ZYCalendarView.h"
#import "UIView+frame.h"
@implementation DeliveryTimeView{
    void(^_block) (NSString *startTime, NSString *endTime);
}

- (void)showInView:(UIView *)view {
    if (view == nil) {
        view = [UIApplication sharedApplication].keyWindow;
    } else {
        view = view.window;
    }
    self.frame = view.bounds;
    [view addSubview:self];
    
    self.backgroundColor = [UIColor clearColor];
    
    //灰色背景
    self.bgView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, self.frame.size.width, self.frame.size.height)];
    self.bgView.backgroundColor = BLACKCOLOR;
    WS(weakSelf);
    [weakSelf.bgView setTapActionWithBlock:^{
        [weakSelf dismiss];
    }];
    self.bgView.alpha = 0.0;
    [self addSubview:self.bgView];
    
    //创建UI
    [self SetUpUI];
    
    
    [UIView animateKeyframesWithDuration:0.3 delay:0 options:UIViewKeyframeAnimationOptionCalculationModeLinear animations:^{
        self.bgView.alpha = 0.4;
//        self.dateView.y = CYTMainScreen_HEIGHT / 5;
        self.dateView.frame = CGRectMake(0, CYTMainScreen_HEIGHT / 5, CYTMainScreen_WIDTH, CYTMainScreen_HEIGHT * 4 / 5);
    } completion:NULL];
    
}

- (void)SetUpUI {
    
    self.dateView = [[UIView alloc] initWithFrame:CGRectMake(0, CYTMainScreen_HEIGHT, CYTMainScreen_WIDTH, CYTMainScreen_HEIGHT * 4 / 5)];
    self.dateView.backgroundColor = WHITECOLOR;
    [self addSubview:self.dateView];
    
    [CYTUtiltyHelper addLabelWithFrame:CGRectMake(0, FitheightRealValue(5), CYTMainScreen_WIDTH, FitheightRealValue(40)) LabelFontSize:16 LabelTextColor:NavigationBarBackgroundColor LabelTextAlignment:NSTextAlignmentCenter SuperView:self.dateView LabelTag:222 LabelText:@"选择日期"];
    //叉号
    UIImageView *closeView = [CYTUtiltyHelper createImageViewWithFrame:CGRectMake(FitwidthRealValue(13), FitheightRealValue(16), FitheightRealValue(15), FitheightRealValue(15)) imageName:@"close" SuperView:self.dateView];
    WS(weakSelf);
    [closeView setTapActionWithBlock:^{
        [weakSelf dismiss];
    }];
    
    UIView *weekTitlesView = [[UIView alloc] initWithFrame:CGRectMake(0, FitheightRealValue(30), self.dateView.frame.size.width, 64)];
    
    [self.dateView addSubview:weekTitlesView];
    CGFloat weekW = self.dateView.frame.size.width/7;
    NSArray *titles = @[@"日", @"一", @"二", @"三",
                        @"四", @"五", @"六"];
    for (int i = 0; i < 7; i++) {
        UILabel *week = [[UILabel alloc] initWithFrame:CGRectMake(i*weekW, 20, weekW, 44)];
        week.textAlignment = NSTextAlignmentCenter;
        
        [weekTitlesView addSubview:week];
        week.text = titles[i];
    }
    
    ZYCalendarView *view = [[ZYCalendarView alloc] initWithFrame:CGRectMake(0, 64 + FitheightRealValue(40), self.dateView.width, self.dateView.height-64 - FitheightRealValue(40))];
    
    // 不可以点击已经过去的日期
//    view.manager.canSelectPastDays = self.isSingle ? YES : false;
    view.manager.canSelectPastDays = YES;
    // 可以选择时间段
    view.manager.selectionType = self.isSingle ? ZYCalendarSelectionTypeSingle : ZYCalendarSelectionTypeRange;
    
    // 设置被选中颜色
    view.manager.selectedBackgroundColor = NavigationBarBackgroundColor;
    
    // 设置当前日期 请在所有参数设置完之后设置日期
    view.date = [NSDate date];
    
    view.dayViewBlock = ^(ZYCalendarManager *manager, NSDate *dayDate) {
        
        if (manager.selectedDateArray.count == 1
            && view.manager.selectionType == ZYCalendarSelectionTypeSingle){
            NSString *startTime = [manager.dateFormatter stringFromDate:manager.selectedDateArray[0]];
            NSString *endTime = [manager.dateFormatter stringFromDate:manager.selectedDateArray[0]];
            if (_block) {
                _block(startTime,endTime);
            }
            self.finishedBtn = [CYTUtiltyHelper addbuttonWithRect:CGRectMake(FitwidthRealValue(15), CYTMainScreen_HEIGHT - FitheightRealValue(54), CYTMainScreen_WIDTH - FitwidthRealValue(30), FitheightRealValue(44)) LabelText:@"完成" TextFont:FitFont(16) NormalTextColor:WHITECOLOR highLightTextColor:WHITECOLOR NormalBgColor:NavigationBarBackgroundColor highLightBgColor:NavigationBarBackgroundColor tag:125 SuperView:self CornerRadius:3 buttonTarget:self Action:@selector(finishAclcik:)];
        }else if (manager.selectedDateArray.count == 2) {
            NSString *startTime = [manager.dateFormatter stringFromDate:manager.selectedDateArray[0]];
            NSString *endTime = [manager.dateFormatter stringFromDate:manager.selectedDateArray[1]];
            if (_block) {
                _block(startTime,endTime);
            }
//完成按钮
            self.finishedBtn = [CYTUtiltyHelper addbuttonWithRect:CGRectMake(FitwidthRealValue(15), CYTMainScreen_HEIGHT - FitheightRealValue(54), CYTMainScreen_WIDTH - FitwidthRealValue(30), FitheightRealValue(44)) LabelText:@"完成" TextFont:FitFont(16) NormalTextColor:WHITECOLOR highLightTextColor:WHITECOLOR NormalBgColor:NavigationBarBackgroundColor highLightBgColor:NavigationBarBackgroundColor tag:125 SuperView:self CornerRadius:3 buttonTarget:self Action:@selector(finishAclcik:)];
        }else {
            self.finishedBtn = [CYTUtiltyHelper addbuttonWithRect:CGRectMake(FitwidthRealValue(15), CYTMainScreen_HEIGHT, CYTMainScreen_WIDTH - FitwidthRealValue(30), FitheightRealValue(44)) LabelText:@"完成" TextFont:FitFont(16) NormalTextColor:WHITECOLOR highLightTextColor:WHITECOLOR NormalBgColor:NavigationBarBackgroundColor highLightBgColor:NavigationBarBackgroundColor tag:125 SuperView:self CornerRadius:3 buttonTarget:self Action:@selector(finishAclcik:)];

        }
    };
    [self.dateView addSubview:view];
    
}

- (void)getDeliveryTime:(chooseDeliveryTime)callBack {
    _block = callBack;
}

- (void)finishAclcik:(UIButton *)btn {
    [self dismissWithBlock:nil];
}

- (void)dismiss {
    [self dismissWithBlock:nil];
}

- (void)dismissWithBlock:(void(^)())block {
    [UIView animateKeyframesWithDuration:0.3 delay:0 options:UIViewKeyframeAnimationOptionCalculationModeLinear animations:^{
//        self.dateView.y = CYTMainScreen_HEIGHT;
        self.dateView.frame = CGRectMake(0, CYTMainScreen_HEIGHT, CYTMainScreen_WIDTH, CYTMainScreen_HEIGHT * 4 / 5);
        self.finishedBtn.frame = CGRectMake(FitwidthRealValue(15), CYTMainScreen_HEIGHT, CYTMainScreen_WIDTH - FitwidthRealValue(30), FitheightRealValue(44));
        self.bgView.alpha = 0.0;
    } completion:^(BOOL finished) {
        if (finished) {
            if (block) {
                block();
            }
            [self.bgView removeFromSuperview];
            [self.dateView removeFromSuperview];
            [self removeFromSuperview];
        }
    }];
}

@end
