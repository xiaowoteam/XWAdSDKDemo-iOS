//
//  XWNativeAdBaseCell.h
//  XWAdSDKDemo
//
//  Created by laole918 on 2021/5/22.
//

#import <UIKit/UIKit.h>
#import <XWAdSDK/XWAdSDK.h>

NS_ASSUME_NONNULL_BEGIN

@interface XWNativeAdBaseCell : UITableViewCell
@property (nonatomic, strong) XWNativeAdView *adView;

- (void)setupWithNativeAdDataObject:(XWNativeAdDataObject *)dataObject delegate:(id <XWNativeAdViewDelegate>)delegate vc:(UIViewController *)vc;
+ (CGFloat)cellHeightWithNativeAdDataObject:(XWNativeAdDataObject *)dataObject;
@end

NS_ASSUME_NONNULL_END
