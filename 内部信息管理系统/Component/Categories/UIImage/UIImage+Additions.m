//
//  UIImage+Additions.m
//  内部信息管理系统
//
//  Created by Sunshine on 2017/7/11.
//  Copyright © 2017年 Sunshine. All rights reserved.
//

#import "UIImage+Additions.h"

@implementation UIImage (Additions)

+ (UIImage *)createImageWithColor:(UIColor *)color
{
    CGRect rect = CGRectMake(0.0f, 0.0f, 1.0f, 1.0f);
    UIGraphicsBeginImageContext(rect.size);
    CGContextRef context = UIGraphicsGetCurrentContext();
    CGContextSetFillColorWithColor(context, [color CGColor]);
    CGContextFillRect(context, rect);
    UIImage *theImage = UIGraphicsGetImageFromCurrentImageContext();
    UIGraphicsEndImageContext();
    return theImage;
}

+(UIImage *)imageCompressForImage:(UIImage *)sourceImage targetSize:(CGSize)targetSize
{
    UIGraphicsBeginImageContext(targetSize);
    [sourceImage drawInRect:CGRectMake(0,0,targetSize.width, targetSize.height)];
    UIImage* newImage = UIGraphicsGetImageFromCurrentImageContext();
    UIGraphicsEndImageContext();
    return newImage;
}

+(NSData *)imageJPEGRepresentationForImage:(UIImage *)sourceImage maxSize:(NSInteger)imageDataSize
{
    CGFloat compressionQuality = 1.0;
    NSData *imageData = UIImageJPEGRepresentation(sourceImage,compressionQuality);
    UIImage *result = sourceImage;
    int times = 0;
    while (imageData.length > imageDataSize) {
        if (times>2) {
            compressionQuality -= 0.5;
            times = 0;
        } else {
            compressionQuality -= 0.1;
        }
        if (compressionQuality<0.1) {
            result = [self imageCompressForImage:result targetSize:CGSizeMake(sourceImage.size.width*0.9, sourceImage.size.height*0.9)];
        }
        imageData = UIImageJPEGRepresentation(result, compressionQuality);
        result = [UIImage imageWithData:imageData];
        times++;
    }
    return imageData;
}

@end
