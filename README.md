# FreeYTMPremium
Unlock YouTube Premium features for YouTube Music.

Last updated: 17 March 2026

## Features
- Remove music ads and Premium promotions popups
- Allows background playback
- Can switch between Song and Video freely

## Known Issue
Download music doesn't work.

**NOTE:** This repo is **ONLY** for unlock YouTube Premium features only. If you want more features than these, please fork this repo and add your features.

## Building
1. Clone [Theos](https://github.com/theos/theos) along with its submodules.
2. Clone and copy [iOS 18.6 SDK](https://github.com/Tonwalter888/iOS-SDKs) to ``$THEOS/sdks``.
3. Clone [YouTubeHeader](https://github.com/PoomSmart/YouTubeHeader) into ``$THEOS/include``.
4. Clone FreeYTMPremium, cd into it and run
- ``make clean package DEBUG=0 FINALPACKAGE=1`` For rootful jailbroken iOS (iOS >15 - checkra1n, Cydia)
- ``make clean package DEBUG=0 FINALPACKAGE=1 THEOS_PACKAGE_SCHEME=rootless`` For rootless jailbroken iOS (iOS 15+ - palera1n, Sileo, Zebra, Dolpamine, bakera1n, TrollStore)
- ``make clean package DEBUG=0 FINALPACKAGE=1 THEOS_PACKAGE_SCHEME=roothide`` For roothide jailbroken iOS (iOS 15 - Dolpamine, Bootstrap)