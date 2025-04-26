//
//  CUILog.m
//  CoreUI
//
//  Audited for macOS 15.0
//  Status: Complete

#import "CUILog.h"
#import "CrashReporterClient.h"

static BOOL __logToStderr = NO;

void CUILogLogToStderr(BOOL logToStderr) {
    __logToStderr = logToStderr;
}

static BOOL __renditionLogginEnabled;

void CUILogEnableRenditionLog(BOOL enabled) {
    __renditionLogginEnabled = enabled;
}

BOOL CUILogRenditionLogEnabled(void) {
    return __renditionLogginEnabled;
}

static os_log_t __handle;
static dispatch_once_t __onceToken;

CUI_INLINE
static os_log_t _CUILogHandle(void) {
    dispatch_once(&__onceToken, ^{
        __handle = os_log_create("com.apple.coreui", "framework");
    });
    return __handle;
}

void _CUILog(CUILogLevel level, const char * _Nonnull message, ...) {
    static dispatch_once_t _onceDefaultToken;
    static BOOL _showDebugLogs = NO;
    dispatch_once(&_onceDefaultToken, ^{
        _showDebugLogs = [NSUserDefaults.standardUserDefaults boolForKey:@"CUIShowDebugLogs"];
    });
    if (level == CUILogLevelDebug && !_showDebugLogs) {
        return;
    }
    @autoreleasepool {
        if (__logToStderr) {
            va_list arguments;
            va_start(arguments, message);
            NSString *result = [[NSString alloc] initWithFormat:[[NSString alloc] initWithUTF8String:message] arguments:arguments];
            va_end(arguments);
            switch (level) {
                case CUILogLevelDefault:
                case CUILogLevelInfo:
                case CUILogLevelDebug:
                    fprintf(stderr, "%s\n", result.UTF8String);
                    break;
                case CUILogLevelError:
                    fprintf(stderr, "%s\n", result.UTF8String);
                    CRSetCrashLogMessage(result.UTF8String);
                default:
                    break;
            }
        } else {
            va_list arguments;
            va_start(arguments, message);
            NSString *result = [[NSString alloc] initWithFormat:[[NSString alloc] initWithUTF8String:message] arguments:arguments];
            va_end(arguments);
            switch (level) {
                case CUILogLevelDefault:
                    os_log_with_type(_CUILogHandle(), OS_LOG_TYPE_DEFAULT, "%{public}@", result);
                    break;
                case CUILogLevelInfo:
                    os_log_with_type(_CUILogHandle(), OS_LOG_TYPE_INFO, "%{public}@", result);
                    break;
                case CUILogLevelDebug:
                    os_log_with_type(_CUILogHandle(), OS_LOG_TYPE_DEBUG, "%{public}@", result);
                    break;
                case CUILogLevelError:
                    os_log_with_type(_CUILogHandle(), OS_LOG_TYPE_ERROR, "%{public}@", result);
                    os_log_fault(_CUILogHandle(), "%{public}@", result);
                    CRSetCrashLogMessage(result.UTF8String);
                    break;
                default:
                    break;
            }
        }
    }
}
