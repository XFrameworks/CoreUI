//
//  CUIThemeRendition+Internal.h
//  CoreUI
//
//  Audited for macOS 15.0
//  Status: WIP

#import <CoreUI/CUIThemeRendition.h>
#import <CoreUI/_renditionkey.h>

CF_ASSUME_NONNULL_BEGIN

typedef struct {
    uint8_t isVectorBased : 1;
    uint8_t isOpaque : 1;
    uint8_t bitmapEncoding : 4;
    uint8_t optOutOfThinning : 1;
    uint8_t isFlippable : 1;
    uint8_t isTintable : 1;
    uint8_t preservedVectorRepresentation : 1;
    uint8_t preserveForArchiveOnly : 1;
    uint32_t reserved : 21;
} cuithemerenditionrenditionflags;

typedef struct {
    uint32_t var0;
    uint16_t var1;
    uint16_t var2;
    char var3[128];
} _csimetadata;

typedef struct {
    uint32_t var0;
    uint32_t var1[];
} _csibitmaplist;

typedef struct {
    uint32_t var0;
    uint32_t var1;
    uint32_t var2;
    uint32_t var3;
    uint32_t var4;
    uint32_t var5;
    uint32_t var6;
    int32_t var7 : 4;
    int32_t var8 : 28;
    _csimetadata var9;
    uint32_t var10;
    _csibitmaplist var11;
} _csiheader;

typedef struct {
    uint32_t var0;
    uint32_t var1;
    uint32_t var2;
    float var3;
    float var4;
    float var5;
    uint32_t var6;
    uint32_t var7;
    char var8[0];
} _csitextstyle ;


@interface CUIThemeRendition () {
    _renditionkeytoken _stackKey[22]; // offset: 8
    _renditionkeytoken *_key; // offset: 96
    uint32_t _scale;
    cuithemerenditionrenditionflags _renditionFlags; // offset: 128
    NSInteger _templateRenderingMode;
    NSUInteger _colorSpaceID; // offset: 144
    NSString *_name; // offset: 152
    NSData *_srcData;
    NSString *_utiType; // offset: 176
    CGImageRef _uncroppedImage; // offset: 184
    CGSize _physicalSizeInMeters; // offset: 192
    NSDictionary *_properties; // offset: 208
}

- (const _renditionkeytoken *)key;
- (id)initWithCSIData:(id)data forKey:(const _renditionkeytoken *)key version:(uint32_t)version;
- (CGRect)_destinationFrame;
- (id)_initWithCSIData:(id)data forKey:(const _renditionkeytoken *)key version:(uint32_t)version;
- (id)_initWithCSIHeader:(const _csiheader *)header version:(uint32_t)version;
- (void)_initalizeMetadataFromCSIData:(const _csiheader *)data version:(uint32_t)version;
- (void)_initializeCompositingOptionsFromCSIData:(const _csiheader *)data version:(uint32_t)version;
- (void)_initializePropertiesFromCSIData:(const _csiheader *)data version:(uint32_t)version;
- (void)_initializeRenditionKey:(const _renditionkeytoken *)_initializeRenditionKey;
- (void)_initializeTypeIdentifiersWithLayout:(uint16_t)layout;
- (void)_setFlippable:(BOOL)flippable;
- (void)_setStructuredThemeStore:(id)structuredThemeStore;
- (id)_sourceRendition;
- (const _csitextstyle *)csiTextStyle;
- (cuithemerenditionrenditionflags *)renditionFlags;
- (struct { double x0; double x1; double x2; double x3; })vectorGlyphAlignmentRectInsets;
//- (struct { void /* unknown type, empty encoding */ x0[4]; })transformation;
//- (CGSVGDocumentRef)svgDocument;

@end

CF_ASSUME_NONNULL_END
