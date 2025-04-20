//
//  CUIStructuredThemeStore.m
//  CoreUI
//
//  Audited for macOS 15.0
//  Status: WIP

#import "CUIStructuredThemeStore+Internal.h"
#import <os/lock.h>

@interface CUIStructuredThemeStore () {
    NSMutableDictionary *_cache; // offset: 8
    CUICommonAssetStorage *_store; // offset: 16
    os_unfair_lock _cacheLock; // offset: 24
    os_unfair_lock _storeLock; // offset: 28
    NSUInteger _themeIndex; // offset: 32
    NSString *_bundleID; // offset: 40
    NSCache *_namedRenditionKeyCache; // offset: 48
    void /* function */ *_attributePresent; // offset: 56
    BOOL _mainBundle : 1; // offset: 64
    NSDictionary *_aliasDictionary; // offset: 72
    NSSet *_legacyFlippableSet; // offset: 80
    NSCache *_nameCache; // offset: 88
}

@end

@implementation CUIStructuredThemeStore

@end
