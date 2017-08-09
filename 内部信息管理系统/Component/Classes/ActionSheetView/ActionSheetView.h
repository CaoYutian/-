//
//  ActionSheetView.h
//  YQW
//
//  Created by Sunshine on 2017/6/12.
//  Copyright © 2017年 Sunshine. All rights reserved.
//

#import <UIKit/UIKit.h>

@class ActionSheetView;


@protocol ActionSheetViewDelegate <NSObject>

@optional

/** 即将消失 */
- (void)actionSheet:(ActionSheetView *)actionSheet willDismissWithButtonIndex:(NSInteger)buttonIndex;
/** 已经消失 */
- (void)actionSheet:(ActionSheetView *)actionSheet didDismissWithButtonIndex:(NSInteger)buttonIndex;

@end

typedef void(^ActionSheetViewBlock)(NSInteger index);

@interface ActionSheetView : UIView

/** 操作按钮个数 */
@property (nonatomic, assign, readonly) NSInteger numberOfButtons;
/** 取消按钮 */
@property (nonatomic, assign, readonly) NSInteger cancelButtonIndex;

@property (nonatomic, assign, readonly) NSInteger destructiveButtonIndex;

/** 声明代理 */
@property (nonatomic, weak) id<ActionSheetViewDelegate>actionSheetViewDelegate;
/** 操作block */
@property (nonatomic, copy) ActionSheetViewBlock acitonSheetBlock;


#pragma mark - methods
/** 初始化  block方式调用*/
- (instancetype)initWithTitle:(NSString *)title
            cancelButtonTitle:(NSString *)cancelButtonTitle
       destructiveButtonTitle:(NSString *)destructiveButtonTitle
            otherButtonTitles:(NSArray *)otherButtons
             actionSheetBlock:(ActionSheetViewBlock)actionSheetBlock;

/** 显示 */
- (void)show;

/** 点击操作按钮 */
- (NSString *)buttonTitleAtIndex:(NSInteger)buttonIndex;

@end
