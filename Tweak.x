// Original codes are from YTMusicUltimate + My research from YTM 9.10.3
// Remove ads + Premium promotions and Allows background playback

#import <Foundation/Foundation.h>

@interface YTIPivotBarItemRenderer : NSObject
@property(copy, nonatomic) NSString *pivotIdentifier;
- (NSString *)pivotIdentifier;
@end

@interface YTIPivotBarSupportedRenderers : NSObject
@property(retain, nonatomic) YTIPivotBarItemRenderer *pivotBarItemRenderer;
- (YTIPivotBarItemRenderer *)pivotBarItemRenderer;
@end

@interface YTIPivotBarRenderer : NSObject
- (NSMutableArray <YTIPivotBarSupportedRenderers *> *)itemsArray;
@end

@interface YTMWatchViewController : NSObject
@end

%hook YTAdsInnerTubeContextDecorator
- (void)decorateContext:(id)arg1 {}
%end

%hook YTAdShieldUtils
- (id)spamSignalsDictionary { return nil; }
- (id)spamSignalsDictionaryWithoutIDFA { return nil; }
%end

%hook YTDataUtils
- (id)spamSignalsDictionary { return nil; }
%end

%hook YTIPlayerResponse
- (BOOL)isMonetized { return NO; }
- (id)paidContentOverlayElementRendererOptions { return nil; }
- (BOOL)isCuepointAdsEnabled { return NO; }
- (id)adIntroRenderer { return nil; }
- (BOOL)isDAIEnabledPlayback { return YES; }
- (id)backgroundUpsell { return nil; }
- (id)ytm_audioOnlyUpsell { return nil; }
- (id)offlineUpsell { return nil; }
%end

// Try to remove YT premium promotions 
%hook YCHLiveChatActionPanelView
- (void)setUpsellButton:(id)arg1 {}
- (id)upsellButton { return nil; }
- (BOOL)shouldShowUpsellButton { return NO; }
%end

%hook YTColdConfig
- (BOOL)iosEnableHighQualityAudioAppSettingsPremiumUpsell { return NO; }
- (BOOL)musicPlaybackClientConfigEnableMusicPremiumUpsellForAvButton { return NO; }
- (BOOL)cxClientDisableMementoPromotions { return YES; }
- (BOOL)iosEnableNewPromoForcingSettingsPage { return NO; }
- (BOOL)iosEnablePromoSkoverlay { return NO; }
- (BOOL)mainAppCoreClientIosHidePromoSheetOnKeyboardShown { return YES; }
- (BOOL)queueClientGlobalConfigIosEnableElementRendererPromoInQueue { return NO; }
- (BOOL)isPassiveSignInUniquePremiumValuePropEnabled { return YES; }
- (void)setIsPassiveSignInUniquePremiumValuePropEnabled:(BOOL)enabled { %orig(YES); }
- (BOOL)musicClientConfigIosEnableMobileAudioTierLockscreenControls { return YES; }
- (BOOL)enableYouthereCommandsOnIos { return NO; }
%end

%hook YTCreateCommentAccessoryView
- (id)emojiPickerUpsellCategoryRenderer { return nil; }
- (void)setEmojiPickerUpsellCategoryRenderer:(id)arg1 {}
%end

%hook YTDownloadsPageViewConfigurationEntityModel
- (id)downloadsUpsellBannerVisibility { return nil; }
- (void)setDownloadsUpsellBannerVisibility:(id)arg1 {}
%end

%hook YTIBackgroundabilityRenderer
- (id)backgroundUpsell { return nil; }
%end

%hook YTIPlayabilityStatus
- (id)backgroundUpsell { return nil; }
- (id)offlineUpsell { return nil; }
- (BOOL)isPlayableInBackground { return YES; }
- (void)setIsPlayableInBackground:(BOOL)backgroundable { %orig(YES); }
%end

%hook YTPlaybackData
- (BOOL)isPlayableInBackground { return YES; }
%end

%hook YTMMusicAppMetadata
- (BOOL)canPlayBackgroundableContent { return YES; }
%end

%hook YTLocalPlaybackController
- (BOOL)isPlaybackBackgroundable { return YES; }
%end

%hook YTMAppDelegate
- (void)showUpsellAlertWithTitle:(id)title subtitle:(id)subtitle upgradeButtonTitle:(id)upgradeTitle upsellURLString:(id)URL sourceApplication:(id)source {}
%end

%hook YTMUpsellDialogController
- (void)fillAlertViewWithUpsell:(id)upsell {}
- (void)showUpsellDialogWithUpsell:(id)upsell upsellParentResponder:(id)responder {}
- (void)showUpsellDialogWithUpsell:(id)upsell videoID:(id)ID toastType:(long long)type upsellParentResponder:(id)reponder shouldDismissOnBackgroundTap:(BOOL)shouldDismissOnBackgroundTap {}
- (void)showUpsellDialogWithUpsellResponderEvent:(id)responderevent {}
%end

%hook YTMIntegrationsSettingsViewController
- (void)showUpsellingDialog {}
- (void)showPromotionScreen {}
%end

%hook YTMCastSessionControllerImpl
- (void)showAudioCastUpsellDialog {}
%end

%hook YTMAppResponderImpl
- (void)setUpsellDialogController:(id)arg {}
- (id)upsellDialogController { return nil; }
- (void)presentFullscreenPromoForEvent:(id)arg {}
- (void)presentInterstitialGridPromoForEvent:(id)arg {}
- (void)presentInterstitialPromoForEvent:(id)arg {}
- (void)setOfflineButtonPromoController:(id)arg {}
- (id)offlineButtonPromoController { return nil; }
- (void)executeCommandWrapperPromoRenderer:(id)arg1 firstResponder:(id)arg2 {}
- (BOOL)shouldMealbarPromoController:(id)arg1 displayConnectionStatusMealbar:(id)arg2 hasContentDownloaded:(BOOL)arg3 { return NO; }
%end

%hook MDXFeatureFlags
- (BOOL)areMementoPromotionsEnabled { return NO; }
- (void)setAreMementoPromotionsEnabled:(BOOL)enabled { %orig(NO); }
%end

%hook MDXPromotionManager
- (void)presentMementoPromotion:(long long)arg1 {}
- (void)presentMementoPromotionIfTriggerConditionsAreSatisfied {}
%end

// %hook YTAdBaseVideoPlayerOverlayViewController
// - (void)playbackRouteButtonWillShowPromotion {}
// %end

// Remove Upgrade button
%hook YTPivotBarView
- (void)setRenderer:(YTIPivotBarRenderer *)renderer {
    NSMutableArray <YTIPivotBarSupportedRenderers *> *items = [renderer itemsArray];
    NSUInteger index = [items indexOfObjectPassingTest:^BOOL(YTIPivotBarSupportedRenderers *renderers, NSUInteger idx, BOOL *stop) {
        return [[[renderers pivotBarItemRenderer] pivotIdentifier] isEqualToString:@"SPunlimited"];
    }];
    if (index != NSNotFound) [items removeObjectAtIndex:index];
    %orig;
}
%end

// %hook YTHintController
// - (void)sendPromoEventWithAccept:(BOOL)arg1 sendClick:(BOOL)arg2 {}
// %end

%hook YTIInStreamPlayerCtaAdsSupportedRenderers
- (BOOL)hasAppPromoAdCtaRenderer { return NO; }
%end

%hook YTIRenderer
- (BOOL)hasAppPromoAdCtaRenderer { return NO; }
- (id)appPromoAdCtaRenderer { return nil; }
%end

%hook YTShareMainView
- (BOOL)shouldShowPromo { return NO; }
- (void)setPromoView:(id)arg1 {}
%end

%hook YTShareMainViewController
- (void)addPromoViewController {}
- (void)sharePanelPromoViewController:(id)arg1 dismissWithDismissalExpiryMs:(long long)arg2 onDismissTitleLink:(id)arg3 {}
%end

%hook YTSharePanelPromoViewController
- (id)promoView { return nil; }
%end

%hook YTSurveyPromosheet
- (id)expandablePromosheetDelegate { return nil; }
- (void)setExpandablePromosheetDelegate:(id)arg1 {}
%end

%hook YTQueueController
- (void)promoteAutoplayItemsAtIndexPaths:(id)arg1 userTriggered:(BOOL)arg2 {}
%end

%hook YTPromoThrottleControllerImpl
- (BOOL)canShowThrottledPromo { return NO; }
%end

// Global hook (For many class that have the same functions)
%hook NSObject
- (void)setPromotedRenderer:(id)arg1 {}
- (void)setPromoRenderer:(id)arg1 {}
%end

%hook YTPromosheetController
- (void)addPromosheetControllerObserver:(id)arg {}
- (void)presentPromosheetWithEvent:(id)arg {}
- (BOOL)canPresentPromosheetWithGlobalThrottling:(BOOL)arg1 customizedThrottling:(id)arg2 shouldReplacePromosheet:(BOOL)arg3 { return NO; }
%end

%hook YTPromosheetContainerView
- (void)setPromosheet:(id)arg {}
- (void)setPromosheet:(id)arg1 animated:(BOOL)arg2 completion:(id)arg3 {}
- (void)setPromosheetDisplayed:(BOOL)arg {}
%end

%hook YTOfflineButtonPromoController
- (void)showOfflinePromoWithRenderer:(id)arg1 endpoint:(id)arg2 parentResponder:(id)arg3 {}
%end

%hook YTMXSDKContentController
- (BOOL)shouldDisplayUpsell { return NO; }
- (void)parseUpsellPromotionInfos:(id)arg {}
%end

%hook YTMAppMealbarPromoController
- (id)mealbarPromoController { return nil; }
- (void)setMealbarPromoController:(id)arg {}
- (void)setMealbarPromoRendererButtonColors:(id)arg {}
%end

%hook YTMNavigationImpl
- (void)presentPromosheetWithEvent:(id)arg {}
- (id)mealbarPromoController { return nil; }
%end

%hook YTMInterstitialPromoViewControllerImpl
- (void)showInterstitialPromo:(id)arg1 interstitialParentResponder:(id)arg2 {}
%end

%hook YTMConnectivityMealbarControllerImpl
- (void)showMealbarPromoRenderer:(id)arg1 hasContentDownloaded:(BOOL)arg2 {}
%end

%hook YTMContentViewController
- (void)presentPromosheetWithEvent:(id)arg {}
%end

%hook YTMealbarPromoController
- (void)showMealbarPromoWithEvent:(id)arg {}
%end

%hook YTInterstitialPromoViewController
- (void)showInterstitialPromo:(id)arg1 interstitialParentResponder:(id)arg2 {}
- (id)interstitialPromoView { return nil; }
- (void)showInterstitialPromo:(id)arg1 enableClientImpressionThrottling:(BOOL)arg2 interstitialParentResponder:(id)arg3 {}
%end

%hook YTPlayerPromoController
- (void)showBackgroundabilityUpsell {}
- (void)showBackgroundOnboardingHint {}
- (void)showPipOnboardingHint {}
%end

%hook YTMMusicAppMetadata
- (BOOL)isPremiumSubscriber { return YES; }
- (void)setIsPremiumSubscriber:(BOOL)premium { %orig(YES); }
- (id)sidePanelPromo { return nil; }
- (id)unlimitedSettingsButton { return nil; }
- (BOOL)isMobileAudioTier { return YES; }
%end

%hook YTIShowFullscreenInterstitialCommand
- (BOOL)shouldThrottleInterstitial { return YES; }
- (void)setShouldThrottleInterstitial:(BOOL)throttle { %orig(YES); }
%end

%hook YTMAppResponder
- (void)presentInterstitialPromoForEvent:(id)event {}
- (void)presentFullscreenPromoForEvent:(id)event {}
- (void)presentInterstitialGridPromoForEvent:(id)event {}
%end

%hook YTMCarPlayController
- (BOOL)isPremiumSubscriber { return YES; }
- (void)setIsPremiumSubscriber:(BOOL)premium { %orig(YES); }
%end

%hook YTMYPCGetOfflineUpsellEndpointCommandHandler
- (BOOL)isPremiumSubscriber { return YES; }
- (void)setIsPremiumSubscriber:(BOOL)premium { %orig(YES); }
%end

%hook YTMWAWatchAppConfig
- (BOOL)isCurrentUserPremium { return YES; }
- (BOOL)isCurrentUserMobileAudioTier { return YES; }
%end

%hook YTMWatchViewController
- (id)init {
    self = %orig;
    if (self) {
        [self setValue:[NSNumber numberWithBool:YES] forKey:@"_isMobileAudioTierMode"];
    }
    return self;
}
%end

%hook YTMQueueCollectionViewController
- (BOOL)isMobileAudioTierQueue { return YES; }
%end

%hook YTUserDefaults
- (BOOL)hasOnboarded { return YES; }
- (BOOL)isPromoForced { return NO; }
%end

%hook YTCommonUtils
- (BOOL)isInternallyDistributedBuild { return YES; }
- (BOOL)isOfflineToDownloadsEnabled { return YES; }
- (BOOL)isUnitOrFunctionalTesting { return YES; }
- (BOOL)isEarlGreyV2FunctionalTesting { return YES; }
- (BOOL)isUnitTesting { return YES; }
- (BOOL)isFunctionalTesting { return YES; }
- (BOOL)isDistributedBuild { return NO; }
%end

%hook YTMYPCGetOfflineUpsellEndpointCommandHandlerImpl
- (BOOL)isPremiumSubscriber { return YES; }
%end

%hook YTMCarPlayControllerImpl
- (BOOL)isPremiumSubscriber { return YES; }
- (void)setPremiumSubscriber:(BOOL)arg1 { %orig(YES); }
%end

%hook YTMMusicAppMetadataImpl
- (BOOL)isPremiumSubscriber { return YES; }
- (BOOL)isMobileAudioTier { return YES; }
- (id)sidePanelPromo { return nil; }
- (BOOL)canPlayBackgroundableContent { return YES; }
%end

%hook YTMQueueConfigImpl
- (BOOL)isMobileAudioTierScreenedCastEnabled { return YES; }
%end

// Unlimited listening - YouAreThere (https://github.com/PoomSmart/YouAreThere)
%hook YTYouThereController
- (BOOL)shouldShowYouTherePrompt { return NO; }
- (void)showYouTherePrompt {}
%end

%hook YTYouThereControllerImpl
- (BOOL)shouldShowYouTherePrompt { return NO; }
- (void)showYouTherePrompt {}
%end
