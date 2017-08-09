//
//  CYTUtiltyHelper.h
//  ACP
//
//  Created by 。。。 on 2017/3/30.
//  Copyright © 2017年 isofoo. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>

@interface CYTUtiltyHelper : NSObject

#pragma mark - UILabel
/**基本label frame  tag text*/
+(UILabel *)addLabelWithFrame:(CGRect)frame SuperView:(UIView *)superView LabelTag:(NSInteger)tag LabelText:(NSString *)text;

/**label frame  tag text font*/
+(UILabel *)addLabelWithFrame:(CGRect)frame SuperView:(UIView *)superView LabelTag:(NSInteger)tag LabelText:(NSString *)text Font:(UIFont *)font;

/**font textcolor textalignment*/
+(UILabel *)addLabelWithFrame:(CGRect)frame LabelFont:(UIFont*)font LabelTextColor:(UIColor *)color LabelTextAlignment:(NSTextAlignment)alignment SuperView:(UIView *)superView LabelTag:(NSInteger)tag LabelText:(NSString *)text;

/** fontSize textcolor textalignment*/
+(UILabel *)addLabelWithFrame:(CGRect)frame LabelFontSize:(float)fontSize LabelTextColor:(UIColor *)color LabelTextAlignment:(NSTextAlignment)alignment SuperView:(UIView *)superView LabelTag:(NSInteger)tag LabelText:(NSString *)text;

/**设置换行模式 font textcolor textalignment*/
+(UILabel *)addLabelWithFrame:(CGRect)frame LineBreakMode:(NSLineBreakMode)lineBreakMode LabelFont:(UIFont*)font LabelTextColor:(UIColor *)color LabelTextAlignment:(NSTextAlignment)alignment SuperView:(UIView *)superView LabelTag:(NSInteger)tag LabelText:(NSString *)text;
/**设置换行模式 font textcolor textalignment LineBreakMode lineNum*/
+(UILabel *)addLabelWithFrame:(CGRect)frame LineBreakMode:(NSLineBreakMode)lineBreakMode  LineNum:(NSInteger)lineNum LabelFontSize:(float)fontSize LabelTextColor:(UIColor *)color LabelTextAlignment:(NSTextAlignment)alignment SuperView:(UIView *)superView LabelTag:(NSInteger)tag LabelText:(NSString *)text;
/**设置换行模式 fontSize textcolor textalignment*/
+(UILabel *)addLabelWithFrame:(CGRect)frame LineBreakMode:(NSLineBreakMode)lineBreakMode LabelFontSize:(float)fontSize LabelTextColor:(UIColor *)color LabelTextAlignment:(NSTextAlignment)alignment SuperView:(UIView *)superView LabelTag:(NSInteger)tag LabelText:(NSString *)text;

/**设置换行模式 font textcolor textalignment lineNum*/
+(UILabel *)addLabelWithFrame:(CGRect)frame LineNum:(NSInteger)lineNum LabelFont:(UIFont*)font LabelTextColor:(UIColor *)color LabelTextAlignment:(NSTextAlignment)alignment SuperView:(UIView *)superView LabelTag:(NSInteger)tag LabelText:(NSString *)text;

/**设置换行模式 fontSize textcolor textalignment LineNum*/
+(UILabel *)addLabelWithFrame:(CGRect)frame LineNum:(NSInteger)lineNum LabelFontSize:(float)fontSize LabelTextColor:(UIColor *)color LabelTextAlignment:(NSTextAlignment)alignment SuperView:(UIView *)superView LabelTag:(NSInteger)tag LabelText:(NSString *)text;

/** fontsize textcolor textalignment bgcolor cornerRadius*/
+(UILabel *)addLabelWithFrame:(CGRect)frame LabelFontSize:(float)fontSize LabelTextColor:(UIColor *)color LabelTextAlignment:(NSTextAlignment)alignment SuperView:(UIView *)superView LabelTag:(NSInteger)tag LabelText:(NSString *)text BackgroundColor:(UIColor *)bgColor CornerRadius:(float)cornerRadius;


#pragma mark - UIButton
/**空白button*/
+ (UIButton *)addbuttonWithRect:(CGRect)rect  tag:(NSInteger)tag SuperView:(UIView *)superView buttonTarget:(id)target Action:(SEL)action events:(UIControlEvents)event;

/**默认button点击事件是 UIControlEventTouchDown*/
+(UIButton *)addbuttonWithRect:(CGRect)rect  tag:(NSInteger)tag SuperView:(UIView *)superView buttonTarget:(id)target Action:(SEL)action;

/**带文字button*/
+(UIButton *)addbuttonWithRect:(CGRect)rect LabelText:(NSString *)text TextFont:(UIFont *)font NormalTextColor:(UIColor *)normalColor highLightTextColor:(UIColor *)highLightColor  tag:(NSInteger)tag SuperView:(UIView *)superView buttonTarget:(id)target Action:(SEL)action;

/**带图片button*/
+(UIButton *)addbuttonWithRect:(CGRect)rect   NormalbgImageStr:(NSString *)normalimage highLightbgimageStr:(NSString *)hightLightImage  tag:(NSInteger)tag SuperView:(UIView *)superView buttonTarget:(id)target Action:(SEL)action;
/**带图片button 设置图片偏移量*/
+(UIButton *)addbuttonWithRect:(CGRect)rect   NormalbgImageStr:(NSString *)normalimage highLightbgimageStr:(NSString *)hightLightImage  tag:(NSInteger)tag SuperView:(UIView *)superView buttonTarget:(id)target Action:(SEL)action ImageEdgeInsets:(UIEdgeInsets)iEdgeInsets;

/**带文字button 带背景颜色的*/
+(UIButton *)addbuttonWithRect:(CGRect)rect LabelText:(NSString *)text TextFont:(UIFont *)font NormalTextColor:(UIColor *)normalColor highLightTextColor:(UIColor *)highLightColor  NormalBgColor:(UIColor *)normalBgColor highLightBgColor:(UIColor *)LightBgColor tag:(NSInteger)tag SuperView:(UIView *)superView buttonTarget:(id)target Action:(SEL)action;

/**带文字button 带背景颜色的 CornerRadius*/
+(UIButton *)addbuttonWithRect:(CGRect)rect LabelText:(NSString *)text TextFont:(UIFont *)font NormalTextColor:(UIColor *)normalColor highLightTextColor:(UIColor *)highLightColor  NormalBgColor:(UIColor *)normalBgColor highLightBgColor:(UIColor *)LightBgColor tag:(NSInteger)tag SuperView:(UIView *)superView CornerRadius:(float)cornerRadius buttonTarget:(id)target Action:(SEL)action;

/**文字+背景图片*/
+(UIButton *)addbuttonWithRect:(CGRect)rect LabelText:(NSString *)text TextFont:(UIFont *)font NormalTextColor:(UIColor *)normalColor highLightTextColor:(UIColor *)highLightColor  NormalBgImg:(UIImage *)normalBgImg highLightImg:(UIImage *)LightBgImg tag:(NSInteger)tag SuperView:(UIView *)superView buttonTarget:(id)target Action:(SEL)action;

/**带文字button 带背景颜色的 带边界颜色都button*/
+(UIButton *)addbuttonWithRect:(CGRect)rect LabelText:(NSString *)text TextFont:(UIFont *)font NormalTextColor:(UIColor *)normalColor highLightTextColor:(UIColor *)highLightColor  NormalBgColor:(UIColor *)normalBgColor highLightBgColor:(UIColor *)LightBgColor layerBorderColor:(UIColor *)LayerBorderColor tag:(NSInteger)tag SuperView:(UIView *)superView buttonTarget:(id)target Action:(SEL)action;
/**带图片button*/

/**文字图片button  默认文字居左 NSLineBreakByTruncatingTail*/
+ (UIButton *)addButtonWithRect:(CGRect)buttonRect ImageEdgeInsets:(UIEdgeInsets)iEdgeInsets TitleEdgeInsets:(UIEdgeInsets)tEdgeInsets NormalImageName:(NSString *)normal andSelectedImageName:(NSString *)selected ButtonTag:(NSInteger)buttonTag superView:(UIView *)superView    titleText:(NSString *)text titleFont:(UIFont *)font TitleNormalColor:(UIColor *)titleNMColor TitleHighLightColor:(UIColor *)titleHLColor buttonTarget:(id)target Action:(SEL)action;

/**带文字button 带背景颜色的 带边界颜色都button CornerRadius*/
+(UIButton *)addbuttonWithRect:(CGRect)rect LabelText:(NSString *)text TextFont:(UIFont *)font NormalTextColor:(UIColor *)normalColor highLightTextColor:(UIColor *)highLightColor  NormalBgColor:(UIColor *)normalBgColor highLightBgColor:(UIColor *)LightBgColor layerBorderColor:(UIColor *)LayerBorderColor tag:(NSInteger)tag SuperView:(UIView *)superView CornerRadius:(float)cornerRadius buttonTarget:(id)target Action:(SEL)action;


/**
 *  颜色转图片
 *
 *  @param color 颜色
 *
 *  @return 图片
 */
+ (UIImage *)imageWithColor:(UIColor *)color;


+(UIImageView *)createImageViewWithFrame:(CGRect)frame imageName:(NSString *)imageName;
+(UIImageView *)createImageViewWithFrame:(CGRect)frame imageName:(NSString *)imageName SuperView:(UIView *)superView;

//字符串显示不同大小颜色
+ (NSMutableAttributedString *)addAttribute:str firstColorValue:(id)firstColor secondColorValue:(id)secondColor firstFont:(id)firstFont  secondFont:(id)secondFont firstRange:(NSRange)firstRange secondRange:(NSRange)secondRange;

//UITextField
+ (UITextField *)createTextFieldFrame:(CGRect)frame font:(UIFont *)font placeholder:(NSString *)placeholder TextfiledTag:(NSInteger)tag SuperView:(UIView *)superView;
+ (UITextField *)createTextFieldFrame:(CGRect)frame font:(UIFont *)font placeholder:(NSString *)placeholder TextfiledTag:(NSInteger)tag Delegate:(id)delegate CornerRadius:(float)cornerRadius SuperView:(UIView *)superView;

@end
