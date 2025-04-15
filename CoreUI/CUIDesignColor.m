//
//  CUIDesignColor.m
//  CoreUI
//
//  Audited for macOS 15.0
//  Status: Complete

#import "CUIDesignColor.h"

@implementation CUIDesignColor

- (instancetype)initWithColor:(CGColorRef)color
                    blendMode:(CGBlendMode)blendMode
                 displayGamut:(CUIDisplayGamut)displayGamut {
    if (color == nil) {
        return nil;
    }
    self = [super init];
    if (self) {
        _cgColor = CGColorRetain(color);
        _blendMode = blendMode;
        _displayGamut = displayGamut;
    }
    return self;
}

@end
