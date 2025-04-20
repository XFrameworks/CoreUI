//
//  CUINamedColor.h
//  CoreUI
//
//  Audited for macOS 15.0
//  Status: Complete

#import <CoreUI/CUINamedLookup.h>
#import <CoreGraphics/CoreGraphics.h>

CF_ASSUME_NONNULL_BEGIN

@interface CUINamedColor : CUINamedLookup

@property (readonly, nonatomic, nullable) CGColorRef cgColor;
@property (readonly, nonatomic) BOOL substituteWithSystemColor;
@property (readonly, nonatomic) NSString *systemColorName;

@end

CF_ASSUME_NONNULL_END
