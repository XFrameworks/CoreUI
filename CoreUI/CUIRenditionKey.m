//
//  CUIRenditionKey.m
//  CoreUI
//
//  Audited for macOS 15.0
//  Status: WIP

#import "CUIRenditionKey+Internal.h"
#import "CUIThemeRendition_Support.h"

@interface CUIRenditionKey () {
    _renditionkeytoken _stackKey[22]; // offset: 8
    _renditionkeytoken *_key; // offset: 96
    uint16_t _highwaterKeyCount; // offset: 104
}
@end

@implementation CUIRenditionKey

- (instancetype)initWithKeyList:(const _renditionkeytoken *)keyList {
    self = [super init];
    if (self) {
        _highwaterKeyCount = 21;
        _renditionkeytoken *key = NULL;
        uint16_t count = CUIRenditionKeyTokenCount(keyList);
        if (count <= _highwaterKeyCount) {
            key = _stackKey;
        } else {
            key = calloc(count + 1, sizeof(_renditionkeytoken));
            _key = key;
            if (!key) {
                return nil;
            }
            _highwaterKeyCount = count;
        }
        CUIRenditionKeyCopy(key, keyList, count + 1);
    }
    return self;
}

- (void)setThemeElement:(NSInteger)themeElement {
    _renditionkeytoken *key = NULL;
    if (_key) {
        key = _key;
    } else {
        key = _stackKey;
    }
    _CUIRenditionKeySetIntegerValueForAttribute(key, 1, themeElement);
}

- (void)setThemePart:(NSInteger)themePart {
    _renditionkeytoken *key = NULL;
    if (_key) {
        key = _key;
    } else {
        key = _stackKey;
    }
    _CUIRenditionKeySetIntegerValueForAttribute(key, 2, themePart);
}

- (NSInteger)themeIdentifier {
    _renditionkeytoken *key = NULL;
    if (_key) {
        key = _key;
    } else {
        key = _stackKey;
    }
    return CUIRenditionKeyValueForAttribute(key, 17);
}

@end
