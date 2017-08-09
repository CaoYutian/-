//
//  NSObject+Additions.m
//  内部信息管理系统
//
//  Created by Sunshine on 2017/7/10.
//  Copyright © 2017年 Sunshine. All rights reserved.
//

#import "NSObject+Additions.h"

@implementation NSObject (Additions)

NSString* safeString(id obj) {
    return [obj isKindOfClass:[NSObject class]]?[NSString stringWithFormat:@"%@",obj]:@"";
}

NSNumber* safeNumber(id obj) {
    NSNumber *result=[NSNumber numberWithInt:0];
    if([obj isKindOfClass:[NSNumber class]])
    {
        NSDecimalNumber *decimalNumber = [[NSDecimalNumber alloc] initWithString:[NSString stringWithFormat:@"%f",[(NSNumber *)obj doubleValue]]];
        return decimalNumber;
        
    } else if ([obj isKindOfClass:[NSString class]]) {
        NSDecimalNumber *decimalNumber = [[NSDecimalNumber alloc] initWithString:[NSString stringWithFormat:@"%f",[(NSString *)obj doubleValue]]];
        return decimalNumber;
    }
    return result;
}

- (void)performBlock:(void (^)(void))block
          afterDelay:(NSTimeInterval)delay
{
    [self performSelector:@selector(fireBlockAfterDelay:)
               withObject:block
               afterDelay:delay];
}

- (void)fireBlockAfterDelay:(void (^)(void))block {
    block();
}
@end
