//
//  XWInterstitialViewController.m
//  XWAdSDKDemo
//
//  Created by laole918 on 2021/5/10.
//

#import "XWInterstitialViewController.h"
#import <XWAdSDK/XWAdSDK.h>
#import "XWSlotID.h"

@interface XWInterstitialViewController ()<XWInterstitialAdDelegate>

@property (nonatomic, strong) XWInterstitialAd * interstitial;

@end

@implementation XWInterstitialViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    [self setTitle:NSLocalizedString(@"Interstitial", nil)];
    
    self.textField.text = xw_interstitial_id;
    [self appendLogText:self.title];
}

- (void)clickBtnLoadAd {
    [self appendLogText:@"load InterstitialAd"];
    self.textField.enabled = NO;
    if (!self.interstitial) {
        CGSize adSize = CGSizeMake(300, 450);
        self.interstitial = [[XWInterstitialAd alloc] initWithSlotId:self.textField.text adSize:adSize];
        self.interstitial.delegate = self;
    }
    [self.interstitial loadAd];
}

#pragma mark - XWInterstitialAdDelegate

- (void)xw_interstitialAdDidLoad:(XWInterstitialAd *)interstitialAd {
    [self appendLogText:[NSString stringWithFormat:@"xw_interstitialAdDidLoad, unionType: %@", [XWUnionTypeTool unionName4unionType:interstitialAd.unionType]]];
    [self.interstitial showAdFromRootViewController:self];
}

- (void)xw_interstitialAdDidFailToLoad:(XWInterstitialAd *)interstitialAd error:(NSError *)error {
    [self appendLogText:[NSString stringWithFormat:@"xw_interstitialAdDidFailToLoad, error:%@,%@", error.domain, error.localizedDescription]];
}

- (void)xw_interstitialAdDidExpose:(XWInterstitialAd *)interstitialAd {
    [self appendLogText:@"xw_interstitialAdDidExpose"];
}

- (void)xw_interstitialAdDidClick:(XWInterstitialAd *)interstitialAd {
    [self appendLogText:@"xw_interstitialAdDidClick"];
}

- (void)xw_interstitialAdDidClose:(XWInterstitialAd *)interstitialAd {
    [self appendLogText:@"xw_interstitialAdDidClose"];
}

@end
