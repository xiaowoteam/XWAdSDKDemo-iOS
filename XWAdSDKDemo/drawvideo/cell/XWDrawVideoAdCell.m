//
//  XWDrawVideoAdCell.m
//  XWAdSDKDemo
//
//  Created by laole918 on 2021/6/17.
//

#import "XWDrawVideoAdCell.h"

@interface XWDrawVideoAdCell ()

@property (nonatomic, weak) XWDrawVideoAdRelatedView *relatedView;

@end

@implementation XWDrawVideoAdCell

- (void)refreshWithDrawVideoAdRelatedView:(XWDrawVideoAdRelatedView *)relatedView {
    self.relatedView = relatedView;
    [self.relatedView registerContainer:self.contentView];
}

- (void)prepareForReuse {
    [super prepareForReuse];
    [self.relatedView unregisterView];
}

@end
