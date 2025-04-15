//
//  CoreUI.h
//  CoreUI
//
//  Audited for macOS 15.0
//  Status: Complete

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

@interface CoreUI : NSObject

+(void)_determineCompatibilityMode;
+(int64_t)coreUICompatibleMode;

@end

NS_ASSUME_NONNULL_END
