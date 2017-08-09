//
//  ServerMacro.h
//  YQW
//
//  Created by Sunshine on 2017/5/9.
//  Copyright © 2017年 Sunshine. All rights reserved.
//

#ifndef ServerMacro_h
#define ServerMacro_h


#if defined APP_DEBUG

//-----------------------------------  测试环境  ------------------------------------
#define Service_Address     @"http://222.249.239.5:8000/yuandongli/"

#else

//-----------------------------------  生产环境  ------------------------------------
#define Service_Address     @"http://222.249.239.5:8000/yuandongli/"


#endif

#define BaseUrl     Service_Address@""

//--------------------- common---------------------
#define Version_Url                     @"/noa/version"             //版本更新
#define Login_Url                       @"index.php/Api/Loginapi/login"


//--------------------- 首页---------------------
#define CXJK_Home                       @"index.php/Api/Index/index"   //储蓄监控
#define CXJK_Home_detail                @"index.php/Api/Index/detail"  //储蓄详情
#define CXJK_Home_detail_EAmount        @"index.php/Api/Index/editvl"  //储蓄详情修改预估用量
#define Contrast_index                  @"index.php/Api/Contrast/index"//用量对比
#define Caigouduizhang_index            @"index.php/Api/Caigouduizhang/index"//采购对账
#define Caigouduizhang_save             @"index.php/Api/Caigouduizhang/save" //采购提交

//--------------------- 上传榜单 ---------------------
#define Photo_upload                    @"index.php/Api/Photo/upload"  //上传榜单




//--------------------- 个人中心---------------------
#define Logout_Url                           @""



#endif /* ServerMacro_h */
