//
//  CUIDesignLibrary.h
//  CoreUI

#ifndef CUIDesignLibrary_h
#define CUIDesignLibrary_h

#import <CoreUI/CUIColorName.h>
#import <CoreUI/CUIColorScheme.h>
#import <CoreUI/CUIColorSchemeContrast.h>
#import <CoreUI/CUIDesignColor.h>
#import <CoreUI/CUIDesignStyling.h>
#import <CoreUI/CUIDisplayGamut.h>

#import <CoreFoundation/CoreFoundation.h>
#import <Foundation/Foundation.h>

CF_ASSUME_NONNULL_BEGIN

typedef struct CUIDesignColorTraits {
    CUIColorName name;
    uint64_t designSystem;
    uint64_t palette;
    CUIColorScheme colorScheme;
    CUIColorSchemeContrast contrast;
    CUIDesignStyling styling;
    CUIDisplayGamut displayGamut;
} CUIDesignColorTraits;

@interface CUIDesignLibrary : NSObject

+ (nullable CUIDesignColor *)colorWithTraits:(CUIDesignColorTraits)traits error:(NSError * _Nullable * _Nullable)error;

@end

CF_ASSUME_NONNULL_END

#endif /* CUIDesignLibrary_h */
