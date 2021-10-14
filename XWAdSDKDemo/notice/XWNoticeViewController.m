//
//  XWNoticeViewController.m
//  XWAdSDKDemo
//
//  Created by laole918 on 2021/5/18.
//

#import "XWNoticeViewController.h"
#import <XWAdSDK/XWAdSDK.h>
#import "XWSlotID.h"

@interface XWNoticeViewController ()<XWNoticeAdDelegate>
@property (nonatomic, strong) XWNoticeAd * noticeAd;
@end

@implementation XWNoticeViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    [self setTitle:NSLocalizedString(@"Notice", nil)];
    
    self.textField.text = xw_notice_id;
    [self appendLogText:self.title];
}

- (void)clickBtnLoadAd {
    [self appendLogText:@"load NoticeAd"];
    self.textField.enabled = NO;
    if (!self.noticeAd) {
        self.noticeAd = [[XWNoticeAd alloc] initWithSlotId:self.textField.text];
        self.noticeAd.delegate = self;
    }
    [self.noticeAd loadAd];
}

#pragma mark - XWNoticeAdDelegate

- (void)xw_noticeAdDidLoad:(XWNoticeAd *)noticeAd {
    [self appendLogText:[NSString stringWithFormat:@"xw_noticeAdDidLoad, unionType: %@", [XWUnionTypeTool unionName4unionType:noticeAd.unionType]]];
    [self.noticeAd showAdInWindow:[UIApplication sharedApplication].keyWindow];
}

- (void)xw_noticeAdDidFailToLoad:(XWNoticeAd *)noticeAd error:(NSError *)error {
    [self appendLogText:[NSString stringWithFormat:@"xw_noticeAdDidFailToLoad, error:%@,%@", error.domain, error.localizedDescription]];
}

- (void)xw_noticeAdDidExpose:(XWNoticeAd *)noticeAd {
    [self appendLogText:@"xw_noticeAdDidExpose"];
}

- (void)xw_noticeAdDidClick:(XWNoticeAd *)noticeAd {
    [self appendLogText:@"xw_noticeAdDidClick"];
}

- (void)xw_noticeAdDidClose:(XWNoticeAd *)noticeAd {
    [self appendLogText:@"xw_noticeAdDidClose"];
}

@end
