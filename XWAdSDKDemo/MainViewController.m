//
//  MainViewController.m
//  XWAdSDKDemo
//
//  Created by laole918 on 2021/4/27.
//

#import "MainViewController.h"
#import "ConfigViewController.h"
#import "XWSplashViewController.h"
#import "XWInterstitialViewController.h"
#import "XWRewardVideoViewController.h"
#import "XWBannerViewController.h"
#import "XWNativeViewController.h"
#import "XWNativeExpressViewController.h"
#import "XWNoticeViewController.h"
#import "XWFullScreenVideoViewController.h"
#import "XWDrawVideoViewController.h"
#import "XWContentPageViewController.h"
#import "XWEntryElementViewController.h"
#import <XWAdSDK/XWAdSDK.h>
#import "NSBundle+changeBundleId.h"

@interface MainViewController ()

@end

@implementation MainViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    [self setTitle:@"XWAdSDKDemo"];
    
    UIScrollView *layout = [[UIScrollView alloc] init];
    layout.frame = self.view.bounds;
    [self.view addSubview:layout];
    CGFloat y = -50;
    {
        UIButton * button = [UIButton buttonWithType:UIButtonTypeRoundedRect];
        [button.layer setCornerRadius:10.0];
        button.backgroundColor = [UIColor whiteColor];
        button.frame = CGRectMake(10, y += 60, self.view.bounds.size.width - 20, 50);
        [button setTitle:NSLocalizedString(@"Config", nil) forState:UIControlStateNormal];
        [button setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
        [button setTitleColor:[UIColor grayColor] forState:UIControlStateFocused];
        [button addTarget:self action:@selector(clickBtnConfig) forControlEvents:UIControlEventTouchUpInside];
        [layout addSubview:button];
    }
    {
        NSDictionary *infoDictionary = [[NSBundle mainBundle] infoDictionary];
        NSString *appVersion = [infoDictionary objectForKey:@"CFBundleShortVersionString"];
        NSString *appVersionCode = [infoDictionary objectForKey:@"CFBundleVersion"];
        NSUserDefaults *defaults =[NSUserDefaults standardUserDefaults];
        NSString *userId = [defaults objectForKey:@"userId"];
        NSString *appId = [defaults objectForKey:@"appId"];
//        NSString *fakeBundleId = [defaults objectForKey:@"fakeBundleId"];
        NSString *fakeBundleId = [NSBundle mainBundle].nowBundleId ? [NSBundle mainBundle].nowBundleId : [NSBundle mainBundle].orgBundleId;
        NSString * log = [NSString stringWithFormat:@"demo version: %@(%@)\nsdk version: %@(%d)\nappId: %@\nuserId: %@\n%@: %@", appVersion, appVersionCode, [XWAdSDKConfig sdkVersion], (int)XWAdSDKVersionNumber, appId, userId, NSLocalizedString(@"fakeBundleId", nil), fakeBundleId];
        UITextView *logText = [[UITextView alloc] init];
        logText.textColor = UIColor.whiteColor;
        logText.backgroundColor = UIColor.blackColor;
        logText.text = log;
        logText.editable = NO;
        logText.layoutManager.allowsNonContiguousLayout = NO;
        [logText sizeToFit];
        logText.frame = CGRectMake(10, y += 60, self.view.bounds.size.width - 20, logText.bounds.size.height);
        [layout addSubview:logText];
        y += logText.bounds.size.height - 50;
    }
    {
        UIButton * button = [UIButton buttonWithType:UIButtonTypeRoundedRect];
        [button.layer setCornerRadius:10.0];
        button.backgroundColor = [UIColor whiteColor];
        button.frame = CGRectMake(10, y += 60, self.view.bounds.size.width - 20, 50);
        [button setTitle:NSLocalizedString(@"Splash", nil) forState:UIControlStateNormal];
        [button setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
        [button setTitleColor:[UIColor grayColor] forState:UIControlStateFocused];
        [button addTarget:self action:@selector(clickBtnSplash) forControlEvents:UIControlEventTouchUpInside];
        [layout addSubview:button];
    }
    {
        UIButton * button = [UIButton buttonWithType:UIButtonTypeRoundedRect];
        [button.layer setCornerRadius:10.0];
        button.backgroundColor = [UIColor whiteColor];
        button.frame = CGRectMake(10, y += 60, self.view.bounds.size.width - 20, 50);
        [button setTitle:NSLocalizedString(@"Interstitial", nil) forState:UIControlStateNormal];
        [button setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
        [button setTitleColor:[UIColor grayColor] forState:UIControlStateFocused];
        [button addTarget:self action:@selector(clickBtnInterstitial) forControlEvents:UIControlEventTouchUpInside];
        [layout addSubview:button];
    }
    {
        UIButton * button = [UIButton buttonWithType:UIButtonTypeRoundedRect];
        [button.layer setCornerRadius:10.0];
        button.backgroundColor = [UIColor whiteColor];
        button.frame = CGRectMake(10, y += 60, self.view.bounds.size.width - 20, 50);
        [button setTitle:NSLocalizedString(@"RewardVideo", nil) forState:UIControlStateNormal];
        [button setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
        [button setTitleColor:[UIColor grayColor] forState:UIControlStateFocused];
        [button addTarget:self action:@selector(clickBtnRewardVideo) forControlEvents:UIControlEventTouchUpInside];
        [layout addSubview:button];
    }
    {
        UIButton * button = [UIButton buttonWithType:UIButtonTypeRoundedRect];
        [button.layer setCornerRadius:10.0];
        button.backgroundColor = [UIColor whiteColor];
        button.frame = CGRectMake(10, y += 60, self.view.bounds.size.width - 20, 50);
        [button setTitle:NSLocalizedString(@"Native", nil) forState:UIControlStateNormal];
        [button setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
        [button setTitleColor:[UIColor grayColor] forState:UIControlStateFocused];
        [button addTarget:self action:@selector(clickBtnNative) forControlEvents:UIControlEventTouchUpInside];
        [layout addSubview:button];
    }
    {
        UIButton * button = [UIButton buttonWithType:UIButtonTypeRoundedRect];
        [button.layer setCornerRadius:10.0];
        button.backgroundColor = [UIColor whiteColor];
        button.frame = CGRectMake(10, y += 60, self.view.bounds.size.width - 20, 50);
        [button setTitle:NSLocalizedString(@"NativeExpress", nil) forState:UIControlStateNormal];
        [button setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
        [button setTitleColor:[UIColor grayColor] forState:UIControlStateFocused];
        [button addTarget:self action:@selector(clickBtnNativeExpress) forControlEvents:UIControlEventTouchUpInside];
        [layout addSubview:button];
    }
    {
        UIButton * button = [UIButton buttonWithType:UIButtonTypeRoundedRect];
        [button.layer setCornerRadius:10.0];
        button.backgroundColor = [UIColor whiteColor];
        button.frame = CGRectMake(10, y += 60, self.view.bounds.size.width - 20, 50);
        [button setTitle:NSLocalizedString(@"Banner", nil) forState:UIControlStateNormal];
        [button setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
        [button setTitleColor:[UIColor grayColor] forState:UIControlStateFocused];
        [button addTarget:self action:@selector(clickBtnBannerView) forControlEvents:UIControlEventTouchUpInside];
        [layout addSubview:button];
    }
    {
        UIButton * button = [UIButton buttonWithType:UIButtonTypeRoundedRect];
        [button.layer setCornerRadius:10.0];
        button.backgroundColor = [UIColor whiteColor];
        button.frame = CGRectMake(10, y += 60, self.view.bounds.size.width - 20, 50);
        [button setTitle:NSLocalizedString(@"Notice", nil) forState:UIControlStateNormal];
        [button setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
        [button setTitleColor:[UIColor grayColor] forState:UIControlStateFocused];
        [button addTarget:self action:@selector(clickBtnNotice) forControlEvents:UIControlEventTouchUpInside];
        [layout addSubview:button];
    }
    {
        UIButton * button = [UIButton buttonWithType:UIButtonTypeRoundedRect];
        [button.layer setCornerRadius:10.0];
        button.backgroundColor = [UIColor whiteColor];
        button.frame = CGRectMake(10, y += 60, self.view.bounds.size.width - 20, 50);
        [button setTitle:NSLocalizedString(@"FullScreenVideo", nil) forState:UIControlStateNormal];
        [button setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
        [button setTitleColor:[UIColor grayColor] forState:UIControlStateFocused];
        [button addTarget:self action:@selector(clickBtnFullScreenVideo) forControlEvents:UIControlEventTouchUpInside];
        [layout addSubview:button];
    }
    {
        UIButton * button = [UIButton buttonWithType:UIButtonTypeRoundedRect];
        [button.layer setCornerRadius:10.0];
        button.backgroundColor = [UIColor whiteColor];
        button.frame = CGRectMake(10, y += 60, self.view.bounds.size.width - 20, 50);
        [button setTitle:NSLocalizedString(@"DrawVideo", nil) forState:UIControlStateNormal];
        [button setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
        [button setTitleColor:[UIColor grayColor] forState:UIControlStateFocused];
        [button addTarget:self action:@selector(clickBtnDrawVideo) forControlEvents:UIControlEventTouchUpInside];
        [layout addSubview:button];
    }
    {
        UIButton * button = [UIButton buttonWithType:UIButtonTypeRoundedRect];
        [button.layer setCornerRadius:10.0];
        button.backgroundColor = [UIColor whiteColor];
        button.frame = CGRectMake(10, y += 60, self.view.bounds.size.width - 20, 50);
        [button setTitle:NSLocalizedString(@"ContentPage", nil) forState:UIControlStateNormal];
        [button setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
        [button setTitleColor:[UIColor grayColor] forState:UIControlStateFocused];
        [button addTarget:self action:@selector(clickBtnContentPage) forControlEvents:UIControlEventTouchUpInside];
        [layout addSubview:button];
    }
    {
        UIButton * button = [UIButton buttonWithType:UIButtonTypeRoundedRect];
        [button.layer setCornerRadius:10.0];
        button.backgroundColor = [UIColor whiteColor];
        button.frame = CGRectMake(10, y += 60, self.view.bounds.size.width - 20, 50);
        [button setTitle:NSLocalizedString(@"EntryElement", nil) forState:UIControlStateNormal];
        [button setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
        [button setTitleColor:[UIColor grayColor] forState:UIControlStateFocused];
        [button addTarget:self action:@selector(clickBtnEntryElement) forControlEvents:UIControlEventTouchUpInside];
        [layout addSubview:button];
    }
    layout.contentSize = CGSizeMake(0, y + 60);
}

- (void)clickBtnConfig {
    ConfigViewController *vc = [[ConfigViewController alloc] init];
    [self.navigationController pushViewController:vc animated:YES];
}

- (void)clickBtnSplash {
    XWSplashViewController *vc = [[XWSplashViewController alloc] init];
    [self.navigationController pushViewController:vc animated:YES];
}

- (void)clickBtnInterstitial {
    XWInterstitialViewController *vc = [[XWInterstitialViewController alloc] init];
    [self.navigationController pushViewController:vc animated:YES];
}

- (void)clickBtnRewardVideo {
    XWRewardVideoViewController *vc = [[XWRewardVideoViewController alloc] init];
    [self.navigationController pushViewController:vc animated:YES];
}

- (void)clickBtnNative {
    XWNativeViewController *vc = [[XWNativeViewController alloc] init];
    [self.navigationController pushViewController:vc animated:YES];
}

- (void)clickBtnNativeExpress {
    XWNativeExpressViewController *vc = [[XWNativeExpressViewController alloc] init];
    [self.navigationController pushViewController:vc animated:YES];
}

- (void)clickBtnBannerView {
    XWBannerViewController *vc = [[XWBannerViewController alloc] init];
    [self.navigationController pushViewController:vc animated:YES];
}

- (void)clickBtnNotice {
    XWNoticeViewController *vc = [[XWNoticeViewController alloc] init];
    [self.navigationController pushViewController:vc animated:YES];
}

- (void)clickBtnFullScreenVideo {
    XWFullScreenVideoViewController *vc = [[XWFullScreenVideoViewController alloc] init];
    [self.navigationController pushViewController:vc animated:YES];
}

- (void)clickBtnDrawVideo {
    XWDrawVideoViewController *vc = [[XWDrawVideoViewController alloc] init];
    [self.navigationController pushViewController:vc animated:YES];
}

- (void)clickBtnContentPage {
    XWContentPageViewController *vc = [[XWContentPageViewController alloc] init];
    [self.navigationController pushViewController:vc animated:YES];
}

- (void)clickBtnEntryElement {
    XWEntryElementViewController *vc = [[XWEntryElementViewController alloc] init];
    [self.navigationController pushViewController:vc animated:YES];
}

@end
