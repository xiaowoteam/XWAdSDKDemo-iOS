//
//  XWSplashViewController.m
//  XWAdSDKDemo
//
//  Created by laole918 on 2021/5/10.
//

#import "XWSplashViewController.h"
#import <XWAdSDK/XWAdSDK.h>
#import "XWSlotID.h"

@interface XWSplashViewController ()<XWSplashAdDelegate>

@property (nonatomic, strong) XWSplashAd * splashAd;

@end

@implementation XWSplashViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    [self setTitle:NSLocalizedString(@"Splash", nil)];
    
    self.textField.text = xw_splash_id;
    [self appendLogText:self.title];
}

- (void)clickBtnLoadAd {
    [self appendLogText:@"load SplashAd"];
    self.textField.enabled = NO;
    CGRect frame = [UIScreen mainScreen].bounds;
    CGRect splashFrame = CGRectMake(0, 0, frame.size.width, frame.size.height - 100);
    if (!self.splashAd) {
        self.splashAd = [[XWSplashAd alloc] initWithFrame:splashFrame slotId:self.textField.text viewController:self];
        self.splashAd.delegate = self;
    }
    [self.splashAd loadAd];
}

#pragma mark - XWSplashAdDelegate

- (void)xw_splashAdDidLoad:(XWSplashAd *)splashAd {
    [self appendLogText:[NSString stringWithFormat:@"xw_splashAdDidLoad, unionType: %@", [XWUnionTypeTool unionName4unionType:splashAd.unionType]]];
    
    UIWindow *keyWindow = [UIApplication sharedApplication].windows.firstObject;
    CGRect frame = [UIScreen mainScreen].bounds;
    CGRect bottomFrame = CGRectMake(0, frame.size.height - 100, frame.size.width, 100);

    UILabel *bottomView = [[UILabel alloc] initWithFrame:bottomFrame];

    [bottomView setText:@"这是一个测试LOGO"];
    bottomView.backgroundColor = [UIColor redColor];
    [self.splashAd showAdInWindow:keyWindow withBottomView:bottomView];
}

- (void)xw_splashAdDidFailToLoad:(XWSplashAd *)splashAd error:(NSError *)error {
    [self appendLogText:[NSString stringWithFormat:@"xw_splashAdDidFailToLoad, error:%@,%@", error.domain, error.localizedDescription]];
}

- (void)xw_splashAdDidPresent:(XWSplashAd *)splashAd {
    [self appendLogText:@"xw_splashAdDidPresent"];
}

- (void)xw_splashAdDidExpose:(XWSplashAd *)splashAd {
    [self appendLogText:@"xw_splashAdDidExpose"];
}

- (void)xw_splashAdDidClick:(XWSplashAd *)splashAd {
    [self appendLogText:@"xw_splashAdDidClick"];
}

- (void)xw_splashAdWillClose:(XWSplashAd *)splashAd {
    [self appendLogText:@"xw_splashAdWillClose"];
}

- (void)xw_splashAdDidClose:(XWSplashAd *)splashAd {
    [self appendLogText:@"xw_splashAdDidClose"];
}

- (void)xw_splashAdLifeTime:(XWSplashAd *)splashAd time:(NSUInteger)time {
    [self appendLogText:[NSString stringWithFormat:@"xw_splashAdLifeTime, time:%d", (int)time]];
}

- (void)xw_splashAdDidCloseOtherController:(XWSplashAd *)splashAd {
    [self appendLogText:@"xw_splashAdDidCloseOtherController"];
}

@end
