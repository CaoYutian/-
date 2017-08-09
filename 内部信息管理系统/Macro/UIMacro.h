//
//  UIMacro.h
//  YQW
//
//  Created by Sunshine on 2017/5/9.
//  Copyright © 2017年 Sunshine. All rights reserved.
//

#ifndef UIMacro_h
#define UIMacro_h

//RGBP生产UIColor对象
#define RGBA(r,g,b,a)                [UIColor colorWithRed:(float)r/255.0f green:(float)g/255.0f blue:(float)b/255.0f alpha:a]

#define NavigationBarBackgroundColor RGBA(72,152,214,1.0)        //主色调
#define MainRedColor                 RGBA(223, 61, 62, 1.0)     //主背景色
#define MainBackgroundColor          RGBA(242, 242, 242, 1.0)   //主红色调
#define BLACKCOLOR                  [UIColor blackColor]
#define WHITECOLOR                  [UIColor whiteColor]
#define COLOR_BG_COVER              [UIColor colorWithWhite:0 alpha:0.4]

#define MARGIN_SPACE    10


#define FONT_LARGE      ([[UIDevice currentDevice].systemVersion floatValue] >= 9.0)?[UIFont fontWithName:@"STHeitiSC-Light" size:18]:\
[UIFont systemFontOfSize:18]
#define FONT_NORMAL     ([[UIDevice currentDevice].systemVersion floatValue] >= 9.0)?[UIFont fontWithName:@"STHeitiSC-Light" size:14]:\
[UIFont systemFontOfSize:14]
#define FONT_MID        ([[UIDevice currentDevice].systemVersion floatValue] >= 9.0)?[UIFont fontWithName:@"STHeitiSC-Light" size:12]:\
[UIFont systemFontOfSize:12]
#define FONT_SMALL      ([[UIDevice currentDevice].systemVersion floatValue] >= 9.0)?[UIFont fontWithName:@"STHeitiSC-Light" size:10]:\
[UIFont systemFontOfSize:12]
#define FONT(a)         ([[UIDevice currentDevice].systemVersion floatValue] >= 9.0)?[UIFont fontWithName:@"STHeitiSC-Light" size:a]:\
[UIFont systemFontOfSize:a]

#define CYTMainScreen        [UIScreen mainScreen].bounds   //屏幕尺寸
#define CYTMainScreen_HEIGHT CYTMainScreen.size.height      //屏幕高度
#define CYTMainScreen_WIDTH  CYTMainScreen.size.width       //屏幕宽度

#define FitwidthRealValue(value) ((value) / 360.0f * CYTMainScreen_WIDTH)
#define FitheightRealValue(value) ((value) / 640.0f * CYTMainScreen_HEIGHT)

#define SizeScale ((640.0f > CYTMainScreen_HEIGHT) ? CYTMainScreen_HEIGHT/640.0f : 1)
#define FitFont(value) [UIFont systemFontOfSize:value * SizeScale]

#define IMAGENAMED(imageStr) [UIImage imageNamed:imageStr]  


#endif /* UIMacro_h */
