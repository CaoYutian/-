//
//  BaseViewController.m
//  内部信息管理系统
//
//  Created by Sunshine on 2017/7/10.
//  Copyright © 2017年 Sunshine. All rights reserved.
//

#import "BaseViewController.h"
#import "AppNavigationController.h"

@interface BaseViewController ()


@end

@implementation BaseViewController

- (void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];
    [UIView setAnimationsEnabled:YES];
    [self.navigationController setNavigationBarHidden:NO animated:YES];
    
    // 在自定义leftBarButtonItem后添加下面代码就可以完美解决返回手势无效的情况
    if ([self.navigationController respondsToSelector:@selector(interactivePopGestureRecognizer)]) {
        self.navigationController.interactivePopGestureRecognizer.delegate = nil;
    }
    NSArray *gestureArray = self.navigationController.view.gestureRecognizers;
    //当是侧滑手势的时候设置scrollview需要此手势失效才生效即可
    for (UIGestureRecognizer *gesture in gestureArray) {
        if ([gesture isKindOfClass:[UIScreenEdgePanGestureRecognizer class]]) {
            
            for (UIView *sub in self.view.subviews) {
                if ([sub isKindOfClass:[UIScrollView class]]) {
                    UIScrollView *sc = (UIScrollView *)sub;
                    [sc.panGestureRecognizer requireGestureRecognizerToFail:gesture];
                }
            }
        }
    }
}


#pragma mark - life style
- (void)viewDidLoad {
    [super viewDidLoad];
    self.navBar.backgroundColor = NavigationBarBackgroundColor;
    
    self.automaticallyAdjustsScrollViewInsets = NO;
    self.view.backgroundColor = MainBackgroundColor;
    [self loadSubViews];
    [self.view bringSubviewToFront:self.navBar];
    [self layoutConstraints];
    [self loadData];
}

- (void)dealloc
{
    [[NSNotificationCenter defaultCenter] removeObserver:self];
}

- (void)loadSubViews
{
    [self.view addSubview:self.contentView];
    [self.view addSubview:self.navBar];
    [self.navBar addSubview:self.leftBtn];
    [self.navBar addSubview:self.rightBtn];
    self.leftBtn.hidden = (self.navigationController.childViewControllers.count<=1);
    self.rightBtn.hidden = YES;
    [self.navBar addSubview:self.titleLabel];
    [self layoutNavigationBar];
}

- (void)layoutNavigationBar
{
    WS(weakSelf);
    
    [self.contentView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.edges.equalTo(weakSelf.view).insets(UIEdgeInsetsMake(64, 0, 0, 0));
    }];
    
    [self.navBar mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(weakSelf.view);
        make.top.equalTo(weakSelf.view);
        make.right.equalTo(weakSelf.view);
        make.height.mas_equalTo(64);
    }];
    
    [self.leftBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(weakSelf.navBar).offset(0);
        make.top.equalTo(weakSelf.navBar).offset(20);
        make.width.mas_equalTo(60);
        make.height.mas_equalTo(40);
    }];
    
    [self.rightBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.right.equalTo(weakSelf.navBar);
        make.top.equalTo(weakSelf.navBar).offset(20);
        make.width.mas_equalTo(60);
        make.height.mas_equalTo(40);
    }];
    
    [self.titleLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(weakSelf.leftBtn.mas_right).offset(5);
        make.right.mas_equalTo(weakSelf.rightBtn.mas_left).offset(-5);
        make.top.equalTo(weakSelf.navBar).offset(20);
        make.height.mas_equalTo(40);
    }];
    [self.view setNeedsLayout];
}

- (void)layoutConstraints
{
    
}

- (void)loadData {
    
}

#pragma mark - actions
- (void)leftBtnAction
{
    [self.navigationController popViewControllerAnimated:YES];
}

- (void)rightBtnAction
{
    
}

#pragma mark - getters and setters
- (UIView *)navBar
{
    if (!_navBar) {
        _navBar= [[UIView alloc] init];
        _navBar.backgroundColor = [UIColor whiteColor];
        _navBar.layer.shadowOffset = CGSizeMake(0, 0.3);
        _navBar.layer.shadowColor = COLOR_BG_COVER.CGColor;
        _navBar.layer.shadowOpacity = 0.3;
    }
    return _navBar;
}

- (UIButton *)leftBtn {
    if (!_leftBtn) {
        _leftBtn = [UIButton buttonWithType:UIButtonTypeCustom];
        [_leftBtn setImage:[UIImage imageNamed:@"ic_back"] forState:UIControlStateNormal];
        [_leftBtn setImage:[UIImage imageNamed:@"ic_back"] forState:UIControlStateHighlighted];
        [_leftBtn addTarget:self action:@selector(leftBtnAction) forControlEvents:UIControlEventTouchUpInside];
        [_leftBtn setContentMode:UIViewContentModeCenter];
        _leftBtn.imageView.layer.masksToBounds = YES;
    }
    return _leftBtn;
}

- (UIButton *)rightBtn
{
    if (!_rightBtn) {
        _rightBtn = [UIButton buttonWithType:UIButtonTypeCustom];
        [_rightBtn addTarget:self action:@selector(rightBtnAction) forControlEvents:UIControlEventTouchUpInside];
        _rightBtn.titleLabel.font = [UIFont boldSystemFontOfSize:15];
        [_rightBtn setTitleColor:WHITECOLOR forState:UIControlStateNormal];
        [_rightBtn setTitleColor:WHITECOLOR forState:UIControlStateHighlighted];
        _rightBtn.titleLabel.textAlignment = NSTextAlignmentRight;
        [_rightBtn setContentMode:UIViewContentModeCenter];
    }
    return _rightBtn;
}

- (UIView *)titleLabel
{
    if (!_titleLabel) {
        _titleLabel= [[UILabel alloc] init];
        _titleLabel.font = FONT(18);
        _titleLabel.textColor = BLACKCOLOR;
        _titleLabel.textAlignment = NSTextAlignmentCenter;
    }
    return _titleLabel;
}

- (UIScrollView *)contentView
{
    if (!_contentView) {
        _contentView = [[UIScrollView alloc] init];
        _contentView.scrollEnabled = NO;
        _contentView.backgroundColor = [UIColor clearColor];
        _contentView.scrollsToTop = NO;
    }
    return _contentView;
}

@end
