//
//  UIImage+Additions.h
//  内部信息管理系统
//
//  Created by Sunshine on 2017/7/11.
//  Copyright © 2017年 Sunshine. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface UIImage (Additions)

/**
 *  根据颜色生成纯色图片
 *
 *  @param color 颜色
 *
 *  @return UIImage
 */
+ (UIImage *)createImageWithColor:(UIColor *)color;

/**
 *  压缩图片
 *
 *  @param sourceImage 原始图片
 *  @param targetSize  压缩尺寸
 *
 *  @return 压缩后的图片
 */
+(UIImage *)imageCompressForImage:(UIImage *)sourceImage targetSize:(CGSize)targetSize;

+(NSData *)imageJPEGRepresentationForImage:(UIImage *)sourceImage maxSize:(NSInteger)imageDataSize;
@end
