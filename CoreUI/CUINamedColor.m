//
//  CUINamedColor.m
//  CoreUI
//
//  Audited for macOS 15.0
//  Status: Complete

#import "CUINamedColor.h"
#import "CUINamedLookup+Internal.h"
#import "CUIThemeRendition+Internal.h"
#import "CUILog.h"

@interface CUINamedColor () {
    CGColorRef _cgColor;
    NSString *_colorName; // offset: 64
}
@end

@implementation CUINamedColor

- (instancetype)initWithName:(NSString *)name usingRenditionKey:(CUIRenditionKey *)renditionKey fromTheme:(NSUInteger)theme {
    self = [super initWithName:name usingRenditionKey:renditionKey fromTheme:theme];
    if (self) {
        CUIThemeRendition *rendition = self._rendition;
        if (rendition.type == 1009) {
            _substituteWithSystemColor = [rendition substituteWithSystemColor];
            if (_substituteWithSystemColor) {
                _colorName = [[rendition systemColorName] copy];
            }
        } else {
            _CUILog(CUILogLevelError, "CoreUI: attempting to lookup a named color '%@' with a name that s not a color type in the AssetCatalog", name);
            return nil;
        }
    }
    return self;
}

- (CGColorRef)cgColor {
    if (!_cgColor) {
        _cgColor = self._rendition.cgColor;
    }
    return _cgColor;
}

- (void)dealloc {
    CGColorRelease(_cgColor);
}

- (NSString *)systemColorName {
    return _colorName;
}

@end
