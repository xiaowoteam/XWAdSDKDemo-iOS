//
//  XWContentPageFullViewController.m
//  XWAdSDKDemo
//
//  Created by laole918 on 2021/6/17.
//

#import "XWContentPageFullViewController.h"

@interface XWContentPageFullViewController () <XWContentPageDelegate, XWContentPageContentDelegate, XWContentPageVideoDelegate>
@property (nonatomic, strong) XWContentPage * contentPage;
@end

@implementation XWContentPageFullViewController

- (instancetype)initWithContentPage:(XWContentPage *) contentPage {
    if (self = [super init]) {
        self.contentPage = contentPage;
        self.contentPage.delegate = self;
        self.contentPage.contentDelegate = self;
        self.contentPage.videoDelegate = self;
    }
    return self;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    [self addChildViewController:self.contentPage.viewController];
    [self.view addSubview:self.contentPage.viewController.view];
    self.contentPage.viewController.view.frame = self.view.frame;
}

#pragma mark - XWContentPageDelegate

- (void)xw_contentPageDidLoad:(XWContentPage *)entryElement {
    
}

- (void)xw_contentPageDidFailToLoad:(XWContentPage *)entryElement error:(NSError *)error {
    
}

#pragma mark - XWContentPageContentDelegate

- (void)xw_contentPageContentDidFullDisplay:(XWContentPage *)entryElement contentInfo:(XWContentInfo *) contentInfo {
    
}

- (void)xw_contentPageContentDidEndDisplay:(XWContentPage *)entryElement contentInfo:(XWContentInfo *) contentInfo {
    
}

- (void)xw_contentPageContentDidPause:(XWContentPage *)entryElement contentInfo:(XWContentInfo *) contentInfo {
    
}

- (void)xw_contentPageContentDidResume:(XWContentPage *)entryElement contentInfo:(XWContentInfo *) contentInfo {
    
}

#pragma mark - XWContentPageVideoDelegate

- (void)xw_contentPageVideoDidStartPlay:(XWContentPage *)entryElement contentInfo:(XWContentInfo *) contentInfo {
    
}

- (void)xw_contentPageVideoDidPause:(XWContentPage *)entryElement contentInfo:(XWContentInfo *) contentInfo {
    
}

- (void)xw_contentPageVideoDidResume:(XWContentPage *)entryElement contentInfo:(XWContentInfo *) contentInfo {
    
}

- (void)xw_contentPageVideoDidEndPlay:(XWContentPage *)entryElement contentInfo:(XWContentInfo *) contentInfo {
    
}

- (void)xw_contentPageVideoDidFailToPlay:(XWContentPage *)entryElement contentInfo:(XWContentInfo *) contentInfo error:(NSError *)error {
    
}

@end
