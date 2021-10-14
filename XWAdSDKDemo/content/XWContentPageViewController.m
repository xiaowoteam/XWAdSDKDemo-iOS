//
//  XWContentPageViewController.m
//  XWAdSDKDemo
//
//  Created by laole918 on 2021/6/15.
//

#import "XWContentPageViewController.h"
#import <XWAdSDK/XWAdSDK.h>
#import "XWSlotID.h"

@interface XWContentPageViewController () <XWContentPageDelegate, XWContentPageContentDelegate, XWContentPageVideoDelegate>
@property (nonatomic, strong) XWContentPage * contentPage;
@end

@implementation XWContentPageViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    [self setTitle:NSLocalizedString(@"ContentPage", nil)];
    
    self.textField.text = xw_contentpage_id;
    [self appendLogText:self.title];
}

- (void)clickBtnLoadAd {
    [self appendLogText:@"load ContentPageAd"];
    self.textField.enabled = NO;
    CGRect frame = CGRectMake(10, self.y + 10, self.view.bounds.size.width - 20, self.view.bounds.size.height - self.y - 20);
    self.contentPage = [[XWContentPage alloc] initWithSlotId:self.textField.text];
    self.contentPage.delegate = self;
    self.contentPage.contentDelegate = self;
    self.contentPage.videoDelegate = self;
    UIViewController * vc = self.contentPage.viewController;
    [self addChildViewController:vc];
    vc.view.frame = frame;
    [self.view addSubview:vc.view];
}

#pragma mark - XWContentPageDelegate

- (void)xw_contentPageDidLoad:(XWContentPage *)entryElement {
    [self appendLogText:[NSString stringWithFormat:@"xw_contentPageDidLoad, unionType: %@", [XWUnionTypeTool unionName4unionType:entryElement.unionType]]];
}

- (void)xw_contentPageDidFailToLoad:(XWContentPage *)entryElement error:(NSError *)error {
    [self appendLogText:[NSString stringWithFormat:@"xw_contentPageDidFailToLoad, error:%@,%@", error.domain, error.localizedDescription]];
}

#pragma mark - XWContentPageContentDelegate

- (void)xw_contentPageContentDidFullDisplay:(XWContentPage *)entryElement contentInfo:(XWContentInfo *) contentInfo {
    [self appendLogText:@"xw_contentPageContentDidFullDisplay"];
}

- (void)xw_contentPageContentDidEndDisplay:(XWContentPage *)entryElement contentInfo:(XWContentInfo *) contentInfo {
    [self appendLogText:@"xw_contentPageContentDidEndDisplay"];
}

- (void)xw_contentPageContentDidPause:(XWContentPage *)entryElement contentInfo:(XWContentInfo *) contentInfo {
    [self appendLogText:@"xw_contentPageContentDidPause"];
}

- (void)xw_contentPageContentDidResume:(XWContentPage *)entryElement contentInfo:(XWContentInfo *) contentInfo {
    [self appendLogText:@"xw_contentPageContentDidResume"];
}

#pragma mark - XWContentPageVideoDelegate

- (void)xw_contentPageVideoDidStartPlay:(XWContentPage *)entryElement contentInfo:(XWContentInfo *) contentInfo {
    [self appendLogText:@"xw_contentPageVideoDidStartPlay"];
}

- (void)xw_contentPageVideoDidPause:(XWContentPage *)entryElement contentInfo:(XWContentInfo *) contentInfo {
    [self appendLogText:@"xw_contentPageVideoDidPause"];
}

- (void)xw_contentPageVideoDidResume:(XWContentPage *)entryElement contentInfo:(XWContentInfo *) contentInfo {
    [self appendLogText:@"xw_contentPageVideoDidResume"];
}

- (void)xw_contentPageVideoDidEndPlay:(XWContentPage *)entryElement contentInfo:(XWContentInfo *) contentInfo {
    [self appendLogText:@"xw_contentPageVideoDidEndPlay"];
}

- (void)xw_contentPageVideoDidFailToPlay:(XWContentPage *)entryElement contentInfo:(XWContentInfo *) contentInfo error:(NSError *)error {
    [self appendLogText:[NSString stringWithFormat:@"xw_contentPageVideoDidFailToPlay, error:%@,%@", error.domain, error.localizedDescription]];
}

@end
