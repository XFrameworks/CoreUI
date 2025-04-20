//
//  CUIThemeRendition_Support.h
//  CoreUI
//
//  Audited for macOS 15.0
//  Status: WIP

#ifndef CUIThemeRendition_Support_h
#define CUIThemeRendition_Support_h

#import <Foundation/Foundation.h>
#import <CoreUI/_renditionkey.h>

uint16_t CUIRenditionKeyTokenCount(const _renditionkeytoken *keyList);

_renditionkeytoken * CUIRenditionKeyCopy(_renditionkeytoken *result, const _renditionkeytoken *key, uint16_t maxCountIncludingZeroTerminator);

_renditionkeytoken * CUIRenditionKeySetValueForAttribute(_renditionkeytoken *key, NSInteger value, NSUInteger attribute, uint16_t maxCountIncludingZeroTerminator);

_renditionkeytoken *_CUIRenditionKeySetIntegerValueForAttribute(_renditionkeytoken *key, NSInteger value, NSUInteger attribute);

uint16_t CUIRenditionKeyValueForAttribute(const _renditionkeytoken *tokens, int attributeID);

#endif /* CUIThemeRendition_Support_h */
