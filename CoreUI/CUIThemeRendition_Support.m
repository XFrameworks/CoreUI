//
//  CUIThemeRendition_Support.c
//  CoreUI
//
//  Audited for macOS 15.0
//  Status: WIP

#include "CUIThemeRendition_Support.h"

uint16_t CUIRenditionKeyTokenCount(const _renditionkeytoken *keyList) {
    uint16_t count = 0;
    if (keyList) {
        while (keyList[count].value || keyList[count].identifier) {
            ++count;
        }
    }
    return count;
}

_renditionkeytoken * CUIRenditionKeyCopy(_renditionkeytoken *result, const _renditionkeytoken *key, uint16_t maxCountIncludingZeroTerminator) {
    NSCAssert(result && key, @"");
    uint16_t tokenCount;
    for (tokenCount = 0; key[2 * tokenCount + 1].value || key[2 * tokenCount].identifier; ++tokenCount) {
        
    }
    NSCAssert(tokenCount > 0 && tokenCount < maxCountIncludingZeroTerminator, @"");
    return memmove(result, key, 4 * tokenCount + 4);
}

_renditionkeytoken * CUIRenditionKeySetValueForAttribute(_renditionkeytoken *key, NSInteger value, NSUInteger attribute, uint16_t maxCountIncludingZeroTerminator) {
    if (!key) return key;
    
    NSCAssert(maxCountIncludingZeroTerminator > 0, @"");
    
    uint16_t identifier = key->identifier;
    uint16_t keyValue = key->value;
    
    
    bool foundMatchingToken = false;
    uint32_t index = 0;
    
    if (keyValue | identifier) {
        _renditionkeytoken *currentToken = key + 1;
        
        while (true) {
            if (identifier == value) {
                foundMatchingToken = true;
                break;
            }
            
            index++;
            int nextValue = currentToken->value;
            identifier = currentToken->identifier - 1;
            currentToken += 1;
            
            if (nextValue == 0 && identifier == 0) {
                break;
            }
        }
    }
    
    if (foundMatchingToken && (index & 0x80000000) == 0) {
        if (attribute) {
            key[index].value = attribute;
        } else {
            uint16_t tokenCount = 0;
            NSUInteger totalTokens = 0;
            
            if (key->value) {
                tokenCount++;
                while (key[tokenCount].value) {
                    tokenCount++;
                }
            } else {
                while (key[tokenCount].identifier) {
                    tokenCount++;
                    while (key[tokenCount].value) {
                        tokenCount++;
                    }
                }
            }
            
            totalTokens = tokenCount;
            
            NSCAssert(tokenCount < maxCountIncludingZeroTerminator, @"");
            
            if (tokenCount > (uint16_t)index) {
                NSUInteger i = (uint16_t)index;
                _renditionkeytoken *destToken = &key[i + 1];
                
                do {
                    i++;
                    destToken[-1] = *destToken;
                    destToken++;
                } while (i < totalTokens);
            }
        }
    } else {
        if (attribute) {
            uint16_t tokenCount = 0;
            
            if (key->value) {
                tokenCount++;
                while (key[tokenCount].value) {
                    tokenCount++;
                }
            } else {
                while (key[tokenCount].identifier) {
                    tokenCount++;
                    while (key[tokenCount].value) {
                        tokenCount++;
                    }
                }
            }
            
            
            NSCAssert(tokenCount < maxCountIncludingZeroTerminator - 1, @"");
            
            _renditionkeytoken *newToken = &key[tokenCount];
            newToken->identifier = value;
            newToken->value = attribute;
            
            key[tokenCount + 1].identifier = 0;
            
            index = tokenCount;
            key[index].value = attribute;
        }
    }
    
    return key;
}

_renditionkeytoken *_CUIRenditionKeySetIntegerValueForAttribute(_renditionkeytoken *key, NSInteger value, NSUInteger attribute) {
    // TODO
    
    return CUIRenditionKeySetValueForAttribute(key, value, attribute, 22);
}

uint16_t CUIRenditionKeyValueForAttribute(const _renditionkeytoken *tokens, int attributeID) {
    if (tokens == NULL) return 0;
    
    if (tokens->identifier == 0 && tokens->value == 0) return 0;
    
    int index = 0;
    const _renditionkeytoken *current = tokens;
    
    while (current->identifier != attributeID) {
        index++;
        current = tokens + index;
        if (current->identifier == 0 && current->value == 0) return 0;
    }
    
    if (index < 0) return 0;
    
    return tokens[index].value;
}
