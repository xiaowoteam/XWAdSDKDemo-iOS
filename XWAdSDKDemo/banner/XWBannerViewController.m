//
//  XWBannerViewController.m
//  XWAdSDKDemo
//
//  Created by laole918 on 2021/5/10.
//

#import "XWBannerViewController.h"
#import <XWAdSDK/XWAdSDK.h>
#import "XWSlotID.h"

@interface XWBannerViewController ()<XWBannerAdViewDelegate>

@property (nonatomic, strong) XWBannerAdView * bannerView;

@end

@implementation XWBannerViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    [self setTitle:NSLocalizedString(@"Banner", nil)];

    self.textField.text = xw_banner_id;
    [self appendLogText:self.title];
}

- (void)clickBtnLoadAd {
    [self appendLogText:@"load BannerAd"];
    self.textField.enabled = NO;
    CGFloat screenWidth = CGRectGetWidth([UIScreen mainScreen].bounds);
    CGFloat bannerHeigh = screenWidth / 600 * 90;
    CGRect frame = CGRectMake(10, self.y += 10, screenWidth - 20, bannerHeigh);
    if (!self.bannerView) {
        self.bannerView = [[XWBannerAdView alloc] initWithFrame:frame slotId:self.textField.text viewController:self];
        self.bannerView.delegate = self;
    }
    [self.bannerView loadAd];
}

#pragma mark - XWBannerAdViewDelegate

- (void)xw_bannerAdViewDidLoad:(XWBannerAdView *)bannerAd {
    [self appendLogText:[NSString stringWithFormat:@"xw_bannerAdViewDidLoad, unionType: %@", [XWUnionTypeTool unionName4unionType:bannerAd.unionType]]];
    [self.view addSubview:self.bannerView];
}

- (void)xw_bannerAdViewDidFailToLoad:(XWBannerAdView *)bannerAd error:(NSError *)error {
    [self appendLogText:[NSString stringWithFormat:@"xw_bannerAdViewDidFailToLoad, error:%@,%@", error.domain, error.localizedDescription]];
}

- (void)xw_bannerAdViewDidExpose:(XWBannerAdView *)bannerAd {
    [self appendLogText:@"xw_bannerAdViewDidExpose"];
}

- (void)xw_bannerAdViewDidClick:(XWBannerAdView *)bannerAd {
    [self appendLogText:@"xw_bannerAdViewDidClick"];
}

- (void)xw_bannerAdViewDidClose:(XWBannerAdView *)bannerAd {
    [self appendLogText:@"xw_bannerAdViewDidClose"];
}

@end
