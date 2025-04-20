//
//  CUIStructuredThemeStorage2.h
//  CoreUI
//
//  Audited for macOS 15.0
//  Status: WIP

#import <Foundation/Foundation.h>
#import <CoreGraphics/CoreGraphics.h>
#import "_renditionkey.h"

CUI_ASSUME_NONNULL_BEGIN

@protocol CUIStructuredThemeStorage2 <NSObject>
- (id)localizations;
- (id)appearances;
- (BOOL)containsLookupForName:(id)name;
- (id)imagesWithName:(id)name;
- (id)allImageNames;
- (uint16_t)appearanceIdentifierForName:(id)name;
- (BOOL)canGetRenditionWithKey:(const _renditionkeytoken *)key;
- (uint16_t)localizationIdentifierForName:(id)name;
- (id)mappedAliases;
- (id)nameForAppearanceIdentifier:(uint16_t)appearanceIdentifier;
- (id)nameForLocalizationIdentifier:(uint16_t)localizationIdentifier;
- (const _renditionkeytoken *)renditionKeyForName:(id)name;

@optional

- (void)insertCGImage:(CGImageRef)insertCGImage withName:(id)name andDescription:(id)description;
- (void)removeImageNamed:(id)removeImageNamed withDescription:(id)description;
- (void)removeImagesNamed:(id)removeImagesNamed;
- (id)renditionInfoForIdentifier:(uint16_t)identifier;
- (id)renditionNameForKeyList:(_renditionkeytoken *)keyList;
- (id)themeStore;
@end

CUI_ASSUME_NONNULL_END
