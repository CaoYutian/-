//
//  CYTUtiltyHelper.m
//  ACP
//
//  Created by 。。。 on 2017/3/30.
//  Copyright © 2017年 isofoo. All rights reserved.
//

#import "CYTUtiltyHelper.h"
#define SL_COLOR(RED, GREEN, BLUE, ALPHA)	[UIColor colorWithRed:RED green:GREEN blue:BLUE alpha:ALPHA]
#define GET_FONT(fontSize) [UIFont systemFontOfSize:fontSize]
#define GET_IMAGE(imageStr) [UIImage imageNamed:imageStr]

@implementation CYTUtiltyHelper

#pragma mark - UILabel
//基本label
+(UILabel *)addLabelWithFrame:(CGRect)frame SuperView:(UIView *)superView LabelTag:(NSInteger)tag LabelText:(NSString *)text
{
    if (![superView viewWithTag:tag]) {
        UILabel * label = [[UILabel alloc] initWithFrame:frame];
        [label setBackgroundColor:[UIColor clearColor]];
        [label setText:text];
        [label setTag:tag];
        [superView addSubview:label];
    }else{
        UILabel * label = (UILabel *)[superView viewWithTag:tag];
        [label setFrame:frame];
        [label setText:text];
    }
    return (UILabel *)[superView viewWithTag:tag];
}


+(UILabel *)addLabelWithFrame:(CGRect)frame SuperView:(UIView *)superView LabelTag:(NSInteger)tag LabelText:(NSString *)text Font:(UIFont *)font
{
    if (![superView viewWithTag:tag]) {
        UILabel * label = [[UILabel alloc] initWithFrame:frame];
        [label setBackgroundColor:[UIColor clearColor]];
        [label setText:text];
        [label setTag:tag];
        [label setFont:font];
        [superView addSubview:label];
    }else{
        UILabel * label = (UILabel *)[superView viewWithTag:tag];
        [label setFrame:frame];
        [label setText:text];
        [label setFont:font];
    }
    return (UILabel *)[superView viewWithTag:tag];
}

//font textcolor textalignment
+(UILabel *)addLabelWithFrame:(CGRect)frame LabelFont:(UIFont*)font LabelTextColor:(UIColor *)color LabelTextAlignment:(NSTextAlignment)alignment SuperView:(UIView *)superView LabelTag:(NSInteger)tag LabelText:(NSString *)text
{
    UILabel * label =[CYTUtiltyHelper addLabelWithFrame:frame SuperView:superView LabelTag:tag LabelText:text];
    [label setFont:font];
    [label setTextColor:color];
    label.backgroundColor = [UIColor clearColor];
    [label setTextAlignment:alignment];
    return label;
}

// fontSize textcolor textalignment
+(UILabel *)addLabelWithFrame:(CGRect)frame LabelFontSize:(float)fontSize LabelTextColor:(UIColor *)color LabelTextAlignment:(NSTextAlignment)alignment SuperView:(UIView *)superView LabelTag:(NSInteger)tag LabelText:(NSString *)text
{
    return [CYTUtiltyHelper addLabelWithFrame:frame LabelFont:GET_FONT(fontSize) LabelTextColor:color LabelTextAlignment:alignment SuperView:superView LabelTag:tag LabelText:text];
}

// fontsize textcolor textalignment bgcolor cornerRadius
+(UILabel *)addLabelWithFrame:(CGRect)frame LabelFontSize:(float)fontSize LabelTextColor:(UIColor *)color LabelTextAlignment:(NSTextAlignment)alignment SuperView:(UIView *)superView LabelTag:(NSInteger)tag LabelText:(NSString *)text BackgroundColor:(UIColor *)bgColor CornerRadius:(float)cornerRadius
{
    UILabel * label =[CYTUtiltyHelper addLabelWithFrame:frame LabelFontSize:fontSize  LabelTextColor:color LabelTextAlignment:alignment SuperView:superView LabelTag:tag LabelText:text];
    label.backgroundColor = bgColor;
    label.layer.cornerRadius = cornerRadius;
    label.layer.masksToBounds = YES;
    return label;
    
}
//设置换行模式 font textcolor textalignment
+(UILabel *)addLabelWithFrame:(CGRect)frame LineBreakMode:(NSLineBreakMode)lineBreakMode LabelFont:(UIFont*)font LabelTextColor:(UIColor *)color LabelTextAlignment:(NSTextAlignment)alignment SuperView:(UIView *)superView LabelTag:(NSInteger)tag LabelText:(NSString *)text
{
    UILabel *label = [CYTUtiltyHelper addLabelWithFrame:frame LabelFont:font LabelTextColor:color LabelTextAlignment:alignment SuperView:superView LabelTag:tag LabelText:text];
    [label setLineBreakMode:lineBreakMode];
    return label;
}

/**设置换行模式 font textcolor textalignment LineBreakMode lineNum*/
+(UILabel *)addLabelWithFrame:(CGRect)frame LineBreakMode:(NSLineBreakMode)lineBreakMode  LineNum:(NSInteger)lineNum LabelFontSize:(float)fontSize LabelTextColor:(UIColor *)color LabelTextAlignment:(NSTextAlignment)alignment SuperView:(UIView *)superView LabelTag:(NSInteger)tag LabelText:(NSString *)text
{
    UILabel *lable = [CYTUtiltyHelper addLabelWithFrame:frame LineBreakMode:lineBreakMode LabelFontSize:fontSize LabelTextColor:color LabelTextAlignment:alignment SuperView:superView LabelTag:tag LabelText:text];
    lable.numberOfLines = lineNum;
    return lable;
}

//设置换行模式 fontSize textcolor textalignment
+(UILabel *)addLabelWithFrame:(CGRect)frame LineBreakMode:(NSLineBreakMode)lineBreakMode LabelFontSize:(float)fontSize LabelTextColor:(UIColor *)color LabelTextAlignment:(NSTextAlignment)alignment SuperView:(UIView *)superView LabelTag:(NSInteger)tag LabelText:(NSString *)text
{
    UILabel * label =[CYTUtiltyHelper addLabelWithFrame:frame LabelFontSize:fontSize LabelTextColor:color LabelTextAlignment:alignment SuperView:superView LabelTag:tag LabelText:text   ];
    [label setLineBreakMode:lineBreakMode];
    return label;
}

+(UILabel *)addLabelWithFrame:(CGRect)frame LineNum:(NSInteger)lineNum LabelFont:(UIFont*)font LabelTextColor:(UIColor *)color LabelTextAlignment:(NSTextAlignment)alignment SuperView:(UIView *)superView LabelTag:(NSInteger)tag LabelText:(NSString *)text
{
    UILabel *label = [CYTUtiltyHelper addLabelWithFrame:frame LabelFont:font LabelTextColor:color LabelTextAlignment:alignment SuperView:superView LabelTag:tag LabelText:text];
    [label setNumberOfLines:lineNum];
    return label;
}

+(UILabel *)addLabelWithFrame:(CGRect)frame LineNum:(NSInteger)lineNum LabelFontSize:(float)fontSize LabelTextColor:(UIColor *)color LabelTextAlignment:(NSTextAlignment)alignment SuperView:(UIView *)superView LabelTag:(NSInteger)tag LabelText:(NSString *)text
{
    UILabel * label =[CYTUtiltyHelper addLabelWithFrame:frame LabelFontSize:fontSize LabelTextColor:color LabelTextAlignment:alignment SuperView:superView LabelTag:tag LabelText:text   ];
    [label setNumberOfLines:lineNum];
    return label;
}


#pragma mark - UIButton
//空白button
+ (UIButton *)addbuttonWithRect:(CGRect)rect  tag:(NSInteger)tag SuperView:(UIView *)superView buttonTarget:(id)target Action:(SEL)action events:(UIControlEvents)event
{
    if (![superView viewWithTag:tag]) {
        UIButton *button = [[UIButton alloc] initWithFrame:rect];
        [button addTarget:target action:action forControlEvents:event];
        [button setTag:tag];
        [button setExclusiveTouch:YES];
        [superView addSubview:button];
    }else
    {
        UIButton * button = (UIButton *)[superView viewWithTag:tag];
        [button setFrame:rect];
        [button setExclusiveTouch:YES];
        [button addTarget:target action:action forControlEvents:event];
        [button setTag:tag];
    }
    return (UIButton *)[superView viewWithTag:tag];
}

//默认button点击事件是 UIControlEventTouchDown
+(UIButton *)addbuttonWithRect:(CGRect)rect  tag:(NSInteger)tag SuperView:(UIView *)superView buttonTarget:(id)target Action:(SEL)action
{
    return  [CYTUtiltyHelper  addbuttonWithRect:rect tag:tag SuperView:superView buttonTarget:target Action:action events:UIControlEventTouchUpInside];
}

//带图片button
+(UIButton *)addbuttonWithRect:(CGRect)rect   NormalbgImageStr:(NSString *)normalimage highLightbgimageStr:(NSString *)hightLightImage  tag:(NSInteger)tag SuperView:(UIView *)superView buttonTarget:(id)target Action:(SEL)action
{
    UIButton * button = [CYTUtiltyHelper addbuttonWithRect:rect tag:tag SuperView:superView buttonTarget:target Action:action];
    [button setImage:GET_IMAGE(normalimage) forState:UIControlStateNormal];
    [button setImage:GET_IMAGE(hightLightImage) forState:UIControlStateSelected];
    return button;
}

//带图片button 设置图片偏移量
+(UIButton *)addbuttonWithRect:(CGRect)rect   NormalbgImageStr:(NSString *)normalimage highLightbgimageStr:(NSString *)hightLightImage  tag:(NSInteger)tag SuperView:(UIView *)superView buttonTarget:(id)target Action:(SEL)action ImageEdgeInsets:(UIEdgeInsets)iEdgeInsets
{
    UIButton * button = [CYTUtiltyHelper addbuttonWithRect:rect tag:tag SuperView:superView buttonTarget:target Action:action];
    [button setImage:GET_IMAGE(normalimage) forState:UIControlStateNormal];
    [button setImage:GET_IMAGE(hightLightImage) forState:UIControlStateHighlighted];
    [button setImageEdgeInsets:iEdgeInsets];
    return button;
}

//带文字button
+(UIButton *)addbuttonWithRect:(CGRect)rect LabelText:(NSString *)text TextFont:(UIFont *)font NormalTextColor:(UIColor *)normalColor highLightTextColor:(UIColor *)highLightColor  tag:(NSInteger)tag SuperView:(UIView *)superView buttonTarget:(id)target Action:(SEL)action
{
    UIButton * button = [CYTUtiltyHelper addbuttonWithRect:rect tag:tag SuperView:superView buttonTarget:target Action:action];
    [button.titleLabel setFont:font];
    [button setTitle:text forState:UIControlStateNormal];
    [button setTitle:text forState:UIControlStateHighlighted];
    [button setTitleColor:normalColor forState:UIControlStateNormal];
    [button setTitleColor:highLightColor forState:UIControlStateSelected];
    return button;
}

//带文字button 带背景颜色的
+(UIButton *)addbuttonWithRect:(CGRect)rect LabelText:(NSString *)text TextFont:(UIFont *)font NormalTextColor:(UIColor *)normalColor highLightTextColor:(UIColor *)highLightColor  NormalBgColor:(UIColor *)normalBgColor highLightBgColor:(UIColor *)LightBgColor tag:(NSInteger)tag SuperView:(UIView *)superView buttonTarget:(id)target Action:(SEL)action
{
    UIButton * button =[CYTUtiltyHelper addbuttonWithRect:rect LabelText:text TextFont:font NormalTextColor:normalColor highLightTextColor:highLightColor  tag:tag SuperView:superView buttonTarget:target Action:action];
    [button setBackgroundImage:[CYTUtiltyHelper getbuttonImage:CGRectMake(0, 0, rect.size.width, rect.size.height) color:normalBgColor] forState:UIControlStateNormal];
    
    if (LightBgColor) {
        [button setBackgroundImage:[CYTUtiltyHelper getbuttonImage:CGRectMake(0, 0, rect.size.width, rect.size.height) color:LightBgColor] forState:UIControlStateHighlighted];
    }
    return button;
}

//带文字button 带背景颜色的 CornerRadius
+(UIButton *)addbuttonWithRect:(CGRect)rect LabelText:(NSString *)text TextFont:(UIFont *)font NormalTextColor:(UIColor *)normalColor highLightTextColor:(UIColor *)highLightColor  NormalBgColor:(UIColor *)normalBgColor highLightBgColor:(UIColor *)LightBgColor tag:(NSInteger)tag SuperView:(UIView *)superView CornerRadius:(float)cornerRadius buttonTarget:(id)target Action:(SEL)action
{
    UIButton * button =[CYTUtiltyHelper addbuttonWithRect:rect LabelText:text TextFont:font NormalTextColor:normalColor highLightTextColor:highLightColor  tag:tag SuperView:superView buttonTarget:target Action:action];
    [button setBackgroundImage:[CYTUtiltyHelper getbuttonImage:CGRectMake(0, 0, rect.size.width, rect.size.height) color:normalBgColor] forState:UIControlStateNormal];
    //
    if (LightBgColor) {
        [button setBackgroundImage:[CYTUtiltyHelper getbuttonImage:CGRectMake(0, 0, rect.size.width, rect.size.height) color:LightBgColor] forState:UIControlStateHighlighted];
    }
    button.layer.cornerRadius = cornerRadius;
    button.layer.masksToBounds = YES;
    
    return button;
}

//带文字button 带背景颜色的
+(UIButton *)addbuttonWithRect:(CGRect)rect LabelText:(NSString *)text TextFont:(UIFont *)font NormalTextColor:(UIColor *)normalColor highLightTextColor:(UIColor *)highLightColor  NormalBgImg:(UIImage *)normalBgImg highLightImg:(UIImage *)LightBgImg tag:(NSInteger)tag SuperView:(UIView *)superView buttonTarget:(id)target Action:(SEL)action
{
    UIButton * button =[CYTUtiltyHelper addbuttonWithRect:rect LabelText:text TextFont:font NormalTextColor:normalColor highLightTextColor:highLightColor  tag:tag SuperView:superView buttonTarget:target Action:action];
    
    [button setBackgroundImage:normalBgImg forState:UIControlStateNormal];
    [button setBackgroundImage:LightBgImg forState:UIControlStateHighlighted];
    
    return button;
}

//文字+背景图片
+(UIButton *)addbuttonWithRect:(CGRect)rect LabelText:(NSString *)text TextFont:(UIFont *)font NormalTextColor:(UIColor *)normalColor highLightTextColor:(UIColor *)highLightColor  NormalBgColor:(UIColor *)normalBgColor highLightBgColor:(UIColor *)LightBgColor layerBorderColor:(UIColor *)LayerBorderColor tag:(NSInteger)tag SuperView:(UIView *)superView buttonTarget:(id)target Action:(SEL)action
{
    UIButton * button = [CYTUtiltyHelper addbuttonWithRect:rect LabelText:text TextFont:font NormalTextColor:normalColor highLightTextColor:highLightColor NormalBgColor:normalBgColor highLightBgColor:LightBgColor tag:tag SuperView:superView buttonTarget:target Action:action];
    button.layer.borderWidth = 0.5;
    button.layer.borderColor = LayerBorderColor.CGColor;
    return button;
}

//带文字button 带背景颜色的 带边界颜色都button CornerRadius
+(UIButton *)addbuttonWithRect:(CGRect)rect LabelText:(NSString *)text TextFont:(UIFont *)font NormalTextColor:(UIColor *)normalColor highLightTextColor:(UIColor *)highLightColor  NormalBgColor:(UIColor *)normalBgColor highLightBgColor:(UIColor *)LightBgColor layerBorderColor:(UIColor *)LayerBorderColor tag:(NSInteger)tag SuperView:(UIView *)superView CornerRadius:(float)cornerRadius buttonTarget:(id)target Action:(SEL)action
{
    UIButton * button = [CYTUtiltyHelper addbuttonWithRect:rect LabelText:text TextFont:font NormalTextColor:normalColor highLightTextColor:highLightColor NormalBgColor:normalBgColor highLightBgColor:LightBgColor layerBorderColor:LayerBorderColor tag:tag SuperView:superView buttonTarget:target Action:action];
    button.layer.cornerRadius = cornerRadius;
    button.layer.masksToBounds = YES;
    return button;
}

//文字图片button  默认文字居左 NSLineBreakByTruncatingTail
+ (UIButton *)addButtonWithRect:(CGRect)buttonRect ImageEdgeInsets:(UIEdgeInsets)iEdgeInsets TitleEdgeInsets:(UIEdgeInsets)tEdgeInsets NormalImageName:(NSString *)normal andSelectedImageName:(NSString *)selected ButtonTag:(NSInteger)buttonTag superView:(UIView *)superView    titleText:(NSString *)text titleFont:(UIFont *)font TitleNormalColor:(UIColor *)titleNMColor TitleHighLightColor:(UIColor *)titleHLColor buttonTarget:(id)target Action:(SEL)action{
    UIButton * button=  [CYTUtiltyHelper addbuttonWithRect:buttonRect LabelText:text TextFont:font NormalTextColor:titleNMColor highLightTextColor:titleHLColor  tag:buttonTag SuperView:superView buttonTarget:target Action:action];
    [button setImageEdgeInsets:iEdgeInsets];
    [button setContentHorizontalAlignment:UIControlContentHorizontalAlignmentLeft];
    [button setContentVerticalAlignment:UIControlContentVerticalAlignmentTop];
    [button setImage:GET_IMAGE(normal) forState:UIControlStateNormal];
    [button setImage:GET_IMAGE(selected) forState:UIControlStateHighlighted];
    button.titleLabel.textAlignment=NSTextAlignmentRight;
    button.titleLabel.lineBreakMode=NSLineBreakByTruncatingTail;
    [button setTitleEdgeInsets:tEdgeInsets];
    return (UIButton *)[superView viewWithTag:buttonTag];
}

/**
 *  颜色转图片
 *
 *  @param color 颜色
 *
 *  @return 图片
 */
+ (UIImage *)imageWithColor:(UIColor *)color {
    CGRect rect = CGRectMake(0.0f, 0.0f, 1.0f, 1.0f);
    UIGraphicsBeginImageContext(rect.size);
    CGContextRef context = UIGraphicsGetCurrentContext();
    
    CGContextSetFillColorWithColor(context, [color CGColor]);
    CGContextFillRect(context, rect);
    
    UIImage *image = UIGraphicsGetImageFromCurrentImageContext();
    UIGraphicsEndImageContext();
    
    return image;
}

//获取背景纯色图片
+(UIImage *)getbuttonImage:(CGRect )rect color:(UIColor *)color
{
    UIGraphicsBeginImageContextWithOptions(rect.size,NO,0);
    UIBezierPath* p =[UIBezierPath bezierPathWithRect:CGRectMake(0,0,rect.size.width,rect.size.height)];
    [color setFill];
    [p fill];
    UIImage*im=UIGraphicsGetImageFromCurrentImageContext();
    UIGraphicsEndImageContext();
    return im;
}

//UIImageView
+(UIImageView *)createImageViewWithFrame:(CGRect)frame imageName:(NSString *)imageName{
    UIImageView * imageView = [[UIImageView alloc]initWithFrame:frame];
    imageView.image = [UIImage imageNamed:imageName];
    return imageView;
}
+(UIImageView *)createImageViewWithFrame:(CGRect)frame imageName:(NSString *)imageName SuperView:(UIView *)superView{
    UIImageView * imageView = [[UIImageView alloc]initWithFrame:frame];
    imageView.image = [UIImage imageNamed:imageName];
    [superView addSubview:imageView];
    return imageView;
}

+ (NSMutableAttributedString *)addAttribute:str firstColorValue:(id)firstColor secondColorValue:(id)secondColor firstFont:(id)firstFont  secondFont:(id)secondFont firstRange:(NSRange)firstRange secondRange:(NSRange)secondRange; {
    
    NSMutableAttributedString *Attri = [[NSMutableAttributedString alloc] initWithString:str];
    [Attri addAttribute:NSForegroundColorAttributeName value:firstColor range:firstRange];
    [Attri addAttribute:NSFontAttributeName value:firstFont range:firstRange];
    
    [Attri addAttribute:NSForegroundColorAttributeName value:secondColor range:secondRange];
    [Attri addAttribute:NSFontAttributeName value:secondFont range:secondRange];
    
    return Attri;
}

#pragma mark textfeild btn 的封装
+ (UITextField *)createTextFieldFrame:(CGRect)frame font:(UIFont *)font placeholder:(NSString *)placeholder TextfiledTag:(NSInteger)tag SuperView:(UIView *)superView{
    UITextField *textField = [[UITextField alloc] initWithFrame:frame];
    [superView addSubview:textField];
    [textField setTag:tag];
    textField.font = font;
    textField.textColor = [UIColor grayColor];
    textField.borderStyle = UITextBorderStyleRoundedRect;
    textField.placeholder = placeholder;
    return textField;
    
}
+ (UITextField *)createTextFieldFrame:(CGRect)frame font:(UIFont *)font placeholder:(NSString *)placeholder TextfiledTag:(NSInteger)tag Delegate:(id)delegate CornerRadius:(float)cornerRadius SuperView:(UIView *)superView{
    
    UITextField *textField = [[UITextField alloc] initWithFrame:frame];
    [superView addSubview:textField];
    [textField setTag:tag];
    textField.font = font;
    textField.textColor = [UIColor grayColor];
    textField.borderStyle = UITextBorderStyleRoundedRect;
    textField.placeholder = placeholder;
    textField.delegate = delegate;
    textField.layer.cornerRadius = cornerRadius;
    textField.layer.masksToBounds = YES;
    return textField;
    
}

@end
