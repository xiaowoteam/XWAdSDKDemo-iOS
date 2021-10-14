//
//  XWNativeAdVideoCell.m
//  XWAdSDKDemo
//
//  Created by laole918 on 2021/5/22.
//

#import "XWNativeAdVideoCell.h"

@implementation XWNativeAdVideoCell

- (void)setupWithNativeAdDataObject:(XWNativeAdDataObject *)dataObject delegate:(id <XWNativeAdViewDelegate>)delegate vc:(UIViewController *)vc {
    self.adView.delegate = delegate; // adView 广告回调
    self.adView.viewController = vc; // 跳转 VC
    //一定要先refreshData
    [self.adView refreshData:dataObject];
    
    CGFloat width = CGRectGetWidth([UIScreen mainScreen].bounds) - 20;
    CGFloat videoHeigh = 300;
    XWVideoConfig *videoConfig = [[XWVideoConfig alloc] init]; //只对广点通生效，可以缺省
    videoConfig.videoMuted = YES;
    videoConfig.userControlEnable = NO;
    videoConfig.detailPageEnable = YES;
    dataObject.videoConfig = videoConfig;
    [self.adView addSubview:self.adView.mediaView];
    self.adView.frame = CGRectMake(0, 0, width, videoHeigh);
    self.adView.mediaView.frame = CGRectMake(0, 0, width, videoHeigh);
    self.adView.mediaView.hidden = NO;
    self.adView.logoView.frame = CGRectMake(CGRectGetWidth(self.adView.frame) - self.adView.logoImageViewDefaultWidth, CGRectGetHeight(self.adView.frame) - self.adView.logoImageViewDefaultHeight, self.adView.logoImageViewDefaultWidth, self.adView.logoImageViewDefaultHeight);
    [self.adView addSubview:self.adView.logoView];
    [self.adView registerDataObjectWithClickableViews:@[]];
}

+ (CGFloat)cellHeightWithNativeAdDataObject:(XWNativeAdDataObject *)dataObject {
    return 300;
}

@end
