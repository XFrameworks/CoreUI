//
//  CUILog.h
//  CoreUI
//
//  Audited for macOS 15.0
//  Status: Complete

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

FOUNDATION_EXPORT
void _CUILog(int verbose, const char * _Nonnull message, ...) __printflike(2, 3);

NS_ASSUME_NONNULL_END
