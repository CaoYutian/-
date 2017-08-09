//
//  AppMacro.h
//  YQW
//
//  Created by Sunshine on 2017/5/9.
//  Copyright © 2017年 Sunshine. All rights reserved.
//

#ifndef AppMacro_h
#define AppMacro_h

/**
 *  一些公共属性define
 */

//----------------------------------- 网络环境设置 ------------------------------------
//默认是正式环境  上线必需注释这两项  优先选择DEBUG的环境

// 设置测试环境
#define APP_DEBUG

// 设置预发环境
//#define APP_PRERELEASE

//----------------------------------- 是否会打印log ------------------------------------
#if defined APP_DEBUG

#define APP_SHOW_LOG_DEBUG

#elif defined APP_PRERELEASE

#define APP_SHOW_LOG_DEBUG

#else

#endif



#ifdef APP_SHOW_LOG_DEBUG
#define NSLog(...)  NSLog(__VA_ARGS__)
#define DLog(fmt, ...)  NSLog((@"[File:%@][Line: %d]%s " fmt),[[NSString stringWithUTF8String:__FILE__] lastPathComponent], __LINE__, __PRETTY_FUNCTION__, ##__VA_ARGS__)
#else
#define NSLog(...)
#define DLog(...)
#endif


#define kAppDelegate ((AppDelegate *)[UIApplication sharedApplication].delegate)
#define CYT_SYSTEM_VERSION   [[[UIDevice currentDevice] systemVersion] floatValue] //系统版本号
#define CYTAppVersion [[[NSBundle mainBundle] infoDictionary] objectForKey:@"CFBundleShortVersionString"]

#define WS(weakSelf)  __weak __typeof(&*self)weakSelf = self


typedef void (^VoidBlock)();

#define userManager [UserManager sharedInstance]
#define locationManager [LocationManager sharedInstance]


//字符串是否为空
#define CYTStringIsEmpty(str) ([str isKindOfClass:[NSNull class]] || str == nil || [str length] < 1 ? YES : NO )
//数组是否为空
#define CYTArrayIsEmpty(array) (array == nil || [array isKindOfClass:[NSNull class]] || array.count == 0)
//字典是否为空
#define CYTDictIsEmpty(dic) (dic == nil || [dic isKindOfClass:[NSNull class]] || dic.allKeys == 0)
//是否是空对象
#define CYTObjectIsEmpty(_object) (_object == nil \
|| [_object isKindOfClass:[NSNull class]] \
|| ([_object respondsToSelector:@selector(length)] && [(NSData *)_object length] == 0) \
|| ([_object respondsToSelector:@selector(count)] && [(NSArray *)_object count] == 0))


#endif /* AppMacro_h */
