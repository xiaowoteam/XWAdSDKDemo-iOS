//
//  XWUnionTypeTool.m
//  XWAdSDKDemo
//
//  Created by laole918 on 2021/9/12.
//

#import "XWUnionTypeTool.h"

@implementation XWUnionTypeTool
+ (NSString *)unionName4unionType:(XWAdSdkUnionType)unionType {
    switch (unionType) {
        case XWAdSdkUnionTypeUnknown:
            return @"未知";
        case XWAdSdkUnionTypeADX:
            return @"小沃自有";
        case XWAdSdkUnionTypeGDT:
            return @"广点通";
        case XWAdSdkUnionTypeCSJ:
            return @"穿山甲";
        case XWAdSdkUnionTypeBaidu:
            return @"百度";
        case XWAdSdkUnionTypeKS:
            return @"快手";
        case XWAdSdkUnionTypeSIG:
            return @"sigmob";
        case XWAdSdkUnionTypeIQY:
            return @"爱奇艺";
        case XWAdSdkUnionTypeJD:
            return @"京东";
        case XWAdSdkUnionTypeLY:
            return @"LY";
        default:
            return @"未知";
    }
}
@end
