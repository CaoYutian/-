//
//  PersonalCenterVC.m
//  内部信息管理系统
//
//  Created by Sunshine on 2017/7/12.
//  Copyright © 2017年 Sunshine. All rights reserved.
//

#import "PersonalCenterVC.h"

@interface PersonalCenterVC ()

@end

@implementation PersonalCenterVC

- (void)viewDidLoad {
    [super viewDidLoad];
    self.titleLabel.text = @"个人中心";
    
    UIButton *exitBtn = [CYTUtiltyHelper addbuttonWithRect:CGRectMake(FitheightRealValue(20), FitheightRealValue(80), CYTMainScreen_WIDTH - FitwidthRealValue(40), FitheightRealValue(40)) LabelText:@"切换账号" TextFont:FitFont(15) NormalTextColor:WHITECOLOR highLightTextColor:WHITECOLOR NormalBgColor:NavigationBarBackgroundColor highLightBgColor:NavigationBarBackgroundColor tag:300 SuperView:self.contentView buttonTarget:self Action:@selector(exitAction)];
    exitBtn.layer.cornerRadius = FitheightRealValue(20);
    exitBtn.layer.masksToBounds = YES;


}

- (void)exitAction {
    [UserManager removeLocalUserLoginInfo];
    [kAppDelegate loadLoginVC];
}

@end
