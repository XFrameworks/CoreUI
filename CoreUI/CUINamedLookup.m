//
//  CUINamedLookup.m
//  CoreUI
//
//  Audited for macOS 15.0
//  Status: Complete

#import "CUINamedLookup+Internal.h"
#import "CUILog.h"
#import "CUIRenditionKey+Internal.h"
#import "CUIStructuredThemeStore+Internal.h"
#import "CUIThemeRendition+Internal.h"
#import "CUIThemeRendition_Support.h"
#import "CUIStructuredThemeStore_Support.h"

@implementation CUINamedLookup

- (nullable instancetype)initWithName:(NSString *)name usingRenditionKey:(CUIRenditionKey *)renditionKey fromTheme:(NSUInteger)theme {
    self = [super init];
    if (self) {
        _name = [name copy];
        _key = [renditionKey copy];
        _storageRef = theme;
        if (self._cacheRenditionProperties) {
            _lock = OS_UNFAIR_LOCK_INIT;
        } else {
            _CUILog(CUILogLevelError, "CoreUI: unable to locate asset '%@' key:%@ releasing", name, self.key);
            return nil;
        }
    }
    return self;
}

- (BOOL)_cacheRenditionProperties {
    CUIStructuredThemeStore *themeProvider = _LookupStructuredThemeProvider(_storageRef);
    _signature = [themeProvider copyLookupKeySignatureForKey:_key.keyList];
    _distilledInVersion = [themeProvider distilledInCoreUIVersion];
    return YES;
}

- (CUIThemeRendition *)_rendition {
    return [self _renditionForSpecificKey:_key];
}

- (CUIThemeRendition *)_renditionForSpecificKey:(CUIRenditionKey *)specificKey {
    CUIStructuredThemeStore *themeProvider = _LookupStructuredThemeProvider(_storageRef);
    return [themeProvider renditionWithKey:specificKey.keyList usingKeySignature:_signature];;
}

- (void)setRepresentsOnDemandContent:(BOOL)demandContent {
    _odContent = YES;
}

- (NSInteger)layoutDirection {
    return self.renditionKey.themeDirection;
}

- (NSInteger)displayGamut {
    return self.renditionKey.themeDisplayGamut;
}

- (NSString *)appearance {
    CUIStructuredThemeStore *themeProvider = _LookupStructuredThemeProvider(_storageRef);
    NSString *appearance = [themeProvider nameForAppearanceIdentifier:self.renditionKey.themeAppearance];
    if (appearance.length) {
        return appearance;
    } else {
        return [themeProvider defaultAppearanceName];
    }
}

- (NSUInteger)hash {
    return _storageRef | [_signature hash] << 16;
}

- (NSInteger)appearanceIdentifier {
    return self.renditionKey.themeAppearance;
}

- (void)lock {
    os_unfair_lock_lock(&_lock);
}

- (void)unlock {
    os_unfair_lock_unlock(&_lock);
}

- (NSString *)keySignature {
    return _signature;
}

- (BOOL)isEqual:(id)object {
    if (self == object) {
        return YES;
    }
    if (![object isKindOfClass:[CUINamedLookup class]]) {
        return NO;
    }
    CUINamedLookup *other = (CUINamedLookup *)object;
    return [_signature isEqualToString:other->_signature] && _storageRef == other->_storageRef;
}

- (NSString *)renditionName {
    return self._rendition.name;
}

- (BOOL)representsOnDemandContent {
    return _odContent;
}

- (BOOL)isTintable {
    return self._rendition.isTintable;
}

- (NSInteger)idiom {
    return CUIRenditionKeyValueForAttribute(self.renditionKey.keyList, 15);
}

- (NSUInteger)subtype {
    return CUIRenditionKeyValueForAttribute(self.renditionKey.keyList, 16);
}

- (NSInteger)sizeClassHorizontal {
    return CUIRenditionKeyValueForAttribute(self.renditionKey.keyList, 20);
}

- (NSInteger)sizeClassVertical {
    return CUIRenditionKeyValueForAttribute(self.renditionKey.keyList, 21);
}

- (NSInteger)memoryClass {
    return self.renditionKey.themeMemoryClass;
}

- (NSInteger)graphicsClass {
    return self.renditionKey.themeGraphicsClass;
}

- (NSInteger)localization {
    return self.renditionKey.themeLocalization;
}

- (uint32_t)_distilledInVersion {
    return _distilledInVersion;
}

- (CUIRenditionKey *)renditionKey {
    return _key;
}

@end
