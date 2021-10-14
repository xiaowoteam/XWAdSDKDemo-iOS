//
//  XWDrawVideoDemoViewController.m
//  XWAdSDKDemo
//
//  Created by laole918 on 2021/6/17.
//

#import "XWDrawVideoDemoViewController.h"
#import <XWAdSDK/XWAdSDK.h>
#import "XWSlotID.h"
#import "XWDrawVideoAdCell.h"
#import "XWUnionTypeTool.h"

@interface XWDrawVideoDemoViewController () <XWDrawVideoAdDelegate, XWDrawVideoAdRelatedViewDelegate, UITableViewDelegate, UITableViewDataSource>
@property (nonatomic, strong) UITableView * tableView;
@property (nonatomic, strong) XWDrawVideoAd * drawVideoAd;
@property (strong, nonatomic) NSMutableArray<XWDrawVideoAdRelatedView *> *drawVideoAdRelatedViews;
@end

@implementation XWDrawVideoDemoViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    self.tableView = [[UITableView alloc] initWithFrame:[UIScreen mainScreen].bounds];
    self.tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
    self.tableView.pagingEnabled = YES;
    self.tableView.scrollsToTop = NO;
#if defined(__IPHONE_11_0) && __IPHONE_OS_VERSION_MAX_ALLOWED >= __IPHONE_11_0
    if ([self.tableView respondsToSelector:@selector(setContentInsetAdjustmentBehavior:)]) {
        if (@available(iOS 11.0, *)) {
            self.tableView.contentInsetAdjustmentBehavior = UIScrollViewContentInsetAdjustmentNever;
        }
    }
#else
    self.automaticallyAdjustsScrollViewInsets = NO;
#endif
    [self.tableView registerClass:[XWDrawVideoAdCell class] forCellReuseIdentifier:@"XWDrawVideoAdCell"];
    self.tableView.delegate = self;
    self.tableView.dataSource = self;
    [self.view addSubview:self.tableView];
    
    self.drawVideoAdRelatedViews = [NSMutableArray new];
    
    self.drawVideoAd = [[XWDrawVideoAd alloc] initWithSlotId:self.slotId adSize:[[UIScreen mainScreen] bounds].size];
    self.drawVideoAd.delegate = self;
    [self.drawVideoAd loadAdWithCount:3];
    [[NSNotificationCenter defaultCenter] postNotificationName:@"drawvideolog" object:@"load DrawVideoAd"];
    
    UIButton * button = [UIButton buttonWithType:UIButtonTypeRoundedRect];
    [button.layer setCornerRadius:10.0];
    button.backgroundColor = [UIColor redColor];
    button.frame = CGRectMake(13, 34, 100, 50);
    [button setTitle:NSLocalizedString(@"Close", nil) forState:UIControlStateNormal];
    [button setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
    [button setTitleColor:[UIColor grayColor] forState:UIControlStateFocused];
    [button addTarget:self action:@selector(closeVC) forControlEvents:UIControlEventTouchUpInside];
    [self.view bringSubviewToFront:button];
    [self.view addSubview:button];
}

- (void)closeVC{
    [self dismissViewControllerAnimated:YES completion:nil];
}

#pragma mark - UITableViewDelegate

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    return [[UIScreen mainScreen] bounds].size.height;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return self.drawVideoAdRelatedViews.count * 2;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    if (indexPath.row % 2 == 0) {
        UITableViewCell * cell = [[UITableViewCell alloc] init];
        cell.textLabel.text = NSLocalizedString(@"draw_video_tips", nil);
        return cell;
    } else {
        id model = self.drawVideoAdRelatedViews[indexPath.row / 2];
        XWDrawVideoAdCell *cell = [self.tableView dequeueReusableCellWithIdentifier:@"XWDrawVideoAdCell"];
        [cell refreshWithDrawVideoAdRelatedView:model];
        return cell;
    }
}

#pragma mark - XWDrawVideoAdDelegate

- (void)xw_drawVideoAdDidLoad:(NSArray<XWDrawVideoAdRelatedView *> * _Nullable) drawVideoAdRelatedViews error:(NSError * _Nullable) error {
    if (error) {
        [[NSNotificationCenter defaultCenter] postNotificationName:@"drawvideolog" object:[NSString stringWithFormat:@"xw_drawVideoAdDidLoad, error:%@,%@", error.domain, error.localizedDescription]];
    } else {
        [[NSNotificationCenter defaultCenter] postNotificationName:@"drawvideolog" object:[NSString stringWithFormat:@"xw_drawVideoAdDidLoad, unionType: %@", [XWUnionTypeTool unionName4unionType:self.drawVideoAd.unionType]]];
        [self.drawVideoAdRelatedViews addObjectsFromArray:drawVideoAdRelatedViews];
        if (drawVideoAdRelatedViews.count) {
            [drawVideoAdRelatedViews enumerateObjectsUsingBlock:^(id  _Nonnull obj, NSUInteger idx, BOOL * _Nonnull stop) {
                XWDrawVideoAdRelatedView *relatedView = (XWDrawVideoAdRelatedView *)obj;
                relatedView.delegate = self;
                relatedView.viewController = self;
            }];
        }
        [self.tableView reloadData];
    }
}

#pragma mark - XWDrawVideoAdRelatedViewDelegate

- (void)xw_drawVideoAdRelatedViewDidExpose:(XWDrawVideoAdRelatedView *)drawVideoAdRelatedView {
    [[NSNotificationCenter defaultCenter] postNotificationName:@"drawvideolog" object:@"xw_drawVideoAdRelatedViewDidExpose"];
}

- (void)xw_drawVideoAdRelatedViewDidClick:(XWDrawVideoAdRelatedView *)drawVideoAdRelatedView {
    [[NSNotificationCenter defaultCenter] postNotificationName:@"drawvideolog" object:@"xw_drawVideoAdRelatedViewDidClick"];
}

- (void)xw_drawVideoAdRelatedViewDidCloseOtherController:(XWDrawVideoAdRelatedView *)drawVideoAdRelatedView {
    [[NSNotificationCenter defaultCenter] postNotificationName:@"drawvideolog" object:@"xw_drawVideoAdRelatedViewDidCloseOtherController"];
}

- (void)xw_drawVideoAdRelatedViewDidPlayFinish:(XWDrawVideoAdRelatedView *)drawVideoAdRelatedView {
    [[NSNotificationCenter defaultCenter] postNotificationName:@"drawvideolog" object:@"xw_drawVideoAdRelatedViewDidPlayFinish"];
}


@end
