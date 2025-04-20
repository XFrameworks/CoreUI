//
//  CUILog.h
//  CoreUI
//
//  Audited for macOS 15.0
//  Status: Complete

#import <Foundation/Foundation.h>
#import <os/log.h>

CF_ASSUME_NONNULL_BEGIN

typedef NS_ENUM(int32_t, CUILogLevel) {
    CUILogLevelDefault = 1,
    CUILogLevelInfo = 2,
    CUILogLevelDebug = 3,
    CUILogLevelError = 4
};

FOUNDATION_EXPORT
void _CUILog(CUILogLevel level, const char * _Nonnull message, ...);

os_log_t _CUILogHandle(void);

CF_ASSUME_NONNULL_END
