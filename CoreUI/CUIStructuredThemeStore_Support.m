//
//  CUIStructuredThemeStore_Support.c
//  CoreUI
//
//  Audited for macOS 15.0
//  Status: WIP

#import "CUIStructuredThemeStore_Support.h"
#import <os/lock.h>
#import "CUILog.h"

CUIStructuredThemeStore *gThemeProvider = nil;

void __PerformBlockWithThemeRegistry(void(^block)(NSMapTable *table)) {
    static dispatch_once_t onceToken;
    static os_unfair_lock lock;
    static NSMapTable *themeRegistry = nil;
    dispatch_once(&onceToken, ^{
        themeRegistry = NSCreateMapTable(NSIntegerMapKeyCallBacks, NSObjectMapValueCallBacks, 0);
        lock = OS_UNFAIR_LOCK_INIT;
    });
    
    os_unfair_lock_lock(&lock);
    block(themeRegistry);
    os_unfair_lock_unlock(&lock);
    
}

CUIStructuredThemeStore * _LookupThemeProvider(NSUInteger strongRef) {
    if (strongRef) {
        __block CUIStructuredThemeStore *themeProvider = nil;
        __PerformBlockWithThemeRegistry(^(NSMapTable *table) {
            themeProvider = (__bridge CUIStructuredThemeStore *)(NSMapGet(table, (const void *)strongRef));
        });
        if (!themeProvider) {
            _CUILog(CUILogLevelError, "CoreUI: CUIThemeStore: No theme registered with id=%lu", strongRef);
        }
        return themeProvider;
    } else {
        if (!gThemeProvider) {
            gThemeProvider = [[NSClassFromString(@"CUISystemStore") alloc] init];
        }
        return gThemeProvider;
    }
}

CUIStructuredThemeStore * _LookupStructuredThemeProvider(NSUInteger strongRef) {
    return _LookupThemeProvider(strongRef);
}
