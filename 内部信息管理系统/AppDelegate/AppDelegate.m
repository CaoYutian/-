/**********************************************************************************
 //                尔等BUG胆敢在此造次，定将尔等灰飞烟灭
 //                            _ooOoo_
 //                           o8888888o
 //                           88" . "88
 //                           (| -_- |)
 //                            O\ = /O
 //                        ____/`---'\____
 //                      .   ' \\| |// `.
 //                       / \\||| : |||// \
 //                     / _||||| -:- |||||- \
 //                       | | \\\ - /// | |
 //                     | \_| ''\---/'' | |
 //                      \ .-\__ `-` ___/-. /
 //                   ___`. .' /--.--\ `. . __
 //                ."" '< `.___\_<|>_/___.' >'"".
 //               | | : `- \`.;`\ _ /`;.`/ - ` : | |
 //                 \ \ `-. \_ __\ /__ _/ .-` / /
 //         ======`-.____`-.___\_____/___.-`____.-'======
 //                            `=---='
 //
 //         .............................................
 //                  佛祖镇楼                  BUG辟易
 //          佛曰:
 //                  写字楼里写字间，写字间里程序员；
 //                  程序人员写程序，又拿程序换酒钱。
 //                  酒醒只在网上坐，酒醉还来网下眠；
 //                  酒醉酒醒日复日，网上网下年复年。
 //                  但愿老死电脑间，不愿鞠躬老板前；
 //                  奔驰宝马贵者趣，公交自行程序员。
 //                  别人笑我忒疯癫，我笑自己命太贱；
 //                  不见满街漂亮妹，哪个归得程序员？
 **********************************************************************************/

#import "AppDelegate.h"
#import "LoginViewController.h"
#import "OperaVC.h"
#import <AMapFoundationKit/AMapFoundationKit.h>

@interface AppDelegate ()

@end

@implementation AppDelegate

- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions {

    self.window = [[UIWindow alloc] initWithFrame:[[UIScreen mainScreen] bounds]];
    self.window.backgroundColor = WHITECOLOR;
    [self.window makeKeyAndVisible];
        
    [UserManager initWithLocalUserLoginInfo];
   if ([UserManager sharedInstance].userData.power == 1){
        [self loadMainVC];
    }else if ([UserManager sharedInstance].userData.power == 2) {
        [self loadOperaVC];
    }else {
        [self loadLoginVC];
    }
    
    //------------高德地图------------
    [[AMapServices sharedServices] setEnableHTTPS:YES];
    [AMapServices sharedServices].apiKey = GD_KEY;
    
    return YES;
}

-(void)loadLoginVC {
    LoginViewController *loginVC = [[LoginViewController alloc] init];
    self.nav = [[AppNavigationController alloc] initWithRootViewController:loginVC];
    self.nav.navigationBar.hidden = YES;
    self.window.rootViewController = loginVC;
}

-(void)loadMainVC {
    self.tabBarController = [[AppTabBarController alloc] init];
    self.nav = [[AppNavigationController alloc] initWithRootViewController:self.tabBarController];
    self.nav.navigationBar.hidden = YES;
    self.window.rootViewController = self.nav;
}

-(void)loadOperaVC {
    OperaVC *Opera = [[OperaVC alloc] init];
    self.nav = [[AppNavigationController alloc] initWithRootViewController:Opera];
    self.nav.navigationBar.hidden = YES;
    self.window.rootViewController = self.nav;
}

- (void)applicationWillResignActive:(UIApplication *)application {
    NSLog(@"程序暂停");
}

- (void)applicationDidEnterBackground:(UIApplication *)application {
    NSLog(@"程序进入后台");
}

- (void)applicationWillEnterForeground:(UIApplication *)application {
    NSLog(@"程序回到前台");
}

- (void)applicationDidBecomeActive:(UIApplication *)application {
    NSLog(@"程序激活");
}

- (void)applicationWillTerminate:(UIApplication *)application {
    NSLog(@"意外暂停");
}

@end
