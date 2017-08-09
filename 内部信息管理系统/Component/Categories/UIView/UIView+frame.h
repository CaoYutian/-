//
//  UIView+frame.h
//  YQW
//
//  Created by Sunshine on 2017/6/15.
//  Copyright © 2017年 Sunshine. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface UIView (frame)

/*
 设置或返回View的 x y h w
 */
@property (nonatomic, assign) float h;
@property (nonatomic, assign) float w;
@property (nonatomic, assign) float x;
@property (nonatomic, assign) float y;
@property (nonatomic, assign) CGFloat centerX;
@property (nonatomic, assign) CGFloat centerY;

@end
