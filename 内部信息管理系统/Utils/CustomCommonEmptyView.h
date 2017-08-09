//
//  CustomCommonEmptyView.h
//  内部信息管理系统
//
//  Created by Sunshine on 2017/8/2.
//  Copyright © 2017年 Sunshine. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface CustomCommonEmptyView : UIView

@property (nonatomic, weak) UIImageView *topTipImageView;
@property (nonatomic, weak) UILabel *firstL;
@property (nonatomic, weak) UILabel *secondL;

- (instancetype)initWithTitle:(NSString *)title
                  secondTitle:(NSString *)secondTitle
                     iconname:(NSString *)iconname;
- (instancetype)initWithAttributedTitle:(NSMutableAttributedString *)attributedTitle
                  secondAttributedTitle:(NSMutableAttributedString *)secondAttributedTitle
                               iconname:(NSString *)iconname;
- (void)showInView:(UIView *)view;


@end
