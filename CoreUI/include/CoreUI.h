//
//  CoreUI.h
//  CoreUI
//
//  Audited for macOS 15.0
//  Status: Complete

#import <Foundation/Foundation.h>

CF_ASSUME_NONNULL_BEGIN

@interface CoreUI : NSObject

+ (void)_determineCompatibilityMode;
+ (NSInteger)coreUICompatibleMode;

@end

CF_ASSUME_NONNULL_END
