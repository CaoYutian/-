//
//  DeliveryTimeView.h
//  YQW
//
//  Created by Sunshine on 2017/6/14.
//  Copyright © 2017年 Sunshine. All rights reserved.
//

#import <UIKit/UIKit.h>

typedef void (^chooseDeliveryTime) (NSString *startTime, NSString *endTime);
@interface DeliveryTimeView : UIView

@property (nonatomic, assign) BOOL isSingle;

@property (nonatomic, strong) UIView *bgView;
@property (nonatomic, strong) UIView *dateView;
@property (nonatomic, strong) UIButton *finishedBtn;

- (void)showInView:(UIView *)view;
- (void)getDeliveryTime:(chooseDeliveryTime)callBack;

@end
