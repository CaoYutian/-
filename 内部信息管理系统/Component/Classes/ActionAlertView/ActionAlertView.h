//
//  ActionAlertView.h
//  YQW
//
//  Created by Sunshine on 2017/6/6.
//  Copyright © 2017年 Sunshine. All rights reserved.
//

#import <UIKit/UIKit.h>

//点击按钮回调
typedef void(^AlertResult)(NSInteger index);

@interface ActionAlertView : UIView

@property(nonatomic,copy) AlertResult resultIndex;
/** 输入框 */
@property(nonatomic,strong) UITextField *InputBox;

- (instancetype)initWithTitle:(NSString *)title message:(NSString *)message placeholder:(NSString *)placeholder sureBtn:(NSString *)sureTitle cancleBtn:(NSString *)cancleTitle;
- (void)showAlertView;


@end
