//
//  titleView.m
//  内部信息管理系统
//
//  Created by Sunshine on 2017/8/9.
//  Copyright © 2017年 Sunshine. All rights reserved.
//

#import "titleView.h"

@implementation titleView

- (instancetype)initWithFrame:(CGRect)frame titles:(NSArray *)titles {
    
    self = [super initWithFrame:frame];
    if (self) {
        self.backgroundColor = WHITECOLOR;
        [self SetUpUI:titles];        
    }
    return self;
}

- (void)SetUpUI:(NSArray *)titles {
    
    for (int i = 0; i < titles.count; i++) {
        
        UIButton *btn = [UIButton buttonWithType:UIButtonTypeCustom];
        btn.frame = CGRectMake(i * self.width / titles.count, 0, self.width / titles.count, FitheightRealValue(39));
        [btn setTitle:titles[i] forState:UIControlStateNormal];
        btn.titleLabel.font = FitFont(14);
        [btn setTitleColor:NavigationBarBackgroundColor forState:UIControlStateNormal];
        [btn setTitleColor:NavigationBarBackgroundColor forState:UIControlStateSelected];
        btn.tag = i + 10;
        [btn addTarget:self action:@selector(changeTopBtn:) forControlEvents:UIControlEventTouchUpInside];
        
        [self addSubview:btn];
        
    }
    UIView *line = [[UIView alloc] initWithFrame:CGRectMake(0, FitheightRealValue(39), CYTMainScreen_WIDTH, 1)];
    line.backgroundColor = NavigationBarBackgroundColor;
    [self addSubview:line];
}

#pragma mark - 改变按钮状态
- (void)changeTopBtn:(UIButton *)sender {
    
}

@end
