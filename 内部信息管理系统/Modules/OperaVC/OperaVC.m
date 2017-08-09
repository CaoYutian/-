//
//  OperaVC.m
//  内部信息管理系统
//
//  Created by Sunshine on 2017/7/24.
//  Copyright © 2017年 Sunshine. All rights reserved.
//

#import "OperaVC.h"
#import "HttpTools.h"

@interface OperaVC ()<ActionSheetViewDelegate,UITextFieldDelegate,UINavigationControllerDelegate, UIImagePickerControllerDelegate> {
    CGFloat fixelW;
    CGFloat fixelH;
    NSData *_file;
}

@property (nonatomic, strong) UIImageView *topPic;
@property (nonatomic, strong) UIView *InfoView;
@property (nonatomic, strong) UIButton *submitBtn;

@property (nonatomic, strong) UITextField *carIdTf;
@property (nonatomic, strong) UITextField *shortNameTf;
@property (nonatomic, strong) UITextField *xclTf;
@property (nonatomic, strong) NSData *imageData;
@property (nonatomic, strong) MBProgressHUD *HD;

@end

@implementation OperaVC

- (void)viewDidLoad {
    [super viewDidLoad];
    self.titleLabel.text = @"过磅单";
    
    UIButton *exitBtn = [CYTUtiltyHelper addbuttonWithRect:CGRectMake(CYTMainScreen_WIDTH - 80, 20, 60, 44) LabelText:@"退出" TextFont:FitFont(15) NormalTextColor:BLACKCOLOR highLightTextColor:BLACKCOLOR tag:1 SuperView:self.view buttonTarget:self Action:@selector(exitAction)];
    
    [self.navBar addSubview:exitBtn];

}

- (void)loadSubViews {
    
    [super loadSubViews];
    [self.contentView mas_updateConstraints:^(MASConstraintMaker *make) {
        make.edges.equalTo(self.view).insets(UIEdgeInsetsMake(0, 0, 0, 0));
    }];
    
    self.topPic = [CYTUtiltyHelper createImageViewWithFrame:CGRectMake((CYTMainScreen_WIDTH - FitwidthRealValue(260)) / 2, FitheightRealValue(20) + 64, FitwidthRealValue(260), FitheightRealValue(260)) imageName:@"photo" SuperView:self.contentView];
    
    WS(weakSelf);
    [self.topPic setTapActionWithBlock:^{
        [weakSelf chooseUplodOfPic];
    }];
    
    self.InfoView = [[UIView alloc] initWithFrame:CGRectMake(0, self.topPic.bottom + FitheightRealValue(20), CYTMainScreen_WIDTH, FitheightRealValue(153))];
    self.InfoView.backgroundColor = WHITECOLOR;
    [self.contentView addSubview:self.InfoView];
    [self createInfoInput];
    
    self.submitBtn = [CYTUtiltyHelper addbuttonWithRect:CGRectMake(FitwidthRealValue(20), self.InfoView.bottom + FitheightRealValue(20), CYTMainScreen_WIDTH - FitwidthRealValue(40), FitheightRealValue(50)) LabelText:@"提交" TextFont:FitFont(16) NormalTextColor:WHITECOLOR highLightTextColor:WHITECOLOR NormalBgColor:NavigationBarBackgroundColor highLightBgColor:NavigationBarBackgroundColor tag:500 SuperView:self.contentView buttonTarget:self Action:@selector(submitAction)];
    self.submitBtn.layer.cornerRadius = FitheightRealValue(25);
    self.submitBtn.layer.masksToBounds = YES;
}

- (void)createInfoInput {
    NSArray *titles = @[@"车牌号",@"用户名",@"卸液量"];
    NSArray *placeholders = @[@"请输入车牌号",@"请输入用户名",@"请输入卸液量"];
    
    for (int i = 0; i < 3; i ++) {
        [CYTUtiltyHelper addLabelWithFrame:CGRectMake(FitwidthRealValue(13), i * FitheightRealValue(50), FitwidthRealValue(80), FitheightRealValue(50)) LabelFont:FitFont(16) LabelTextColor:BLACKCOLOR LabelTextAlignment:NSTextAlignmentLeft SuperView:self.InfoView LabelTag:501+i LabelText:titles[i]];
        UITextField *tf = [CYTUtiltyHelper createTextFieldFrame:CGRectMake(FitwidthRealValue(93), i * FitheightRealValue(50), CYTMainScreen_WIDTH - FitwidthRealValue(106), FitheightRealValue(50)) font:FitFont(16) placeholder:placeholders[i] TextfiledTag:510 + i Delegate:self CornerRadius:0 SuperView:self.InfoView];
        tf.textAlignment = NSTextAlignmentRight;
        tf.delegate = self;
        tf.clearButtonMode = UITextFieldViewModeWhileEditing;
        tf.borderStyle = UITextBorderStyleNone;
        if (i == 0) {
            self.carIdTf = tf;
        }
        if (i == 1) {
            self.shortNameTf = tf;
        }
        if (i == 2) {
            self.xclTf = tf;
            tf.keyboardType = UIKeyboardTypeNumbersAndPunctuation;
        }
        
        UIView *line = [[UIView alloc] initWithFrame:CGRectMake(0, FitheightRealValue(51) * (i + 1), CYTMainScreen_WIDTH, FitheightRealValue(1))];
        line.backgroundColor = MainBackgroundColor;
        [self.InfoView addSubview:line];
    }
}

#pragma mark 上传图片
- (void)chooseUplodOfPic {
    ActionSheetView *alertSheetView = [[ActionSheetView alloc] initWithTitle:nil cancelButtonTitle:@"取消" destructiveButtonTitle:nil otherButtonTitles:@[@"拍照", @"从手机相册选择"] actionSheetBlock:^(NSInteger index) {
        if (index == 0) {
            //创建一个图像选择器(可以从系统相册中读取数据，可以打开相机拍照获取相机拍完的照片)
            UIImagePickerController * picker =[[UIImagePickerController alloc]init];
            //设置资源类型（相册）UIImagePickerControllerSourceTypeCamera（相机）
            [picker setSourceType:UIImagePickerControllerSourceTypeCamera];
            //设置图片可编辑
            [picker setAllowsEditing:YES];
            
            //3.将图片选择器添加到界面上
            [self presentViewController:picker animated:YES completion:^{
                picker.delegate =self;
            }];
        }else if (index == 1) {
            UIImagePickerController * picker =[[UIImagePickerController alloc]init];
            [picker setSourceType:UIImagePickerControllerSourceTypeSavedPhotosAlbum];
            [picker setAllowsEditing:YES];
            
            [self presentViewController:picker animated:YES completion:^{
                picker.delegate =self;
            }];
        }
    }];
    
    //弹出视图
    [alertSheetView show];
}

- (void)imagePickerController:(UIImagePickerController *)picker didFinishPickingMediaWithInfo:(NSDictionary<NSString *,id> *)info{
    
    //取出图片
    UIImage *image = [info objectForKey:UIImagePickerControllerOriginalImage];
    fixelW = CGImageGetWidth(image.CGImage);
    fixelH = CGImageGetHeight(image.CGImage);
    CGFloat PicProportion = fixelW / fixelH;

    self.topPic.width = FitheightRealValue(240) * PicProportion;
    self.topPic.centerX = self.view.centerX;
    
    self.topPic.image = image;
    
    [picker dismissViewControllerAnimated:YES completion:nil];
    //判断图片是不是png格式的文件
    if (UIImagePNGRepresentation(image)) {
        //返回为png图像。
        UIImage *imagenew = [self imageWithImageSimple:image scaledToSize:CGSizeMake(360, 640)];
        self.imageData = UIImagePNGRepresentation(imagenew);
    }else {
        //返回为JPEG图像。
        UIImage *imagenew = [self imageWithImageSimple:image scaledToSize:CGSizeMake(360, 640)];
        self.imageData = UIImageJPEGRepresentation(imagenew, 0.5);
    }
    
}

/**
 *  压缩图片尺寸
 *
 *  @param image   图片
 *  @param newSize 大小
 *
 *  @return 真实图片
 */
- (UIImage *)imageWithImageSimple:(UIImage*)image scaledToSize:(CGSize)newSize{
    UIGraphicsBeginImageContext(newSize);
    [image drawInRect:CGRectMake(0,0,newSize.width,newSize.height)];
    UIImage* newImage = UIGraphicsGetImageFromCurrentImageContext();
    UIGraphicsEndImageContext();
    return newImage;
}

#pragma mark 提交
- (void)submitAction {
    ActionAlertView *alertView = [[ActionAlertView alloc] initWithTitle:@"过磅单是否提交" message:@"过磅单是否提交吗?" sureBtn:@"确定" cancleBtn:@"取消"];
    alertView.resultIndex = ^(NSInteger index){
        if (index == 2) {
            [self upDateHeadIcon:self.topPic.image];
        }
    };
    [alertView showAlertView];
}

- (void)upDateHeadIcon:(UIImage *)photo {
    [self.contentView addSubview:self.HD];
    [self.HD showAnimated:YES];

    NSMutableDictionary *dict = [NSMutableDictionary dictionary];
    _file = [UIImage imageJPEGRepresentationForImage:photo maxSize:1000000];
    
    [dict setObject:self.carIdTf.text forKey:@"car_id"];
    [dict setObject:self.shortNameTf.text forKey:@"short_name"];
    [dict setObject:self.xclTf.text forKey:@"xcl"];
    [dict setObject:[UserManager sharedInstance].userData.user_id forKey:@"uid"];
    
    HttpTools *httpTool = [[HttpTools alloc] init];
    NSDictionary *newDict = [httpTool signatureParams:dict];
    
    [HttpTools POST:Photo_upload parameters:newDict imgData:_file success:^(NSURLSessionDataTask *task, id responseObject) {
        if ([responseObject[@"err"] integerValue] == 1) {
            [MBProgressHUD showMsgHUD:@"提交成功"];
        }else{
            [MBProgressHUD showMsgHUD:responseObject[@"msg"]];
        }
    } failure:^(NSURLSessionDataTask *task, NSError *error) {
        [MBProgressHUD showMsgHUD:@"提交失败"];
    }];
    [self.HD hideAnimated:YES];

}

- (void)exitAction {
    [UserManager removeLocalUserLoginInfo];
    [kAppDelegate loadLoginVC];
}

-(MBProgressHUD *)HD{
    if (!_HD) {
        _HD = [[MBProgressHUD alloc]initWithView:self.contentView];
    }
    return _HD;
}

@end
