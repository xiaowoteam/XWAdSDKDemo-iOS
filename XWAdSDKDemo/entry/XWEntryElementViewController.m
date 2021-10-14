//
//  XWEntryElementViewController.m
//  XWAdSDKDemo
//
//  Created by laole918 on 2021/6/17.
//

#import "XWEntryElementViewController.h"
#import <XWAdSDK/XWAdSDK.h>
#import "XWSlotID.h"
#import "XWContentPageFullViewController.h"

@interface XWEntryElementViewController ()<XWEntryElementDelegate, UITableViewDelegate, UITableViewDataSource>
@property (nonatomic, strong) UITableView * tableView;
@property (nonatomic, strong) XWEntryElement * entryElement;

@property (strong, nonatomic) NSMutableArray<XWEntryElement *> *entryElements;
@end

@implementation XWEntryElementViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    [self setTitle:NSLocalizedString(@"EntryElement", nil)];
    
    self.textField.text = xw_entryelement_id;
    [self appendLogText:self.title];
    
    CGFloat screenHeight = [[UIScreen mainScreen] bounds].size.height;
    CGFloat tableViewY = self.y += 10;
    
    self.tableView = [[UITableView alloc] initWithFrame:CGRectMake(10, self.y, CGRectGetWidth(self.view.frame) - 20, screenHeight - tableViewY - 10) style:UITableViewStylePlain];
    [self.tableView registerClass:[UITableViewCell class] forCellReuseIdentifier:@"entryelementcell"];
    self.tableView.delegate = self;
    self.tableView.dataSource = self;
    [self.view addSubview:self.tableView];
    
    self.entryElements = [NSMutableArray new];
}

- (void)clickBtnLoadAd {
    [self appendLogText:@"load EntryElementAd"];
    self.textField.enabled = NO;
    if (!self.entryElement) {
        CGFloat width = CGRectGetWidth([UIScreen mainScreen].bounds) - 20;
        self.entryElement = [[XWEntryElement alloc] initWithSlotId:self.textField.text];
        self.entryElement.expectedWidth = width;
        self.entryElement.delegate = self;
    }
    [self.entryElement loadAd];
}

#pragma mark - UITableViewDelegate

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    return [self.entryElements objectAtIndex:indexPath.row].entryExpectedSize.height;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return self.entryElements.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    UITableViewCell *cell = [self.tableView dequeueReusableCellWithIdentifier:@"entryelementcell" forIndexPath:indexPath];
    cell.selectionStyle = UITableViewCellSelectionStyleNone;
    UIView *subView = (UIView *)[cell.contentView viewWithTag:1000];
    if ([subView superview]) {
        [subView removeFromSuperview];
    }
    UIView * view = [self.entryElements objectAtIndex:indexPath.row].entryView;
    view.tag = 1000;
    [cell.contentView addSubview:view];
    return cell;
}

#pragma mark - XWEntryElementDelegate

- (void)xw_entryElementAdDidLoad:(XWEntryElement *)entryElement {
    [self appendLogText:@"xw_entryElementAdDidLoad"];
    [self.entryElements addObject:entryElement];
    [self.tableView reloadData];
}

- (void)xw_entryElementAdDidFailToLoad:(XWEntryElement *)entryElement error:(NSError *)error {
    [self appendLogText:[NSString stringWithFormat:@"xw_entryElementAdDidFailToLoad, error:%@,%@", error.domain, error.localizedDescription]];
}

- (void)xw_entryElementAdDidExpose:(XWEntryElement *)entryElement {
    [self appendLogText:[NSString stringWithFormat:@"xw_entryElementAdDidExpose, unionType: %@", [XWUnionTypeTool unionName4unionType:entryElement.unionType]]];
}

- (void)xw_entryElementAdDidClick:(XWEntryElement *)entryElement contentPage:(XWContentPage *)contentPage {
    [self appendLogText:@"xw_entryElementAdDidClick"];
    
    XWContentPageFullViewController *vc = [[XWContentPageFullViewController alloc] initWithContentPage:contentPage];
    [self.navigationController pushViewController:vc animated:YES];
}

@end
