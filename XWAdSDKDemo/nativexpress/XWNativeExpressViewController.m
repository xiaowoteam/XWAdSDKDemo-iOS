//
//  XWNativeExpressViewController.m
//  XWAdSDKDemo
//
//  Created by laole918 on 2021/5/17.
//

#import "XWNativeExpressViewController.h"
#import <XWAdSDK/XWAdSDK.h>
#import "XWSlotID.h"

@interface XWNativeExpressViewController ()<XWNativeExpressAdDelegate, XWNativeExpressAdRelatedViewDelegate, UITableViewDelegate, UITableViewDataSource>
@property (nonatomic, strong) UITableView * tableView;
@property (nonatomic, strong) XWNativeExpressAd * nativeExpressAd;

@property (strong, nonatomic) NSMutableArray<XWNativeExpressAdRelatedView *> *expressAdRelatedViews;
@end

@implementation XWNativeExpressViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    [self setTitle:NSLocalizedString(@"NativeExpress", nil)];
    
    self.textField.text = xw_nativexpress_id;
    [self appendLogText:self.title];
    
    CGFloat screenHeight = [[UIScreen mainScreen] bounds].size.height;
    CGFloat tableViewY = self.y += 10;
    
    self.tableView = [[UITableView alloc] initWithFrame:CGRectMake(10, self.y, CGRectGetWidth(self.view.frame) - 20, screenHeight - tableViewY - 10) style:UITableViewStylePlain];
    [self.tableView registerClass:[UITableViewCell class] forCellReuseIdentifier:@"nativeexpresscell"];
    self.tableView.delegate = self;
    self.tableView.dataSource = self;
    [self.view addSubview:self.tableView];
    
    self.expressAdRelatedViews = [NSMutableArray new];
}

- (void)clickBtnLoadAd {
    [self appendLogText:@"load NativeExpressAd"];
    self.textField.enabled = NO;
    if (!self.nativeExpressAd) {
        CGFloat width = CGRectGetWidth([UIScreen mainScreen].bounds) - 20;
        self.nativeExpressAd = [[XWNativeExpressAd alloc] initWithSlotId:self.textField.text adSize:CGSizeMake(width, 0)];
        self.nativeExpressAd.delegate = self;
    }
    [self.nativeExpressAd loadAdWithCount:3];
}

#pragma mark - UITableViewDelegate

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    UIView *view = [[self.expressAdRelatedViews objectAtIndex:indexPath.row] getAdView];
    return view.bounds.size.height;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return self.expressAdRelatedViews.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    UITableViewCell *cell = [self.tableView dequeueReusableCellWithIdentifier:@"nativeexpresscell" forIndexPath:indexPath];
    cell.selectionStyle = UITableViewCellSelectionStyleNone;
    UIView *subView = (UIView *)[cell.contentView viewWithTag:1000];
    if ([subView superview]) {
        [subView removeFromSuperview];
    }
    UIView * view = [[self.expressAdRelatedViews objectAtIndex:indexPath.row] getAdView];
    view.tag = 1000;
    [cell.contentView addSubview:view];
    return cell;
}

#pragma mark - XWNativeExpressAdDelegate

- (void)xw_nativeExpressAdDidLoad:(NSArray<XWNativeExpressAdRelatedView *> * _Nullable)nativeExpressAdRelatedViews error:(NSError * _Nullable)error {
    if (error) {
        [self appendLogText:[NSString stringWithFormat:@"xw_nativeExpressAdDidLoad, error:%@,%@", error.domain, error.localizedDescription]];
    } else {
        [self appendLogText:[NSString stringWithFormat:@"xw_nativeExpressAdDidLoad, unionType: %@", [XWUnionTypeTool unionName4unionType:self.nativeExpressAd.unionType]]];
        [self.expressAdRelatedViews addObjectsFromArray:nativeExpressAdRelatedViews];
        if (nativeExpressAdRelatedViews.count) {
            [nativeExpressAdRelatedViews enumerateObjectsUsingBlock:^(id  _Nonnull obj, NSUInteger idx, BOOL * _Nonnull stop) {
                XWNativeExpressAdRelatedView *relatedView = (XWNativeExpressAdRelatedView *)obj;
                relatedView.delegate = self;
                relatedView.viewController = self;
                [relatedView render];
            }];
        }
        [self.tableView reloadData];
    }
}

#pragma mark - XWNativeExpressAdRelatedViewDelegate

- (void)xw_nativeExpressAdRelatedViewDidRenderSuccess:(XWNativeExpressAdRelatedView *)nativeExpressAdRelatedView {
    [self.tableView reloadData];
    [self appendLogText:@"xw_nativeExpressAdRelatedViewDidRenderSuccess"];
}

- (void)xw_nativeExpressAdRelatedViewDidRenderFail:(XWNativeExpressAdRelatedView *)nativeExpressAdRelatedView {
    [self.expressAdRelatedViews removeObject:nativeExpressAdRelatedView];
    [self.tableView reloadData];
    [self appendLogText:@"xw_nativeExpressAdRelatedViewDidRenderFail"];
}

- (void)xw_nativeExpressAdRelatedViewDidExpose:(XWNativeExpressAdRelatedView *)nativeExpressAdRelatedView {
    [self appendLogText:@"xw_nativeExpressAdRelatedViewDidExpose"];
}

- (void)xw_nativeExpressAdRelatedViewDidClick:(XWNativeExpressAdRelatedView *)nativeExpressAdRelatedView {
    [self appendLogText:@"xw_nativeExpressAdRelatedViewDidClick"];
}

- (void)xw_nativeExpressAdRelatedViewDidCloseOtherController:(XWNativeExpressAdRelatedView *)nativeExpressAdRelatedView {
    [self appendLogText:@"xw_nativeExpressAdRelatedViewDidCloseOtherController"];
}

- (void)xw_nativeExpressAdRelatedViewDislike:(XWNativeExpressAdRelatedView *)nativeExpressAdRelatedView {
    [self.expressAdRelatedViews removeObject:nativeExpressAdRelatedView];
    [self.tableView reloadData];
    [self appendLogText:@"xw_nativeExpressAdRelatedViewDislike"];
}

@end
