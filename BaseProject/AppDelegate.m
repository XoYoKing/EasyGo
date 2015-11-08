//
//  AppDelegate.m
//  BaseProject
//
//  Created by jiyingxin on 15/10/21.
//  Copyright © 2015年 Tarena. All rights reserved.
//

#import "AppDelegate.h"
#import "AppDelegate+Category.h"
#import "TripNetManager.h"
#import "UMSocial.h"
#import "MobClick.h"
#import "MobClickSocialAnalytics.h"
@interface AppDelegate ()

@end

@implementation AppDelegate

- (BOOL)application:(UIApplication *)application handleOpenURL:(NSURL *)url
{
    return  [UMSocialSnsService handleOpenURL:url];
}

- (BOOL)application:(UIApplication *)application
            openURL:(NSURL *)url
  sourceApplication:(NSString *)sourceApplication
         annotation:(id)annotation
{
    return  [UMSocialSnsService handleOpenURL:url];
}


- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions {
    // Override point for customization after application launch.
    [self initializeWithApplication:application];
    //1.背景色
    [[UINavigationBar appearance] setBarTintColor:kRGBAColor(21, 94, 228,0.6)];
    //2.设置背景图
    //[[UINavigationBar appearance] setBackgroundImage:[UIImage imageNamed:@"NavigationBarDefault"] forBarMetrics:UIBarMetricsDefault];
    //[[UINavigationBar appearance]setBackgroundImage:[UIImage imageNamed:@"NavigationBarLandscapePhone"] forBarMetrics:UIBarMetricsLandscapePhone];
    //3.设置按钮上文字的颜色
    [[UINavigationBar appearance] setTintColor:[UIColor whiteColor]];
    //4.设置有导航栏时，状态栏的颜色风格
    [[UINavigationBar appearance] setBarStyle:UIBarStyleBlack];
    //5.设置导航栏返回按钮的箭头样式
    [[UINavigationBar appearance] setBackIndicatorImage:[UIImage imageNamed:@"arrow-left.png"]];
    
    	

//友盟分享
    [UMSocialData setAppKey:@"563efdb8e0f55a78c7000f47"];
    [UMSocialConfig hiddenNotInstallPlatforms:@[UMShareToQQ, UMShareToQzone, UMShareToWechatSession, UMShareToWechatTimeline]];
//注册友盟分析
    [MobClick startWithAppkey:@"563efdb8e0f55a78c7000f47" reportPolicy:BATCH channelId:nil];
    
    
    return YES;
}

@end
