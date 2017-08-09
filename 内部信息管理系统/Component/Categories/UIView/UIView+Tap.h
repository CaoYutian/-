//
//  UIView+Tap.h
//  YQW
//
//  Created by Sunshine on 2017/6/15.
//  Copyright © 2017年 Sunshine. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface UIView (Tap)

/**
 *  动态添加手势
 */
- (void)setTapActionWithBlock:(void (^)(void))block ;

@end
