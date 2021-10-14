//
//  XWFullScreenVideoViewController.m
//  XWAdSDKDemo
//
//  Created by laole918 on 2021/6/16.
//

#import "XWFullScreenVideoViewController.h"
#import <XWAdSDK/XWAdSDK.h>
#import "XWSlotID.h"

@interface XWFullScreenVideoViewController () <XWFullScreenVideoAdDelegate>
@property (nonatomic, strong) XWFullScreenVideoAd * fullScreenVideoAd;
@end

@implementation XWFullScreenVideoViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    [self setTitle:NSLocalizedString(@"FullScreenVideo", nil)];
    
    self.textField.text = xw_fullscreenvideo_id;
    [self appendLogText:self.title];
}

- (void)clickBtnLoadAd {
    [self appendLogText:@"load FullScreenVideo"];
    self.textField.enabled = NO;
    if (!self.fullScreenVideoAd) {
        self.fullScreenVideoAd = [[XWFullScreenVideoAd alloc] initWithSlotId:self.textField.text];
        self.fullScreenVideoAd.delegate = self;
    }
    [self.fullScreenVideoAd loadAd];
}

#pragma mark - XWFullScreenVideoAdDelegate

- (void)xw_fullScreenVideoAdDidLoad:(XWFullScreenVideoAd *)fullScreenVideoAd {
    [self appendLogText:[NSString stringWithFormat:@"xw_fullScreenVideoAdDidLoad, unionType: %@", [XWUnionTypeTool unionName4unionType:fullScreenVideoAd.unionType]]];
}

- (void)xw_fullScreenVideoAdDidFailToLoad:(XWFullScreenVideoAd *)fullScreenVideoAd error:(NSError *)error {
    [self appendLogText:[NSString stringWithFormat:@"xw_fullScreenVideoAdDidFailToLoad, error:%@,%@", error.domain, error.localizedDescription]];
}

- (void)xw_fullScreenVideoAdDidCache:(XWFullScreenVideoAd *)fullScreenVideoAd {
    [self appendLogText:@"xw_fullScreenVideoAdDidCache"];
    [self.fullScreenVideoAd showAdFromRootViewController:self];
}

- (void)xw_fullScreenVideoAdDidExpose:(XWFullScreenVideoAd *)fullScreenVideoAd {
    [self appendLogText:@"xw_fullScreenVideoAdDidExpose"];
}

- (void)xw_fullScreenVideoAdDidClick:(XWFullScreenVideoAd *)fullScreenVideoAd {
    [self appendLogText:@"xw_fullScreenVideoAdDidClick"];
}

- (void)xw_fullScreenVideoAdDidClose:(XWFullScreenVideoAd *)fullScreenVideoAd {
    [self appendLogText:@"xw_fullScreenVideoAdDidClose"];
}

- (void)xw_fullScreenVideoAdDidPlayFinish:(XWFullScreenVideoAd *)fullScreenVideoAd {
    [self appendLogText:@"xw_fullScreenVideoAdDidPlayFinish"];
}

- (void)xw_fullScreenVideoAdDidClickSkip:(XWFullScreenVideoAd *)fullScreenVideoAd {
    [self appendLogText:@"xw_fullScreenVideoAdDidClickSkip"];
}

@end
