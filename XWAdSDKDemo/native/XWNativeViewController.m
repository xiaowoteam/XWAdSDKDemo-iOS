//
//  XWNativeViewController.m
//  XWAdSDKDemo
//
//  Created by laole918 on 2021/5/11.
//

#import "XWNativeViewController.h"
#import <XWAdSDK/XWAdSDK.h>
#import "XWSlotID.h"
#import "XWNativeAdImageCell.h"
#import "XWNativeAdVideoCell.h"

@interface XWNativeViewController ()<XWNativeAdDelegate, XWNativeAdViewDelegate, UITableViewDelegate, UITableViewDataSource>
@property (nonatomic, strong) XWNativeAd * nativeAd;
@property (nonatomic, strong) NSMutableArray<XWNativeAdDataObject *> *adDataArray;
@property (nonatomic, strong) UITableView *tableView;
@end

@implementation XWNativeViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    [self setTitle:NSLocalizedString(@"Native", nil)];

    self.textField.text = xw_native_id;
    [self appendLogText:self.title];
    
    CGFloat screenHeight = [[UIScreen mainScreen] bounds].size.height;
    CGFloat tableViewY = self.y += 10;
    
    self.tableView = [[UITableView alloc] initWithFrame:CGRectMake(10, self.y, CGRectGetWidth(self.view.frame) - 20, screenHeight - tableViewY - 10) style:UITableViewStylePlain];
    [self.tableView registerClass:[XWNativeAdImageCell class] forCellReuseIdentifier:@"XWNativeAdImageCell"];
    [self.tableView registerClass:[XWNativeAdVideoCell class] forCellReuseIdentifier:@"XWNativeAdVideoCell"];
    self.tableView.delegate = self;
    self.tableView.dataSource = self;
    [self.view addSubview:self.tableView];
    
    self.adDataArray = [NSMutableArray new];
}

- (void)clickBtnLoadAd {
    [self appendLogText:@"load NativeAd"];
    self.textField.enabled = NO;
    if (!self.nativeAd) {
        self.nativeAd = [[XWNativeAd alloc] initWithSlotId:self.textField.text];
        self.nativeAd.delegate = self;
    }
    [self.nativeAd loadAdWithCount:3];
}

#pragma mark - UITableViewDelegate

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return self.adDataArray.count;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    XWNativeAdDataObject *dataObject = self.adDataArray[indexPath.row];
    if (dataObject.creativeType == XWNativeAdCreativeType_GDT_isVideoAd
            || dataObject.creativeType == XWNativeAdCreativeType_CSJ_VideoImage
            || dataObject.creativeType == XWNativeAdCreativeType_CSJ_VideoPortrait
            || dataObject.creativeType == XWNativeAdCreativeType_CSJ_SquareVideo
            || dataObject.creativeType == XWNativeAdCreativeType_CSJ_UnionSplashVideo) {
        return [XWNativeAdVideoCell cellHeightWithNativeAdDataObject:dataObject];
    } else {
        return [XWNativeAdImageCell cellHeightWithNativeAdDataObject:dataObject];
    }
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    XWNativeAdDataObject *dataObject = self.adDataArray[indexPath.row];
    if (dataObject.creativeType == XWNativeAdCreativeType_GDT_isVideoAd
        || dataObject.creativeType == XWNativeAdCreativeType_CSJ_VideoImage
        || dataObject.creativeType == XWNativeAdCreativeType_CSJ_VideoPortrait
        || dataObject.creativeType == XWNativeAdCreativeType_CSJ_SquareVideo
        || dataObject.creativeType == XWNativeAdCreativeType_CSJ_UnionSplashVideo) {
        XWNativeAdVideoCell *cell = [tableView dequeueReusableCellWithIdentifier:@"XWNativeAdVideoCell"];
        [cell setupWithNativeAdDataObject:dataObject delegate:self vc:self];
        return cell;
    } else {
        XWNativeAdImageCell *cell = [tableView dequeueReusableCellWithIdentifier:@"XWNativeAdImageCell"];
        [cell setupWithNativeAdDataObject:dataObject delegate:self vc:self];
        return cell;
    }
}

#pragma mark - XWNativeAdDelegate

- (void)xw_nativeAdDidLoad:(NSArray<XWNativeAdDataObject *> * _Nullable)nativeAdDataObjects error:(NSError * _Nullable)error {
    if (error) {
        [self appendLogText:[NSString stringWithFormat:@"xw_nativeAdDidLoad, error:%@,%@", error.domain, error.localizedDescription]];
    } else {
        [self appendLogText:[NSString stringWithFormat:@"xw_nativeAdDidLoad, unionType: %@", [XWUnionTypeTool unionName4unionType:self.nativeAd.unionType]]];
        if (nativeAdDataObjects.count > 0) {
            [self.adDataArray addObjectsFromArray:nativeAdDataObjects];
            [self.tableView reloadData];
        }
    }
}

#pragma mark - XWNativeAdViewDelegate

- (void)xw_nativeAdViewDidExpose:(XWNativeAdView *)nativeAdView {
    [self appendLogText:@"xw_nativeAdViewDidExpose"];
}

- (void)xw_nativeAdViewDidClick:(XWNativeAdView *)nativeAdView {
    [self appendLogText:@"xw_nativeAdViewDidClick"];
}

- (void)xw_nativeAdViewMediaDidPlayFinish:(XWNativeAdView *)nativeAdView {
    [self appendLogText:@"xw_nativeAdViewMediaDidPlayFinish"];
}

- (void)xw_nativeAdViewDidCloseOtherController:(XWNativeAdView *)nativeAdView {
    [self appendLogText:@"xw_nativeAdViewDidCloseOtherController"];
}

- (void)xw_nativeAdViewDislike:(XWNativeAdView *)nativeAdView {
    [self appendLogText:@"xw_nativeAdViewDislike"];
}

@end
