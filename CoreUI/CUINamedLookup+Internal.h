//
//  CUINamedLookup+Internal.h
//  CoreUI
//
//  Audited for macOS 15.0
//  Status: Complete

#import <CoreUI/CUINamedLookup.h>
#import <CoreUI/CUIThemeRendition.h>
#import <os/lock.h>

CF_ASSUME_NONNULL_BEGIN

@interface CUINamedLookup () {
    NSString *_signature; // offset: 24
    uint32_t _distilledInVersion; // offset: 40
    os_unfair_lock _lock; // offset: 44
    uint8_t _odContent : 1; // offset: 48
}

@property (readonly, nonatomic) CUIThemeRendition *_rendition;
@property (readonly, nonatomic) BOOL _cacheRenditionProperties;
@property (readonly, nonatomic) uint32_t _distilledInVersion;

- (CUIThemeRendition *)_renditionForSpecificKey:(CUIRenditionKey *)specificKey;

@end

CF_ASSUME_NONNULL_END
