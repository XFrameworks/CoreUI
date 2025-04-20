//
//  CUIStructuredThemeStorage.h
//  CoreUI
//
//  Audited for macOS 15.0
//  Status: WIP

#import <Foundation/Foundation.h>
#import "_renditionkey.h"

@class CUIThemeRendition;

typedef struct {
    uint8_t var0: 8;
    uint8_t var1: 8;
    uint8_t var2: 8;
    uint8_t var3: 8;
} _rgbquad;

typedef struct {
    uint32_t var0;
    uint32_t var1;
    _rgbquad var2;
} _colordef;

CF_ASSUME_NONNULL_BEGIN

@protocol CUIStructuredThemeStorage <NSObject>

- (uint32_t)authoredWithSchemaVersion;
- (BOOL)canGetRenditionWithKey:(const _renditionkeytoken *)key;
- (id)catalogGlobals;
- (uint32_t)distilledInCoreUIVersion;
- (uint32_t)documentFormatVersion;
- (double)fontSizeForFontSizeType:(id)fontSizeType;
- (BOOL)getFontName:(id *)fontName baselineOffset:(double *)baselineOffset forFontType:(id)fontType;
- (BOOL)getPhysicalColor:(_colordef *)physicalColor withName:(id)name;
- (BOOL)hasPhysicalColorWithName:(id)name;
- (CUIThemeRendition *)renditionWithKey:(const _renditionkeytoken *)key;
- (CUIThemeRendition *)renditionWithKey:(const _renditionkeytoken *)key usingKeySignature:(NSString *)keySignature;
- (uint32_t)thinnedWithCoreUIVersion;

@optional

- (NSUInteger)colorSpaceID;

@end

CF_ASSUME_NONNULL_END
