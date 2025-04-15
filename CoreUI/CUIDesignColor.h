//
//  CUIDesignColor.h
//  CoreUI
//
//  Audited for macOS 15.0
//  Status: WIP

#ifndef CUIDesignColor_h
#define CUIDesignColor_h

#import <CoreUI/CUIDisplayGamut.h>

#import <CoreFoundation/CoreFoundation.h>
#import <CoreGraphics/CoreGraphics.h>

@interface CUIDesignColor : NSObject

@property (readonly, nonatomic) CGColorRef cgColor;
@property (readonly, nonatomic) CGBlendMode blendMode;
@property (readonly, nonatomic) CUIDisplayGamut displayGamut;

- (void)dealloc;
- (CGColorRef)cgColor;
- (CUIDisplayGamut)displayGamut;
- (CGBlendMode)blendMode;
- (instancetype)initWithColor:(CGColorRef)color blendMode:(CGBlendMode)blendMode displayGamut:(CUIDisplayGamut)displayGamut;

@end

#endif /* CUIDesignColor_h */
