//
//  ActionAlertView.m
//  YQW
//
//  Created by Sunshine on 2017/6/6.
//  Copyright © 2017年 Sunshine. All rights reserved.
//

#import "ActionAlertView.h"

// AlertW 宽
#define AlertW CYTMainScreen_WIDTH - FitwidthRealValue(100)

@interface ActionAlertView ()

/** 弹窗 */
@property(nonatomic,strong) UIView *alertView;
/** title */
@property(nonatomic,strong) UILabel *titleLbl;
/** 内容 */
@property(nonatomic,strong) UILabel *msgLbl;
/** 确认按钮 */
@property(nonatomic,strong) UIButton *sureBtn;
/** 取消按钮 */
@property(nonatomic,strong) UIButton *cancleBtn;
/** 横线 */
@property(nonatomic,strong) UIView *lineView;
/** 竖线 */
@property(nonatomic,strong) UIView *verLineView;

@end


@implementation ActionAlertView

- (instancetype)initWithTitle:(NSString *)title message:(NSString *)message sureBtn:(NSString *)sureTitle cancleBtn:(NSString *)cancleTitle{
    
    if (self = [super init]) {
        
        self.frame = [UIScreen mainScreen].bounds;
        self.backgroundColor = COLOR_BG_COVER;
        self.alertView = [[UIView alloc]init];
        self.alertView.backgroundColor = WHITECOLOR;
        self.alertView.layer.cornerRadius = 5.0;
        self.alertView.frame = CGRectMake(0, 0, AlertW, 100);
        self.alertView.layer.position = self.center;
        
        // 标题
        if (title) {
            
            self.titleLbl = [self getAdaptiveLable:CGRectMake(2*MARGIN_SPACE, 2*MARGIN_SPACE, AlertW-4*MARGIN_SPACE, 20) contentStr:title isTitle:YES];
            self.titleLbl.textAlignment = NSTextAlignmentCenter;
            [self.alertView addSubview:self.titleLbl];
            CGFloat titleW = self.titleLbl.bounds.size.width;
            CGFloat titleH = self.titleLbl.bounds.size.height;
            self.titleLbl.frame = CGRectMake((AlertW-titleW)/2, 2*MARGIN_SPACE, titleW, titleH);
        }
        
        // 内容
        if (message) {
            
            self.msgLbl = [self getAdaptiveLable:CGRectMake(MARGIN_SPACE, CGRectGetMaxY(self.titleLbl.frame)+MARGIN_SPACE, AlertW-2*MARGIN_SPACE, 20) contentStr:message isTitle:NO];
            self.msgLbl.textAlignment = NSTextAlignmentCenter;
            [self.alertView addSubview:self.msgLbl];
            CGFloat msgW = self.msgLbl.bounds.size.width;
            CGFloat msgH = self.msgLbl.bounds.size.height;
            self.msgLbl.frame = self.titleLbl?CGRectMake((AlertW-msgW)/2, CGRectGetMaxY(self.titleLbl.frame)+MARGIN_SPACE, msgW, msgH):CGRectMake((AlertW-msgW)/2, 2*MARGIN_SPACE, msgW, msgH);
        }
        
        // 横线
        self.lineView = [[UIView alloc] init];
        self.lineView.frame = self.msgLbl?CGRectMake(0, CGRectGetMaxY(self.msgLbl.frame)+2*MARGIN_SPACE, AlertW, 1):CGRectMake(0, CGRectGetMaxY(self.titleLbl.frame)+2*MARGIN_SPACE, AlertW, 1);
        self.lineView.backgroundColor = [UIColor colorWithWhite:0.8 alpha:0.6];
        [self.alertView addSubview:self.lineView];
        
        // 有两个按钮
        if (cancleTitle && sureTitle) {
            
            // 取消按钮
            self.cancleBtn = [UIButton buttonWithType:UIButtonTypeSystem];
            self.cancleBtn.frame = CGRectMake(0, CGRectGetMaxY(self.lineView.frame), (AlertW-1)/2, 40);
            [self.cancleBtn setBackgroundImage:[UIImage createImageWithColor:[UIColor colorWithRed:255/255.0 green:255/255.0 blue:255/255.0 alpha:0.2]] forState:UIControlStateNormal];
            [self.cancleBtn setBackgroundImage:[UIImage createImageWithColor:[UIColor colorWithRed:255/255.0 green:255/255.0 blue:255/255.0 alpha:0.2]] forState:UIControlStateSelected];
            [self.cancleBtn setTitle:cancleTitle forState:UIControlStateNormal];
            [self.cancleBtn setTitleColor:BLACKCOLOR forState:UIControlStateNormal];
            self.cancleBtn.tag = 1;
            [self.cancleBtn addTarget:self action:@selector(buttonEvent:) forControlEvents:UIControlEventTouchUpInside];
            
            UIBezierPath *maskPath = [UIBezierPath bezierPathWithRoundedRect:self.cancleBtn.bounds byRoundingCorners:UIRectCornerBottomLeft cornerRadii:CGSizeMake(5.0, 5.0)];
            CAShapeLayer *maskLayer = [[CAShapeLayer alloc] init];
            maskLayer.frame = self.cancleBtn.bounds;
            maskLayer.path = maskPath.CGPath;
            self.cancleBtn.layer.mask = maskLayer;
            
            [self.alertView addSubview:self.cancleBtn];
            
            // 竖线
            self.verLineView = [[UIView alloc] init];
            self.verLineView.frame = CGRectMake(CGRectGetMaxX(self.cancleBtn.frame), CGRectGetMaxY(self.lineView.frame), 1, 40);
            self.verLineView.backgroundColor = [UIColor colorWithWhite:0.8 alpha:0.6];
            [self.alertView addSubview:self.verLineView];
            
            // 确定按钮
            self.sureBtn = [UIButton buttonWithType:UIButtonTypeSystem];
            self.sureBtn.frame = CGRectMake(CGRectGetMaxX(self.verLineView.frame), CGRectGetMaxY(self.lineView.frame), (AlertW-1)/2+1, 40);
            [self.sureBtn setTitleColor:[UIColor redColor] forState:UIControlStateNormal];
            [self.sureBtn setBackgroundImage:[UIImage createImageWithColor:[UIColor colorWithRed:255/255.0 green:255/255.0 blue:255/255.0 alpha:0.2]] forState:UIControlStateSelected];
            [self.sureBtn setTitle:sureTitle forState:UIControlStateNormal];
            self.sureBtn.tag = 2;
            [self.sureBtn addTarget:self action:@selector(buttonEvent:) forControlEvents:UIControlEventTouchUpInside];
            
            UIBezierPath *maskPath1 = [UIBezierPath bezierPathWithRoundedRect:self.sureBtn.bounds byRoundingCorners:UIRectCornerBottomRight cornerRadii:CGSizeMake(5.0, 5.0)];
            CAShapeLayer *maskLayer1 = [[CAShapeLayer alloc] init];
            maskLayer1.frame = self.sureBtn.bounds;
            maskLayer1.path = maskPath1.CGPath;
            self.sureBtn.layer.mask = maskLayer1;
            
            [self.alertView addSubview:self.sureBtn];
        }
        
        // 只有取消按钮
        if (cancleTitle && !sureTitle) {
            
            self.cancleBtn = [UIButton buttonWithType:UIButtonTypeSystem];
            self.cancleBtn.frame = CGRectMake(0, CGRectGetMaxY(self.lineView.frame), AlertW, 40);
            [self.cancleBtn setBackgroundImage:[UIImage createImageWithColor:[UIColor colorWithRed:255/255.0 green:255/255.0 blue:255/255.0 alpha:0.2]] forState:UIControlStateNormal];
            [self.cancleBtn setBackgroundImage:[UIImage createImageWithColor:[UIColor colorWithRed:255/255.0 green:255/255.0 blue:255/255.0 alpha:0.2]] forState:UIControlStateSelected];
            [self.cancleBtn setTitle:cancleTitle forState:UIControlStateNormal];
            [self.cancleBtn setTitleColor:[UIColor redColor] forState:UIControlStateNormal];
            self.cancleBtn.tag = 1;
            [self.cancleBtn addTarget:self action:@selector(buttonEvent:) forControlEvents:UIControlEventTouchUpInside];
            
            UIBezierPath *maskPath = [UIBezierPath bezierPathWithRoundedRect:self.cancleBtn.bounds byRoundingCorners:UIRectCornerBottomLeft cornerRadii:CGSizeMake(5.0, 5.0)];
            CAShapeLayer *maskLayer = [[CAShapeLayer alloc] init];
            maskLayer.frame = self.cancleBtn.bounds;
            maskLayer.path = maskPath.CGPath;
            self.cancleBtn.layer.mask = maskLayer;
            
            [self.alertView addSubview:self.cancleBtn];
        }
        
        // 只有确定按钮
        if(sureTitle && !cancleTitle){
            
            self.sureBtn = [UIButton buttonWithType:UIButtonTypeSystem];
            self.sureBtn.frame = CGRectMake(0, CGRectGetMaxY(self.lineView.frame), AlertW, 40);
            [self.sureBtn setTitle:sureTitle forState:UIControlStateNormal];
            [self.sureBtn setTitleColor:[UIColor redColor] forState:UIControlStateNormal];
            self.sureBtn.tag = 2;
            [self.sureBtn addTarget:self action:@selector(buttonEvent:) forControlEvents:UIControlEventTouchUpInside];
            
            UIBezierPath *maskPath = [UIBezierPath bezierPathWithRoundedRect:self.sureBtn.bounds byRoundingCorners:UIRectCornerBottomRight cornerRadii:CGSizeMake(5.0, 5.0)];
            CAShapeLayer *maskLayer = [[CAShapeLayer alloc] init];
            maskLayer.frame = self.sureBtn.bounds;
            maskLayer.path = maskPath.CGPath;
            self.sureBtn.layer.mask = maskLayer;
            
            [self.alertView addSubview:self.sureBtn];
        }
        
        // 计算高度
        CGFloat alertHeight = cancleTitle?CGRectGetMaxY(self.cancleBtn.frame):CGRectGetMaxY(self.sureBtn.frame);
        self.alertView.frame = CGRectMake(0, 0, AlertW, alertHeight);
        self.alertView.layer.position = self.center;
        [self addSubview:self.alertView];
    }
    return self;
}

- (UILabel *)getAdaptiveLable:(CGRect)rect contentStr:(NSString *)contentStr isTitle:(BOOL)isTitle {
    UILabel *contentLbl = [[UILabel alloc] initWithFrame:rect];
    contentLbl.numberOfLines = 0;
    contentLbl.text = contentStr;
    contentLbl.textAlignment = NSTextAlignmentCenter;
    if (isTitle) {
        contentLbl.font = [UIFont boldSystemFontOfSize:16.0];
    }else{
        contentLbl.font = [UIFont systemFontOfSize:14.0];
    }
    
    NSMutableAttributedString *mAttrStr = [[NSMutableAttributedString alloc] initWithString:contentStr];
    NSMutableParagraphStyle *mParaStyle = [[NSMutableParagraphStyle alloc] init];
    mParaStyle.lineBreakMode = NSLineBreakByCharWrapping;
    [mParaStyle setLineSpacing:3.0];
    [mAttrStr addAttribute:NSParagraphStyleAttributeName value:mParaStyle range:NSMakeRange(0,[contentStr length])];
    [contentLbl setAttributedText:mAttrStr];
    [contentLbl sizeToFit];
    
    return contentLbl;
}

#pragma mark - 弹出
- (void)showAlertView {
    [mainWindow() endEditing:YES];
    UIWindow *rootWindow = [UIApplication sharedApplication].keyWindow;
    [rootWindow addSubview:self];
    
    self.alertView.layer.position = self.center;
    self.alertView.transform = CGAffineTransformMakeScale(0.90, 0.90);
    [UIView animateWithDuration:0.25 delay:0 usingSpringWithDamping:0.8 initialSpringVelocity:1 options:UIViewAnimationOptionCurveLinear animations:^{
        self.alertView.transform = CGAffineTransformMakeScale(1.0, 1.0);
    } completion:^(BOOL finished) {
        
    }];
    
    [CommonUtils setCAKeyframeAnimation:self.alertView];
}

#pragma mark - 点击确定按钮回调
- (void)buttonEvent:(UIButton *)sender {
    if (sender.tag == 2) {
        if (self.resultIndex) {
            self.resultIndex(sender.tag);
        }
    }
    if (sender.tag == 1) {
        if (self.resultIndex) {
            self.resultIndex(sender.tag);
        }
    }
    [self removeFromSuperview];
}

@end
