//
//  CUIStructuredThemeStore+Internal.h
//  CoreUI
//
//  Audited for macOS 15.0
//  Status: WIP

#import <CoreUI/CUIStructuredThemeStore.h>
#import "_renditionkey.h"
#import "CUIStructuredThemeStorage.h"
#import "CUIStructuredThemeStorage2.h"

@class CUICommonAssetStorage;

CF_ASSUME_NONNULL_BEGIN

@interface CUIStructuredThemeStore () <CUIStructuredThemeStorage, CUIStructuredThemeStorage2>

- (void)_commonInit;
- (BOOL)_formatStorageKeyArrayBytes:(void *)_formatStorageKeyArrayBytes length:(NSUInteger)length fromKey:(const _renditionkeytoken)key;
- (id)_newRenditionKeyDataFromKey:(const _renditionkeytoken *)key;
- (BOOL)_subImageTexturingShouldBeSupported;
- (void)_updateKeyWithCompatibilityMapping:(_renditionkeytoken *)compatibilityMapping;
- (BOOL)assetExistsForKey:(const _renditionkeytoken *)key;
- (id)baseGradationKeySignatureForKey:(const _renditionkeytoken *)key;
- (id)convertRenditionKeyToKeyData:(const _renditionkeytoken *)keyData;
- (id)copyKeySignatureForKey:(const _renditionkeytoken *)key withBytesNoCopy:(char *)bytesNoCopy length:(NSUInteger)length;
- (id)copyLookupKeySignatureForKey:(const _renditionkeytoken *)key;
- (id)debugDescriptionForKeyList:(const _renditionkeytoken *)keyList;
- (const struct _renditionkeyattributeindex { NSUInteger x0; uint8_t x1[65]; uint32_t x2; uint32_t x3[29]; } *)keyAttributeIndex;
- (const _renditionkeyfmt *)keyFormat;
- (id)keySignatureForKey:(const _renditionkeytoken *)key;
- (BOOL)localizationWorkaroundForKeyList:(const _renditionkeytoken *)keyList withLocale:(id)locale;
- (id)lookupAssetForKey:(const _renditionkeytoken *)key;
- (const _renditionkeytoken *)renditionKeyForName:(id)name cursorHotSpot:(CGPoint *)cursorHotSpot;
- (const _renditionkeyfmt *)renditionKeyFormat;
- (id)renditionNameForKeyList:(_renditionkeytoken *)keyList;

@end

CF_ASSUME_NONNULL_END
