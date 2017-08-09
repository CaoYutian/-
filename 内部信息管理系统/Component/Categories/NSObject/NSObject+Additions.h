//
//  NSObject+Additions.h
//  内部信息管理系统
//
//  Created by Sunshine on 2017/7/10.
//  Copyright © 2017年 Sunshine. All rights reserved.
//

#import <Foundation/Foundation.h>

NSString* safeString(id obj);
NSNumber* safeNumber(id obj);

@interface NSObject (Additions)

- (void)performBlock:(void (^)(void))block afterDelay:(NSTimeInterval)delay;
@end
