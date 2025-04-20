//
//  _renditionkey.h
//  CoreUI
//
//  Audited for macOS 15.0
//  Status: WIP

#ifndef _renditionkey_h
#define _renditionkey_h

typedef struct {
    uint16_t identifier;
    uint16_t value;
} _renditionkeytoken;

typedef struct {
    uint32_t x0;
    uint32_t x1;
    uint32_t x2;
    uint32_t x3[0];
} _renditionkeyfmt;

typedef struct {
    NSUInteger keymask;
    uint8_t keyindices[65];
    uint32_t nkeys;
    uint32_t keylist[29];
} _renditionkeyattributeindex;

#endif /* _renditionkey_h */
