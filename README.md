# 广告 iOS SDK 接入文档

## SDK项目部署

### 开发环境

- **开发工具**：推荐Xcode 12及以上版本

- **部署目标**：iOS 9.0及以上

- **SDK版本**：官网最新版本

### pod方式接入

```ruby
# Uncomment the next line to define a global platform for your project
# CocoaPods官方库
source 'https://github.com/CocoaPods/Specs.git'
# 清华大学镜像库，如果上面库无法加载请使用下面镜像
# source 'https://mirrors.tuna.tsinghua.edu.cn/git/CocoaPods/Specs.git'

# 添加XWSpecs私库
source 'https://gitee.com/xiaowoteam/XWSpecs.git'
# 添加LYSpecs私库
source 'https://gitee.com/happytour/LYSpecs.git'

platform :ios, '9.0'

workspace 'XWAdSDKDemo'
project 'XWAdSDKDemo'

target 'XWAdSDKDemo' do
  pod 'Ads-CN', '4.0.0.5' #穿山甲官网SDK
  pod 'GDTMobSDK', '4.13.10' #广点通官网SDK
  pod 'SigmobAd-iOS', '3.2.4' #sigmob官网SDK
  pod 'BaiduMobAdSDK', '4.81' #百度官网SDK
  # KSAdSDKFull、QySdk、JADYun，没有提交到官方库，需要引入XWSpecs私库拉取
  pod 'fork-KSAdSDKFull', '3.3.24.1' #快手官网SDK
  pod 'fork-QySdk', '1.3.2' #爱奇艺官网SDK
  pod 'fork-JADYun' , '1.2.4' #京东官网SDK
  pod 'WechatOpenSDK', '1.8.7.1' #微信开放平台SDK，小程序拉活预算
  pod 'fork-KlevinAdSDK', '2.3.0.222' #游可赢官网SDK

  pod 'LYAdSDK', '2.4.4' #LY预算
  pod 'LYAdSDKAdapterForCSJ', '2.4.3'
  pod 'LYAdSDKAdapterForGDT', '2.3.3'
  pod 'LYAdSDKAdapterForKS', '2.4.3'
  pod 'LYAdSDKAdapterForKSContent', '2.4.1.1'
  pod 'LYAdSDKAdapterForSIG', '2.4.1'
  pod 'LYAdSDKAdapterForIQY', '2.3.0'
  pod 'LYAdSDKAdapterForBD', '2.4.1'
  pod 'LYAdSDKAdapterForJD', '2.3.0'
  pod 'LYAdSDKAdapterForKLN', '2.4.1'

  pod 'XWAdSDK', '1.0.6' #小沃融合
  pod 'XWAdSDKAdapterForCSJ', '1.0.0.1' #小沃融合穿山甲
  pod 'XWAdSDKAdapterForGDT', '1.0.0.1' #小沃融合广点通
  pod 'XWAdSDKAdapterForKS', '1.0.1' #小沃融合快手
  pod 'XWAdSDKAdapterForSIG', '1.0.0.2' #小沃融合sigmob
  pod 'XWAdSDKAdapterForIQY', '1.0.0.1' #小沃融合爱奇艺
  pod 'XWAdSDKAdapterForBD', '1.0.0.1' #小沃融合百度
  pod 'XWAdSDKAdapterForJD', '1.0.0.1' #小沃融合JD
  pod 'XWAdSDKAdapterForLY', '1.0.0.1' #小沃融合LY

  project 'XWAdSDKDemo' #小沃融合DEMO
end
```

### 手动接入

请参考对应平台接入文档依次接入，最后将XWAdSDK.framework及对应Adapter的framework拖放到项目。[下载framework](DOWNLOAD.md)  

点击主工程 -> Build Settings -> 搜索Other Linker Flags -> 在列表中找到Other Linker Flags -> 添加参数-ObjC

### info.plist配置

#### http限制

在info.plist中添加 App Transport Security Settings 设定，由于苹果默认限制HTTP请求，需手动配置才可正常访问HTTP请求，SDK的API均已使用HTTPS但部分媒体资源需要使用HTTP TIPS：可以右击info.plist文件，选择Open As -> Source Code，然后将下列代码粘贴进去

```javascript
<key>NSAppTransportSecurity</key>
    <dict>
         <key>NSAllowsArbitraryLoads</key>
         <true/>
    </dict>
```

#### 关于 iOS 14 AppTrackingTransparency

在 iOS 14 设备上，建议您在应用启动时调用 apple 提供的 AppTrackingTransparency 方案，获取用户的 IDFA 授权，以便提供更精准的广告投放和收入优化

```javascript
<key>NSUserTrackingUsageDescription</key>
<string>需要获取您设备的广告标识符，以为您提供更好的广告体验</string>
```

权限请求窗口调用方法：`requestTrackingAuthorization(completionHandler:)`

## 接入代码

请向相关人员申请测试appId和slotId

### SDK版本号

```objectivec
// 例：2.0.0
NSLog(@"sdkVersion: %@", [XWAdSDKConfig sdkVersion]);
```

### 初始化

```objectivec
// userId在任何能获取到的时候都可以设置，最后一次设置会覆盖之前
[XWAdSDKConfig setUserId:@"媒体用户唯一ID，可以是脱敏后的需保证唯一"];
[XWAdSDKConfig initAppId:@"你的APPID"];
```

### 通知广告 XWNoticeAd

```objectivec
// XWNoticeAd代理
@protocol XWNoticeAdDelegate <NSObject>
// 加载成功回调
- (void)xw_noticeAdDidLoad:(XWNoticeAd *)noticeAd;
// 加载失败回调
- (void)xw_noticeAdDidFailToLoad:(XWNoticeAd *)noticeAd error:(NSError *)error;
// 曝光回调
- (void)xw_noticeAdDidExpose:(XWNoticeAd *)noticeAd;
// 点击回调
- (void)xw_noticeAdDidClick:(XWNoticeAd *)noticeAd;
// 关闭回调
- (void)xw_noticeAdDidClose:(XWNoticeAd *)noticeAd;
@end
```

```objectivec
// notice load
self.noticeAd = [[XWNoticeAd alloc] initWithSlotId:@"你的广告位ID"];
self.noticeAd.delegate = self;
[self.noticeAd loadAd];
...
// notice show
// 在收到xw_noticeAdDidLoad回调后调用show逻辑
[self.noticeAd showAdInWindow:[UIApplication sharedApplication].keyWindow];
```

### 开屏广告 XWSplashAd

```objectivec
// XWSplashAd代理
@protocol XWSplashAdDelegate <NSObject>
@optional
// 加载成功回调，在这之后调用show逻辑
- (void)xw_splashAdDidLoad:(XWSplashAd *)splashAd;
// 加载失败
- (void)xw_splashAdDidFailToLoad:(XWSplashAd *)splashAd error:(NSError *)error;
// 曝光回调
- (void)xw_splashAdDidExpose:(XWSplashAd *)splashAd;
// 点击回调
- (void)xw_splashAdDidClick:(XWSplashAd *)splashAd;
// 即将关闭回调
- (void)xw_splashAdWillClose:(XWSplashAd *)splashAd;
// 关闭回调
- (void)xw_splashAdDidClose:(XWSplashAd *)splashAd;
// 开屏倒计时回调
- (void)xw_splashAdLifeTime:(XWSplashAd *)splashAd time:(NSUInteger)time;
// 详情页关闭回调
- (void)xw_splashAdDidCloseOtherController:(XWSplashAd *)splashAd;

@end
```

```objectivec
// splash load
CGRect frame = [UIScreen mainScreen].bounds;
CGRect plashFrame = CGRectMake(0, 0, frame.size.width, frame.size.height);
if (...包含sigmob或者京东预算...) {
    // 其中self.rootController需要与showAdInWindow时window.rootViewController一致
    self.splashAd = [[XWSplashAd alloc] initWithFrame:splashFrame slotId:xw_splash_id viewController:self.rootController];
} else {
    self.splashAd = [[XWSplashAd alloc] initWithFrame:splashFrame slotId:@"你的广告位ID"];
}
self.splashAd.delegate = self;
[self.splashAd loadAd];
...
// splash show
// 在收到xw_splashAdDidLoad回调后调用show逻辑
if (...需要自定义底部logo...) {
    UILabel *bottomView = [[UILabel alloc] initWithFrame:bottomFrame];
    [bottomView setText:@"这是一个测试LOGO"];
    bottomView.backgroundColor = [UIColor redColor];
    [self.splashAd showAdInWindow:keyWindow withBottomView:bottomView];
} else {
    UIWindow *keyWindow = [UIApplication sharedApplication].windows.firstObject;
    [self.splashAd showAdInWindow:keyWindow];
}
```

### 信息流广告

#### 自渲染 XWNativeAd

```objectivec
// XWNativeAd代理
@protocol XWNativeAdDelegate <NSObject>
// 加载成功回调
- (void)xw_nativeAdDidLoad:(NSArray<XWNativeAdDataObject *> * _Nullable)nativeAdDataObjects error:(NSError * _Nullable)error;

@end
// XWNativeAdView代理
@protocol XWNativeAdViewDelegate <NSObject>
@optional
// 曝光回调
- (void)xw_nativeAdViewDidExpose:(XWNativeAdView *)nativeAdView;
// 点击回调
- (void)xw_nativeAdViewDidClick:(XWNativeAdView *)nativeAdView;
// 广告详情页关闭回调
- (void)xw_nativeAdViewDidCloseOtherController:(XWNativeAdView *)nativeAdView;
// 如果是视频广告，播放完成回调
- (void)xw_nativeAdViewMediaDidPlayFinish:(XWNativeAdView *)nativeAdView;
// 带关闭按钮的广告，用户点击后的回调
- (void)xw_nativeAdViewDislike:(XWNativeAdView *)nativeAdView;
@end
```

```objectivec
// native load
self.nativeAd = [[XWNativeAd alloc] initWithSlotId:@"你的广告位ID"];
self.nativeAd.delegate = self;
[self.nativeAd loadAdWithCount:3];// 支持1-3
...
// 渲染逻辑
self.adView = [[XWNativeAdView alloc] init];
self.adView.delegate = delegate; // adView 广告回调
self.adView.viewController = vc; // 跳转 VC
//重要，先调用refreshData，dataObject是XWNativeAdDataObject对象
[self.adView refreshData:dataObject];
...
省略 具体渲染逻辑，参见demo
...
//重要，最后调用registerDataObjectWithClickableViews注册可点击view
[self.adView registerDataObjectWithClickableViews:@[...]];
```

```objectivec
// XWNativeAdDataObject
typedef NS_ENUM(NSInteger, XWNativeAdCreativeType) {
    XWNativeAdCreativeType_ADX_NONE = (1 << 24) | 0,
    XWNativeAdCreativeType_ADX_TXT = (1 << 24) | 1,//TXT 纯文字
    XWNativeAdCreativeType_ADX_IMG = (1 << 24) | 2,//IMG 纯图片
    XWNativeAdCreativeType_ADX_HYBRID = (1 << 24) | 3,//HYBRID 图文混合
    XWNativeAdCreativeType_ADX_VIDEO = (1 << 24) | 4,//VIDEO 视频广告

    XWNativeAdCreativeType_GDT_isVideoAd = (2 << 24) | 2,//isVideoAd
    XWNativeAdCreativeType_GDT_isThreeImgsAd = (2 << 24) | 3,//isThreeImgsAd

    XWNativeAdCreativeType_CSJ_SmallImage = (3 << 24) | 2,
    XWNativeAdCreativeType_CSJ_LargeImage = (3 << 24) | 3,
    XWNativeAdCreativeType_CSJ_GroupImage = (3 << 24) | 4,
    XWNativeAdCreativeType_CSJ_VideoImage = (3 << 24) | 5,// video ad || rewarded video ad horizontal screen
    XWNativeAdCreativeType_CSJ_VideoPortrait = (3 << 24) | 15,// rewarded video ad vertical screen
    XWNativeAdCreativeType_CSJ_ImagePortrait = (3 << 24) | 16,
    XWNativeAdCreativeType_CSJ_SquareImage = (3 << 24) | 33,//SquareImage Currently it exists only in the oversea now. V3200 add
    XWNativeAdCreativeType_CSJ_SquareVideo = (3 << 24) | 50,//SquareVideo Currently it exists only in the oversea now. V3200 add
};

@interface XWNativeAdDataObject : NSObject
@property (nonatomic, copy, readonly) NSString *title;
@property (nonatomic, copy, readonly) NSString *desc;
@property (nonatomic, copy, readonly) NSString *imageUrl;
@property (nonatomic, readonly) NSInteger imageWidth;
@property (nonatomic, readonly) NSInteger imageHeight;
@property (nonatomic, copy, readonly) NSString *iconUrl;
@property (nonatomic, copy, readonly) NSArray *imageUrls;
// 创意类型，返回XWNativeAdCreativeType中的值
@property (nonatomic, readonly) XWNativeAdCreativeType creativeType;
@property (nonatomic, strong) XWVideoConfig *videoConfig;
@end
```

#### 模板渲染 XWNativeExpressAd

```objectivec
// XWNativeExpressAd代理
@protocol XWNativeExpressAdDelegate <NSObject>
// 广告加载成功回调
- (void)xw_nativeExpressAdDidLoad:(NSArray<XWNativeExpressAdRelatedView *> * _Nullable)nativeExpressAdRelatedViews error:(NSError * _Nullable)error;
@end
// XWNativeExpressAdRelatedView代理
@protocol XWNativeExpressAdRelatedViewDelegate <NSObject>
@optional
// 渲染成功回调
- (void)xw_nativeExpressAdRelatedViewDidRenderSuccess:(XWNativeExpressAdRelatedView *)nativeExpressAdRelatedView;
// 渲染失败回调
- (void)xw_nativeExpressAdRelatedViewDidRenderFail:(XWNativeExpressAdRelatedView *)nativeExpressAdRelatedView;
// 曝光回调
- (void)xw_nativeExpressAdRelatedViewDidExpose:(XWNativeExpressAdRelatedView *)nativeExpressAdRelatedView;
// 点击回调
- (void)xw_nativeExpressAdRelatedViewDidClick:(XWNativeExpressAdRelatedView *)nativeExpressAdRelatedView;
// 广告详情页关闭回调
- (void)xw_nativeExpressAdRelatedViewDidCloseOtherController:(XWNativeExpressAdRelatedView *)nativeExpressAdRelatedView;
// 带关闭按钮的广告，用户点击关闭时回调
- (void)xw_nativeExpressAdRelatedViewDislike:(XWNativeExpressAdRelatedView *)nativeExpressAdRelatedView;
@end
```

```objectivec
// native express load
self.nativeExpressAd = [[XWNativeExpressAd alloc] initWithSlotId:@"你的广告位ID" adSize:CGSizeMake(width, 0)];
self.nativeExpressAd.delegate = self;
[self.nativeExpressAd loadAdWithCount:3]; // 支持，1-3
...
// 广告加载成功后，调用render
XWNativeExpressAdRelatedView *relatedView = (XWNativeExpressAdRelatedView *)obj;
relatedView.delegate = self;
relatedView.viewController = self;
[relatedView render];
...
// 渲染成功后，通过getAdView拿到广告View，添加到界面上
UIView *view = [[self.expressAdRelatedViews objectAtIndex:indexPath.row] getAdView];
```

### 激励视频广告 XWRewardVideoAd

```objectivec
@protocol XWRewardVideoAdDelegate <NSObject>
@optional
// 加载成功回调
- (void)xw_rewardVideoAdDidLoad:(XWRewardVideoAd *)rewardVideoAd;
// 加载失败回调
- (void)xw_rewardVideoAdDidFailToLoad:(XWRewardVideoAd *)rewardVideoAd error:(NSError *)error;
// 激励视频缓存成功
- (void)xw_rewardVideoAdDidCache:(XWRewardVideoAd *)rewardVideoAd;
// 曝光回调
- (void)xw_rewardVideoAdDidExpose:(XWRewardVideoAd *)rewardVideoAd;
// 点击回调
- (void)xw_rewardVideoAdDidClick:(XWRewardVideoAd *)rewardVideoAd;
// 关闭回调
- (void)xw_rewardVideoAdDidClose:(XWRewardVideoAd *)rewardVideoAd;
// 播放完成回调
- (void)xw_rewardVideoAdDidPlayFinish:(XWRewardVideoAd *)rewardVideoAd;
// 奖励回调
- (void)xw_rewardVideoAdDidRewardEffective:(XWRewardVideoAd *)rewardVideoAd trackUid:(NSString *) trackUid;
@end
```

```objectivec
// 激励视频 load
// 重要，如需服务器回调则需保证setUserId在调用激励视频之前设置
// [XWAdSDKConfig setUserId:@"媒体用户唯一ID，可以是脱敏后的需保证唯一"];
if (...需要服务验证，且有拓展参数需要原样返回...) {
    //非必要，需服务器验证时extra原样回调到媒体服务器
    self.rewardedAd = [[XWRewardVideoAd alloc] initWithSlotId:@"你的广告位ID" extra:@"非必要拓展参数"];
} else {
    self.rewardedAd = [[XWRewardVideoAd alloc] initWithSlotId:@"你的广告位ID"];
}
self.rewardedAd.delegate = self;
[self.rewardedAd loadAd];
...
// 激励视频 show，建议在收到xw_rewardVideoAdDidCache回调后调用
[self.rewardedAd showAdFromRootViewController:self];
```

### 插屏广告 XWInterstitialAd

```objectivec
//XWInterstitialAd代理
@protocol XWInterstitialAdDelegate <NSObject>
@optional
// 加载成功回调
- (void)xw_interstitialAdDidLoad:(XWInterstitialAd *)interstitialAd;
// 加载失败回调
- (void)xw_interstitialAdDidFailToLoad:(XWInterstitialAd *)interstitialAd error:(NSError *)error;
// 曝光回调
- (void)xw_interstitialAdDidExpose:(XWInterstitialAd *)interstitialAd;
// 点击回调
- (void)xw_interstitialAdDidClick:(XWInterstitialAd *)interstitialAd;
// 关闭回调
- (void)xw_interstitialAdDidClose:(XWInterstitialAd *)interstitialAd;
@end
```

```objectivec
// interstitial load
CGSize adSize = CGSizeMake(300, 450);
self.interstitial = [[XWInterstitialAd alloc] initWithSlotId:@"你的广告位ID" adSize:adSize];
self.interstitial.delegate = self;
[self.interstitial loadAd];
...
// interstitial show，在收到加载成功回调之后调用show方法
[self.interstitial showAdFromRootViewController:self];
```

### Banner广告 XWBannerAdView

```objectivec
// XWBannerAdView代理
@protocol XWBannerAdViewDelegate <NSObject>
@optional
// 加载成功回调
- (void)xw_bannerAdViewDidLoad:(XWBannerAdView *)bannerAd;
// 加载失败回调
- (void)xw_bannerAdViewDidFailToLoad:(XWBannerAdView *)bannerAd error:(NSError *)error;
// 曝光回调
- (void)xw_bannerAdViewDidExpose:(XWBannerAdView *)bannerAd;
// 点击回调
- (void)xw_bannerAdViewDidClick:(XWBannerAdView *)bannerAd;
// 关闭回调
- (void)xw_bannerAdViewDidClose:(XWBannerAdView *)bannerAd;
@end
```

```objectivec
// banner load
self.bannerView = [[XWBannerAdView alloc] initWithFrame:frame slotId:@"你的广告位ID" viewController:self];
self.bannerView.delegate = self;
[self.bannerView loadAd];
...
// 在xw_bannerAdViewDidLoad回调之后，将bannerView添加到界面上
[self.view addSubview:self.bannerView];
```

### 全屏视频广告 XWFullScreenVideoAd

```objectivec
// XWFullScreenVideoAd代理
@protocol XWFullScreenVideoAdDelegate <NSObject>
@optional
// 加载成功回调
- (void)xw_fullScreenVideoAdDidLoad:(XWFullScreenVideoAd *)fullScreenVideoAd;
// 加载失败回调
- (void)xw_fullScreenVideoAdDidFailToLoad:(XWFullScreenVideoAd *)fullScreenVideoAd error:(NSError *)error;
// 视频缓存成功
- (void)xw_fullScreenVideoAdDidCache:(XWFullScreenVideoAd *)fullScreenVideoAd;
// 曝光回调
- (void)xw_fullScreenVideoAdDidExpose:(XWFullScreenVideoAd *)fullScreenVideoAd;
// 点击回调
- (void)xw_fullScreenVideoAdDidClick:(XWFullScreenVideoAd *)fullScreenVideoAd;
// 关闭回调
- (void)xw_fullScreenVideoAdDidClose:(XWFullScreenVideoAd *)fullScreenVideoAd;
// 播放完成回调
- (void)xw_fullScreenVideoAdDidPlayFinish:(XWFullScreenVideoAd *)fullScreenVideoAd;
// 跳过回调
- (void)xw_fullScreenVideoAdDidClickSkip:(XWFullScreenVideoAd *)fullScreenVideoAd;
@end
```

```objectivec
// 全屏视频 load
self.fullScreenVideoAd = [[XWFullScreenVideoAd alloc] initWithSlotId:@"你的广告位ID"];
self.fullScreenVideoAd.delegate = self;
...
[self.fullScreenVideoAd loadAd];
...
// 全屏视频 show，建议在收到xw_fullScreenVideoAdDidCache回调后调用
[self.fullScreenVideoAd showAdFromRootViewController:self];
```

### Draw视频广告 XWDrawVideoAd

```objectivec
// XWDrawVideoAd代理
@protocol XWDrawVideoAdDelegate <NSObject>
// 广告加载成功回调
- (void)xw_drawVideoAdDidLoad:(NSArray<XWDrawVideoAdRelatedView *> * _Nullable) drawVideoAdRelatedViews error:(NSError * _Nullable) error;
@end
// XWDrawVideoAdRelatedView代理
@protocol XWDrawVideoAdRelatedViewDelegate <NSObject>
@optional
// 曝光回调
- (void)xw_drawVideoAdRelatedViewDidExpose:(XWDrawVideoAdRelatedView *)drawVideoAdRelatedView;
// 点击回调
- (void)xw_drawVideoAdRelatedViewDidClick:(XWDrawVideoAdRelatedView *)drawVideoAdRelatedView;
// 广告详情页关闭回调
- (void)xw_drawVideoAdRelatedViewDidCloseOtherController:(XWDrawVideoAdRelatedView *)drawVideoAdRelatedView;
// 视频播放完成回调
- (void)xw_drawVideoAdRelatedViewDidPlayFinish:(XWDrawVideoAdRelatedView *)drawVideoAdRelatedView;
@end
```

```objectivec
// draw load
self.drawVideoAd = [[XWDrawVideoAd alloc] initWithSlotId:@"你的广告位ID" adSize:[[UIScreen mainScreen] bounds].size];
self.drawVideoAd.delegate = self;
[self.drawVideoAd loadAdWithCount:3];
...
// 广告加载成功后，设置delegate及viewController
XWDrawVideoAdRelatedView *relatedView = (XWDrawVideoAdRelatedView *)obj;
relatedView.delegate = self;
relatedView.viewController = self;
...
// 调用registerContainer将广告展示到界面
[self.relatedView registerContainer:self.contentView];
...
// cell复用时调用unregisterView
[self.relatedView unregisterView];
```

### 视频内容 XWContentPage

```objectivec
// XWContentPage代理
@protocol XWContentPageDelegate <NSObject>
@optional
// 加载成功回调
- (void)xw_contentPageDidLoad:(XWContentPage *)entryElement;
// 加载失败回调
- (void)xw_contentPageDidFailToLoad:(XWContentPage *)entryElement error:(NSError *)error;
@end
// 内容页相关回调
@protocol XWContentPageContentDelegate <NSObject>
@optional
- (void)xw_contentPageContentDidFullDisplay:(XWContentPage *)entryElement contentInfo:(XWContentInfo *) contentInfo;
- (void)xw_contentPageContentDidEndDisplay:(XWContentPage *)entryElement contentInfo:(XWContentInfo *) contentInfo;
- (void)xw_contentPageContentDidPause:(XWContentPage *)entryElement contentInfo:(XWContentInfo *) contentInfo;
- (void)xw_contentPageContentDidResume:(XWContentPage *)entryElement contentInfo:(XWContentInfo *) contentInfo;
@end
// 内容页视频相关回调
@protocol XWContentPageVideoDelegate <NSObject>
@optional
- (void)xw_contentPageVideoDidStartPlay:(XWContentPage *)entryElement contentInfo:(XWContentInfo *) contentInfo;
- (void)xw_contentPageVideoDidPause:(XWContentPage *)entryElement contentInfo:(XWContentInfo *) contentInfo;
- (void)xw_contentPageVideoDidResume:(XWContentPage *)entryElement contentInfo:(XWContentInfo *) contentInfo;
- (void)xw_contentPageVideoDidEndPlay:(XWContentPage *)entryElement contentInfo:(XWContentInfo *) contentInfo;
- (void)xw_contentPageVideoDidFailToPlay:(XWContentPage *)entryElement contentInfo:(XWContentInfo *) contentInfo error:(NSError *)error;
@end
```

```objectivec
// content load
self.contentPage = [[XWContentPage alloc] initWithSlotId:@"你的广告"];
self.contentPage.delegate = self;
self.contentPage.contentDelegate = self;
self.contentPage.videoDelegate = self;
// addChildViewController、addSubview后开始加载内容
UIViewController * vc = self.contentPage.viewController;
[self addChildViewController:vc];
vc.view.frame = frame;
[self.view addSubview:vc.view]; 
```

```objectivec
// XWContentInfo
typedef NS_ENUM(NSUInteger, XWContentType) {
    XWContentTypeUnknown,         //未知，正常不会出现
    XWContentTypeNormal,          //普通信息流
    XWContentTypeAd,              //SDK内部广告
};
@interface XWContentInfo : NSObject
//内容标识
@property (nonatomic, copy, readonly) NSString *contentId;
//内容类型
@property (nonatomic, readonly) XWContentType contentType;
//视频时长. 毫秒
@property (nonatomic, readonly) NSTimeInterval videoDuration;
@end
```

### 入口组件 XWEntryElement

参考demo

## 注意

如果要接入微信小程序唤起广告，一定要注意在AppDelegate中加入这段代码，不然会出现调起微信之后又回到APP中，无法真正调起小程序。

```objectivec
- (BOOL)application:(UIApplication *)application continueUserActivity:(nonnull NSUserActivity *)userActivity restorationHandler:(nonnull void (^)(NSArray<id<UIUserActivityRestoring>> * _Nullable))restorationHandler {
    if (...媒体自己处理微信回调...) {
        return [WXApi handleOpenUniversalLink:userActivity delegate:self];
    } else {
        // 由SDK处理
        return [XWAdSDKConfig handleOpenUniversalLink:userActivity];
    }
}
```
