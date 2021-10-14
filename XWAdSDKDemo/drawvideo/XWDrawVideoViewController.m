//
//  XWDrawVideoViewController.m
//  XWAdSDKDemo
//
//  Created by laole918 on 2021/6/17.
//

#import "XWDrawVideoViewController.h"
#import <XWAdSDK/XWAdSDK.h>
#import "XWSlotID.h"
#import "XWDrawVideoDemoViewController.h"

@interface XWDrawVideoViewController ()
@end

@implementation XWDrawVideoViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    [self setTitle:NSLocalizedString(@"DrawVideo", nil)];
    
    self.textField.text = xw_drawvideo_id;
    [self appendLogText:self.title];
    
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(drawvideolog:) name:@"drawvideolog" object:nil];
}

- (void)dealloc {
    [[NSNotificationCenter defaultCenter] removeObserver:self];
}

- (void)clickBtnLoadAd {
    self.textField.enabled = NO;
    XWDrawVideoDemoViewController * vc = [[XWDrawVideoDemoViewController alloc] init];
    vc.slotId = self.textField.text;
    vc.modalPresentationStyle = UIModalPresentationFullScreen;
    [vc setModalTransitionStyle:UIModalTransitionStyleCrossDissolve];
    [self presentViewController:vc animated:YES completion:nil];
}

- (void)drawvideolog:(NSNotification*) notification {
    NSString * msg = [notification object];
    [self appendLogText:msg];
}

@end
