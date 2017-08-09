//
//  BaseViewController.h
//  内部信息管理系统
//
//  Created by Sunshine on 2017/7/10.
//  Copyright © 2017年 Sunshine. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface BaseViewController : UIViewController

@property(nonatomic,strong)UIView *navBar;
@property(nonatomic,strong)UIButton *leftBtn;
@property(nonatomic,strong)UIButton *rightBtn;
@property(nonatomic,strong)UILabel *titleLabel;
@property(nonatomic,strong)UIScrollView *contentView;

- (void)leftBtnAction;
- (void)rightBtnAction;
- (void)loadSubViews;
- (void)layoutConstraints;
- (void)loadData;

@end
