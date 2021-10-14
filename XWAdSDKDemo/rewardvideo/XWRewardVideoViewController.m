//
//  XWRewardVideoViewController.m
//  XWAdSDKDemo
//
//  Created by laole918 on 2021/5/10.
//

#import "XWRewardVideoViewController.h"
#import <XWAdSDK/XWAdSDK.h>
#import "XWSlotID.h"

@interface XWRewardVideoViewController ()<XWRewardVideoAdDelegate, UITextFieldDelegate>

@property (nonatomic, strong) XWRewardVideoAd * rewardedAd;
@property (nonatomic, strong) UITextField *extraTextField;
@end

@implementation XWRewardVideoViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    [self setTitle:NSLocalizedString(@"RewardVideo", nil)];
    
    self.textField.text = xw_reward_id;
    [self appendLogText:self.title];
    
    self.extraTextField = [[UITextField alloc] initWithFrame:CGRectMake(10, self.y += 10, CGRectGetWidth(self.view.frame) - 20, 50)];
    self.extraTextField.placeholder = @"extra";
    self.extraTextField.returnKeyType = UIReturnKeyDone;
    self.extraTextField.borderStyle = UITextBorderStyleLine;
//    self.textField.keyboardType = UIKeyboardTypeNumberPad;
    self.extraTextField.delegate = self;
    [self.view addSubview:self.extraTextField];

}

- (void)clickBtnLoadAd {
    [self appendLogText:@"load RewardVideoAd"];
    self.textField.enabled = NO;
    if (!self.rewardedAd) {
        if (self.extraTextField.text && self.extraTextField.text.length > 0) {
            self.rewardedAd = [[XWRewardVideoAd alloc] initWithSlotId:self.textField.text extra:self.extraTextField.text];
        } else {
            self.rewardedAd = [[XWRewardVideoAd alloc] initWithSlotId:self.textField.text];
        }
        self.rewardedAd.delegate = self;
    }
    [self.rewardedAd loadAd];
}

- (BOOL)textFieldShouldReturn:(UITextField *)textField {
    [self.extraTextField resignFirstResponder];
    return YES;
}

#pragma mark - XWRewardVideoAdDelegate

- (void)xw_rewardVideoAdDidLoad:(XWRewardVideoAd *)rewardVideoAd {
    [self appendLogText:[NSString stringWithFormat:@"xw_rewardVideoAdDidLoad, unionType: %@", [XWUnionTypeTool unionName4unionType:rewardVideoAd.unionType]]];
}

- (void)xw_rewardVideoAdDidFailToLoad:(XWRewardVideoAd *)rewardVideoAd error:(NSError *)error {
    [self appendLogText:[NSString stringWithFormat:@"xw_rewardVideoAdDidFailToLoad, error:%@,%@", error.domain, error.localizedDescription]];
}

- (void)xw_rewardVideoAdDidCache:(XWRewardVideoAd *)rewardVideoAd {
    [self appendLogText:@"xw_rewardVideoAdDidCache"];
    [self.rewardedAd showAdFromRootViewController:self];
}

- (void)xw_rewardVideoAdDidExpose:(XWRewardVideoAd *)rewardVideoAd {
    [self appendLogText:@"xw_rewardVideoAdDidExpose"];
}

- (void)xw_rewardVideoAdDidClick:(XWRewardVideoAd *)rewardVideoAd {
    [self appendLogText:@"xw_rewardVideoAdDidClick"];
}

- (void)xw_rewardVideoAdDidClose:(XWRewardVideoAd *)rewardVideoAd {
    [self appendLogText:@"xw_rewardVideoAdDidClose"];
}

- (void)xw_rewardVideoAdDidPlayFinish:(XWRewardVideoAd *)rewardVideoAd {
    [self appendLogText:@"xw_rewardVideoAdDidPlayFinish"];
}

- (void)xw_rewardVideoAdDidRewardEffective:(XWRewardVideoAd *)rewardVideoAd trackUid:(NSString *) trackUid {
    [self appendLogText:[NSString stringWithFormat:@"xw_rewardVideoAdDidRewardEffective, trackUid:%@", trackUid]];
}

@end
