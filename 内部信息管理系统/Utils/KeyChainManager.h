//
//  KeyChainManager.h
//  内部信息管理系统
//
//  Created by Sunshine on 2017/7/27.
//  Copyright © 2017年 Sunshine. All rights reserved.
//

#import <Foundation/Foundation.h>

static NSString * const kKeyPassword = @"com.ailng.password";

@interface KeyChainManager : NSObject

+ (void)save:(NSString *)service data:(id)data;
+ (id)load:(NSString *)service;
+ (void)delete:(NSString *)service;

@end
