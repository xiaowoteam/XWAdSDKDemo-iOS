//
//  XWNativeAdBaseCell.m
//  XWAdSDKDemo
//
//  Created by laole918 on 2021/5/22.
//

#import "XWNativeAdBaseCell.h"

@implementation XWNativeAdBaseCell

- (instancetype)init {
    self = [super init];
    if (self) {
        self.selectionStyle = UITableViewCellSelectionStyleNone;
        self.adView = [[XWNativeAdView alloc] init];
        [self.contentView addSubview:self.adView];
    }
    return self;
}

- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier {
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        self.selectionStyle = UITableViewCellSelectionStyleNone;
        self.adView = [[XWNativeAdView alloc] init];
        [self.contentView addSubview:self.adView];
    }
    return self;
}

- (void)prepareForReuse {
    [super prepareForReuse];
}

#pragma mark - public
- (void)setupWithNativeAdDataObject:(XWNativeAdDataObject *)dataObject delegate:(id<XWNativeAdViewDelegate>)delegate vc:(UIViewController *)vc {
}

+ (CGFloat)cellHeightWithNativeAdDataObject:(XWNativeAdDataObject *)dataObject {
    return 0;
}

@end
