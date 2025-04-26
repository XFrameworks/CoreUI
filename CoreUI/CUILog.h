//
//  CUILog.h
//  CoreUI
//
//  Audited for macOS 15.0
//  Status: Complete

#import <Foundation/Foundation.h>
#import <os/log.h>
#import <CoreUI/CUIBase.h>

CUI_ASSUME_NONNULL_BEGIN

typedef CUI_ENUM(int32_t, CUILogLevel) {
    CUILogLevelDefault = 1,
    CUILogLevelInfo = 2,
    CUILogLevelDebug = 3,
    CUILogLevelError = 4
};

CUI_EXPORT void CUILogLogToStderr(BOOL logToStderr);
CUI_EXPORT void CUILogEnableRenditionLog(BOOL enabled);
CUI_EXPORT BOOL CUILogRenditionLogEnabled(void);

CUI_EXPORT void _CUILog(CUILogLevel level, const char * _Nonnull message, ...) CUI_FORMAT_FUNCTION(2, 3);

CUI_ASSUME_NONNULL_END
