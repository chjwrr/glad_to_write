//
//  AppDelegate.m
//  ModelProduct
//
//  Created by chj on 15/12/13.
//  Copyright (c) 2015年 chj. All rights reserved.
//

#import "AppDelegate.h"
#import "KeyboardManager.h"
#import "BaseNavigationController.h"
#import "HomeViewController.h"


#import "YJPasswordView.h"

//Touch ID 开发
#import <LocalAuthentication/LocalAuthentication.h>

@interface AppDelegate ()

@property (nonatomic,strong)UIView *touchIDView;

@end

@implementation AppDelegate

//键盘设置
- (void)KeyboardSetting {
    [IQKeyboardManager sharedManager].enableAutoToolbar = NO;
    [IQKeyboardManager sharedManager].enable=NO;
}

//主题
- (void)appKeyColor {
    
    //主题1  背景颜色 FAFAD2 浅黄      主页字体、线颜色 EEAD0E
    //主题2  背景颜色 F0FFF0 浅绿      主页字体、线颜色 E9967A
    //主题3  背景颜色 EED2EE 浅粉      主页字体、线颜色 EE7942
    //主题4  背景颜色 FFC1C1 浅紫      主页字体、线颜色 63B8FF
    //主题5  背景颜色 87CEFA 浅蓝      主页字体、线颜色 71C671
    //主题6  背景颜色 EBEBEB 浅灰      主页字体、线颜色 ABABAB
    
    
    if ([kFormatterSring(kgetDefaultValueForKey(kuserTheme)) isEmpty]) {
        //默认主题1
        ksetDefaultValueForKey(@"theme1", kuserTheme);
    }
    
    if ([kFormatterSring(kgetDefaultValueForKey(kuserFontSizeName)) isEmpty]) {
        //默认发布字体大小
        ksetDefaultValueForKey(@"15", kuserFontSizeName);
    }
    
    if ([kFormatterSring(kgetDefaultValueForKey(kuserFontSpaceHeight)) isEmpty]) {
        //默认发布字体行间距
        ksetDefaultValueForKey(@"5", kuserFontSpaceHeight);
    }
    
    if ([kFormatterSring(kgetDefaultValueForKey(kuserFontSpaceWidth)) isEmpty]) {
        //默认发布字体字间距
        ksetDefaultValueForKey(@"0", kuserFontSpaceWidth);
    }
    
    if ([kFormatterSring(kgetDefaultValueForKey(kuserFontName)) isEmpty]) {
        //默认发布字体字间距
        ksetDefaultValueForKey(@"Weibei SC", kuserFontName);
        ksetDefaultValueForKey(@"魏碑简体", kuserFontNameChina);
    }
    
    if (![kFormatterSring(kgetDefaultValueForKey(kuserTouchID)) isEqualToString:@"1"]) {
        //默认Touch ID 验证 关闭状态
        ksetDefaultValueForKey(@"0", kuserTouchID);
    }
    
    if (![kFormatterSring(kgetDefaultValueForKey(kuserOpenPassword)) isEqualToString:@"1"]) {
        //默认 数字密码 验证 关闭状态
        ksetDefaultValueForKey(@"0", kuserOpenPassword);
    }
}

/**
 *  Touch ID 背景
 */
- (UIView *)touchIDView {
    if (!_touchIDView) {
        _touchIDView=[[UIView alloc]initWithFrame:CGRectMake(0, 0, kSCREEN_WIDTH, kSCREEN_HEIGHT)];
        _touchIDView.backgroundColor=kColorHexString(kuserThemeBgColor);
        
        _touchIDView.userInteractionEnabled=YES;
        UITapGestureRecognizer *tap=[[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(TouchIDCheck)];
        [_touchIDView addGestureRecognizer:tap];

        
        UIImageView *imageV=[[UIImageView alloc]initWithFrame:CGRectMake((kSCREEN_WIDTH-60)/2, (kSCREEN_HEIGHT-60)/2, 60, 60)];
        imageV.image=kImageName(@"touchIDImage");
        [_touchIDView addSubview:imageV];
        
        UILabel *lab=[[UILabel alloc]initWithFrame:CGRectMake(0, imageV.y+imageV.height+10, kSCREEN_WIDTH, 20)];
        lab.textAlignment=NSTextAlignmentCenter;
        lab.textColor=kColorHexString(kuserThemeFontColor);
        lab.font=kSYS_FONTNAME(kFormatterSring(kgetDefaultValueForKey(kuserFontName)), 14);
        [_touchIDView addSubview:lab];
        lab.text=@"点击屏幕进行指纹验证";
        
    }
    return _touchIDView;
}


- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions {
    
    [self configSetting];

    [[UIApplication sharedApplication]setStatusBarStyle:UIStatusBarStyleLightContent animated:YES];
    
    self.window=[[UIWindow alloc]initWithFrame:[UIScreen mainScreen].bounds];
    self.window.backgroundColor=[UIColor whiteColor];

    self.window.rootViewController=[[HomeViewController alloc]init];
    
    [self.window makeKeyAndVisible];
    
    return YES;
}

- (void)configSetting {
    
    //缓存目录
    [[FileManager shareIntance] creatMyWayFilePath];
    
    //键盘
    [self KeyboardSetting];
    
    //主题
    [self appKeyColor];
    
    //验证用户密码
    [self unlockWithPassword];
}

- (void)unlockWithPassword {
    //判断是否开启了Touch ID解锁 (iOS 8 以后使用Touch ID)
    
    if ([kFormatterSring(kgetDefaultValueForKey(kuserTouchID)) isEqualToString:@"1"]) {
        //开启了 Touch ID解锁
        if (kAPP_System_Version >= 8.0) {
            //验证Touch ID
        
            dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(0.2 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
                [self.window addSubview:self.touchIDView];
                
                [self TouchIDCheck];
            });
            
        }else{
            //进入主程序
            
        }
    }else {
        //判断是否开启了 数字密码解锁
        if ([kFormatterSring(kgetDefaultValueForKey(kuserOpenPassword)) isEqualToString:@"1"]) {
            //验证数字密码
            
            dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(0.2 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
                [[YJPasswordView shareInstance] showIsWritePsd:NO];
            });
            
        }else{
            //没有 密码。进入主程序
            
        }
    }

}

/**
 *  Touch ID 验证
 */
- (void)TouchIDCheck {
    
    LAContext *context=[[LAContext alloc]init];
    
    NSError *error=nil;
    
    NSString* result = @"悦记，简单记";

    //判断是否支持Touch ID
    if ([context canEvaluatePolicy:LAPolicyDeviceOwnerAuthenticationWithBiometrics error:&error]) {
        //支持
        [context evaluatePolicy:LAPolicyDeviceOwnerAuthenticationWithBiometrics localizedReason:result reply:^(BOOL success, NSError * _Nullable error) {
            if (success) {
                //成功

                //主线程处理，不然会很慢很慢
              dispatch_async(dispatch_get_main_queue(), ^{
                  [self.touchIDView removeFromSuperview];
                  self.touchIDView = nil;
 
              });
                
            }else{

                switch (error.code) {
                    case LAErrorSystemCancel:
                    {
                        //切换到其他APP，系统取消验证Touch ID
                        break;
                    }
                    case LAErrorUserCancel:
                    {
                        //用户取消验证Touch ID
                        
                        break;
                    }
                    case LAErrorUserFallback:
                    {
                        [[NSOperationQueue mainQueue] addOperationWithBlock:^{
                            //用户选择输入密码，切换主线程处理
                        }];
                        break;
                    }
                    default:
                    {
                        [[NSOperationQueue mainQueue] addOperationWithBlock:^{
                            //其他情况，切换主线程处理
                        }];
                    }
                        break;
                    
                }
                
            }
        }];
    }
}


/**
 *  当有电话进来或者锁屏，这时你的应用程会挂起，在这时，UIApplicationDelegate委托会收到通知，调用 applicationWillResignActive 方法，你可以重写这个方法，做挂起前的工作，比如关闭网络，保存数据。
 *
 */
- (void)applicationWillResignActive:(UIApplication *)application {
    // Sent when the application is about to move from active to inactive state. This can occur for certain types of temporary interruptions (such as an incoming phone call or SMS message) or when the user quits the application and it begins the transition to the background state.
    // Use this method to pause ongoing tasks, disable timers, and throttle down OpenGL ES frame rates. Games should use this method to pause the game.
}

/**
 *  进入后台
 *
 */
- (void)applicationDidEnterBackground:(UIApplication *)application {
    // Use this method to release shared resources, save user data, invalidate timers, and store enough application state information to restore your application to its current state in case it is terminated later.
    // If your application supports background execution, this method is called instead of applicationWillTerminate: when the user quits.
}

/**
 *  这个方法是从后台将要进入前台时运行的
 *
 */
- (void)applicationWillEnterForeground:(UIApplication *)application {
    // Called as part of the transition from the background to the inactive state; here you can undo many of the changes made on entering the background.
    //验证用户密码
    [self unlockWithPassword];
}

/**
 *  进入前台
 *
 */
- (void)applicationDidBecomeActive:(UIApplication *)application {
    // Restart any tasks that were paused (or not yet started) while the application was inactive. If the application was previously in the background, optionally refresh the user interface.
   
   

}

/**
 *  当用户按下按钮，或者关机，程序都会被终止。当一个程序将要正常终止时会调用 applicationWillTerminate方法。但是如果长主按钮强制退出 ，则不会调用该方法。这个方法该执行剩下的清理工作，比如所有的连接都能正常关闭，并在程序退出前执行任何其他的必要的工作
 *
 */
- (void)applicationWillTerminate:(UIApplication *)application {
    // Called when the application is about to terminate. Save data if appropriate. See also applicationDidEnterBackground:.
}


@end
