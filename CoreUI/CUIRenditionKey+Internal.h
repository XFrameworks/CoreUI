//
//  CUIRenditionKey+Internal.h
//  CoreUI
//
//  Audited for macOS 15.0
//  Status: WIP

#import "CUIRenditionKey.h"
#import "_renditionkey.h"

CF_ASSUME_NONNULL_BEGIN

@interface CUIRenditionKey ()

+ (instancetype)renditionKeyWithKeyList:(const _renditionkeytoken *)keyList;
- (const _renditionkeytoken *)keyList;
- (void)copyValuesFromKeyList:(const _renditionkeytoken *)keyList;
- (id)descriptionBasedOnKeyFormat:(const _renditionkeyfmt *)keyFormat;
- (instancetype)initWithKeyList:(const _renditionkeytoken *)keyList;
- (id)nameOfAttributeName:(int)attributeName;
- (void)removeValueForKeyTokenIdentifier:(NSInteger)keyTokenIdentifier;
- (void)setValuesFromKeyList:(const _renditionkeytoken *)keyList;

@end

CF_ASSUME_NONNULL_END
