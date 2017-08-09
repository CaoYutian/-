//
//  MBProgressHUD+Additions.m
//  内部信息管理系统
//
//  Created by Sunshine on 2017/7/10.
//  Copyright © 2017年 Sunshine. All rights reserved.
//

#import "MBProgressHUD+Additions.h"
#import <objc/runtime.h>

static MBProgressHUD  *s_progressHUD = nil;

@interface MBProgressHUD ()
@property(nonatomic,copy)NSNumber *hudCount;
@end

@implementation MBProgressHUD (Additions)

-(NSNumber *)hudCount
{
    return objc_getAssociatedObject(self,@selector(hudCount));
}

-(void)setHudCount:(NSNumber *)hudCount
{
    objc_setAssociatedObject(self,@selector(object),(id)hudCount,OBJC_ASSOCIATION_COPY_NONATOMIC);
}

+ (void)showLoadingHUD:(NSString *)aString {
    UIWindow *window = mainWindow();
    [self showLoadingHUD:aString onView:window];
}

+ (void)showLoadingHUD:(NSString *)aString onView:(UIView *)view
{
    if (!view) {
        return;
    }
    if (!s_progressHUD) {
        s_progressHUD = [[MBProgressHUD alloc] initWithView:view];
        [view addSubview:s_progressHUD];
    }else{
        s_progressHUD.hudCount = @(s_progressHUD.hudCount.integerValue+1);
    }
    s_progressHUD.removeFromSuperViewOnHide = YES;
    s_progressHUD.animationType = MBProgressHUDAnimationZoom;
    if ([aString length]>0) {
        s_progressHUD.detailsLabel.text = aString;
    }
    else s_progressHUD.detailsLabel.text = nil;
    
    //    s_progressHUD.opacity = 0.7;
    [s_progressHUD showAnimated:YES];
}

+ (void)showMsgHUD:(NSString *)aString customImage:(UIImage *)customImage
{
    UIWindow *window = mainWindow();
    if (!window) {
        return;
    }
    MBProgressHUD *progressHUD = [[MBProgressHUD alloc] initWithView:window];
    [window addSubview:progressHUD];
    progressHUD.removeFromSuperViewOnHide = YES;
    progressHUD.animationType = MBProgressHUDAnimationZoom;
    if ([aString length]>0) {
        progressHUD.detailsLabel.text = aString;
    }
    else progressHUD.detailsLabel.text = nil;
    progressHUD.detailsLabel.font = FONT_NORMAL;
    //    progressHUD.opacity = 0.7;
    progressHUD.mode = MBProgressHUDModeCustomView;
    progressHUD.customView = [[UIImageView alloc] initWithImage:customImage];
    [progressHUD showAnimated:NO];
    [progressHUD hideAnimated:YES afterDelay:0.7];
}

+ (void)showMsgHUD:(NSString *)aString duration:(CGFloat)duration touchClose:(BOOL)close{
    UIWindow *window = mainWindow();
    [self showMsgHUD:aString onView:window duration:duration touchClose:close];
}

+ (void)showMsgHUD:(NSString *)aString onView:(UIView *)view duration:(CGFloat)duration touchClose:(BOOL)close
{
    if (!view) {
        return;
    }
    MBProgressHUD *progressHUD = [MBProgressHUD showHUDAddedTo:view animated:YES];
    progressHUD.animationType = MBProgressHUDAnimationZoom;
    progressHUD.detailsLabel.text = safeString(aString);
    progressHUD.removeFromSuperViewOnHide = YES;
    //    progressHUD.opacity = 0.7;
    progressHUD.mode = MBProgressHUDModeText;
    [progressHUD showAnimated:NO];
    [progressHUD hideAnimated:YES afterDelay:duration];
    if (close) {
        [progressHUD handleClick:^(UIView *view) {
            [(MBProgressHUD*)view hideAnimated:YES];
        }];
    }
}

+ (void)showMsgHUD:(NSString *)aString
{
    [self showMsgHUD:aString duration:0.7];
}

+ (void)showMsgHUD:(NSString *)aString duration:(CGFloat)duration {
    [self showMsgHUD:aString duration:duration touchClose:NO];
}

+ (void)showMsgHUD:(NSString *)aString onView:(UIView *)view duration:(CGFloat)duration
{
    [self showMsgHUD:aString onView:view duration:duration touchClose:NO];
}

+ (void)hideLoadingHUD {
    if (s_progressHUD) {
        s_progressHUD.hudCount = @(s_progressHUD.hudCount.integerValue-1);
        if (s_progressHUD.hudCount.integerValue<1) {
            [s_progressHUD hideAnimated:YES];
            s_progressHUD = nil;
        }
    }
}

+ (void)updateLoadingHUD:(NSString*)progress {
    if (s_progressHUD) {
        s_progressHUD.detailsLabel.text = progress;
    }
}

+ (void)showLoadingHUD:(NSString *)aString duration:(CGFloat)duration {
    UIWindow *window = mainWindow();
    if (!window) {
        return;
    }
    
    [self hideLoadingHUD];
    MBProgressHUD *progressHUD = [[MBProgressHUD alloc] initWithView:window];
    [window addSubview:progressHUD];
    progressHUD.animationType = MBProgressHUDAnimationZoom;
    progressHUD.detailsLabel.text = aString;
    progressHUD.removeFromSuperViewOnHide = YES;
    //    progressHUD.opacity = 0.7;
    [progressHUD showAnimated:NO];
    [progressHUD hideAnimated:YES afterDelay:duration];
}

@end
