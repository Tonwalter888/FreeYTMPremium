// Original codes are from YTMusicUltimate + My research from YTM 9.10.3
// Remove ads + Premium promotions and Allows background playback
%hook YTAdsInnerTubeContextDecorator
- (void)decorateContext:(id)arg1 {}
%end

%hook YTAdShieldUtils
- (id)spamSignalsDictionary { return nil; }
- (id)spamSignalsDictionaryWithoutIDFA { return nil; }
%end

%hook YTDataUtils
+ (id)spamSignalsDictionary { return nil; }
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

%hook YTMMusicAppMetadataImpl
- (BOOL)canPlayBackgroundableContent { return YES; }
%end

%hook YTMMusicAppMetadata
- (BOOL)canPlayBackgroundableContent { return YES; }
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

%hook YTMXSDKContentController
- (BOOL)shouldDisplayUpsell { return NO; }
%end

%hook YTMIntegrationsSettingsViewController
- (void)showUpsellingDialog {}
%end

%hook YTMCastSessionControllerImpl
- (void)showAudioCastUpsellDialog {}
%end

%hook YTMAppResponderImpl
- (void)setUpsellDialogController:(id)arg {}
- (id)upsellDialogController { return nil; }
%end