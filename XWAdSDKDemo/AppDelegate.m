//
//  AppDelegate.m
//  XWAdSDKDemo
//
//  Created by laole918 on 2021/9/27.
//

#import "AppDelegate.h"
#import <XWAdSDK/XWAdSDK.h>
#import "LogoViewController.h"
#import "MainViewController.h"
#import "XWSlotID.h"
#import "NSBundle+changeBundleId.h"

@interface AppDelegate ()<XWSplashAdDelegate>

@property (nonatomic, strong) LogoViewController *logoController;
@property (nonatomic, strong) UINavigationController *rootController;
    
@property (nonatomic, strong) XWSplashAd * splashAd;
@property (nonatomic, assign) NSTimeInterval lastActiveTime;
@property (nonatomic, assign) BOOL didEnterBackground;

@end

@implementation AppDelegate


- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions {
    // Override point for customization after application launch.
    NSUserDefaults *defaults =[NSUserDefaults standardUserDefaults];
    NSString *fakeBundleId = [defaults objectForKey:@"fakeBundleId"];
    NSLog(@"fakeBundleId: %@", fakeBundleId);
    //模拟包名
    [[NSBundle mainBundle] changeBundleIdentifier:(fakeBundleId && fakeBundleId.length > 0) ? fakeBundleId : nil];
    
    self.window = [[UIWindow alloc] initWithFrame:[UIScreen mainScreen].bounds];
    self.window.backgroundColor = [UIColor grayColor];
    MainViewController *main = [[MainViewController alloc] init];
    self.rootController = [[UINavigationController alloc] initWithRootViewController:main];
    self.logoController = [[LogoViewController alloc] init];
    
    self.window.rootViewController = self.logoController;
    [self.window makeKeyAndVisible];
    
    NSString *userId = [defaults objectForKey:@"userId"];
    NSString *appId = [defaults objectForKey:@"appId"];
    
    [XWAdSDKConfig setUserId:userId];
    [XWAdSDKConfig initAppId:appId];
    
    CGRect frame = [UIScreen mainScreen].bounds;
    CGRect splashFrame = CGRectMake(0, 0, frame.size.width, frame.size.height);
    self.splashAd = [[XWSplashAd alloc] initWithFrame:splashFrame slotId:xw_splash_id viewController:self.rootController];
    self.splashAd.delegate = self;
    [self.splashAd loadAd];
    
    self.lastActiveTime = [[NSDate date] timeIntervalSince1970];
    
    NSLog(@"sdkVersion: %@", [XWAdSDKConfig sdkVersion]);
    return YES;
}

- (BOOL)application:(UIApplication *)application continueUserActivity:(nonnull NSUserActivity *)userActivity restorationHandler:(nonnull void (^)(NSArray<id<UIUserActivityRestoring>> * _Nullable))restorationHandler {
    return [XWAdSDKConfig handleOpenUniversalLink:userActivity];
}

- (void)applicationDidEnterBackground:(UIApplication *)application {
    self.didEnterBackground = YES;
}

- (void)applicationDidBecomeActive:(UIApplication *)application {
    NSTimeInterval time = [[NSDate date] timeIntervalSince1970];
    //指定一个最小展示间隔
    if (time - self.lastActiveTime >= 60 && self.didEnterBackground) {
        self.lastActiveTime = time;
        [self.splashAd loadAd];
        self.window.rootViewController = self.logoController;
    }
    self.didEnterBackground = NO;
}

#pragma mark - XWSplashAdDelegate

- (void)xw_splashAdDidLoad:(XWSplashAd *)splashAd {
    self.window.rootViewController = self.rootController;
    UIWindow *mainWindow = nil;
    if (@available(iOS 13.0, *)) {
        mainWindow = [UIApplication sharedApplication].windows.firstObject;
    } else {
        mainWindow = [UIApplication sharedApplication].keyWindow;
    }
    [self.splashAd showAdInWindow:mainWindow];
}

- (void)xw_splashAdDidFailToLoad:(XWSplashAd *)splashAd error:(NSError *)error {
    self.window.rootViewController = self.rootController;
}

- (void)xw_splashAdDidExpose:(XWSplashAd *)splashAd {
    
}

- (void)xw_splashAdDidClick:(XWSplashAd *)splashAd {

}

- (void)xw_splashAdDidClose:(XWSplashAd *)splashAd {

}

- (void)xw_splashAdLifeTime:(XWSplashAd *)splashAd time:(NSUInteger)time {
    
}

- (void)xw_splashAdDidCloseOtherController:(XWSplashAd *)splashAd {

}

@end
