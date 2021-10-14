//
//  XWBaseViewController.h
//  XWAdSDKDemo
//
//  Created by laole918 on 2021/5/21.
//

#import <UIKit/UIKit.h>
#import "XWUnionTypeTool.h"

NS_ASSUME_NONNULL_BEGIN

@interface XWBaseViewController : UIViewController
@property (nonatomic, strong) UITextField *textField;
@property (nonatomic, strong) NSMutableString * logString;
@property (nonatomic, strong) UITextView * logText;
@property (nonatomic, assign) CGFloat y;

- (void)appendLogText:(NSString *) text;
@end

NS_ASSUME_NONNULL_END
