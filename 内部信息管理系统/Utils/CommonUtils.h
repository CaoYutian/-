//
//  CommonUtils.h
//  内部信息管理系统
//
//  Created by Sunshine on 2017/7/24.
//  Copyright © 2017年 Sunshine. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface CommonUtils : NSObject

/**
 *  加载弹框视图的动画
 *
 */
+ (void)setCAKeyframeAnimation:(UIView *)view;


/**
 *  MD5加密
 *
 *  @param str 原始数据
 *
 *  @return 加密数据
 */
+(NSString *)MD5:(NSString *)str;

@end
