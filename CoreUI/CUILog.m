//
//  CUILog.m
//  CoreUI
//
//  Audited for macOS 15.0
//  Status: WIP

#import "CUILog.h"

int32_t __logToStderr = 0;

static const char *lastErrorString = NULL;

void _CUILog(CUILogLevel level, const char * _Nonnull message, ...) {
    static BOOL _showDebugLogs = NO;
    static dispatch_once_t _onceDefaultToken;
    dispatch_once(&_onceDefaultToken, ^{
        _showDebugLogs = [NSUserDefaults.standardUserDefaults boolForKey:@"CUIShowDebugLogs"];
    });
    if (level == CUILogLevelDebug && !_showDebugLogs) {
        return;
    }
    @autoreleasepool {
        va_list arguments;
        va_start(arguments, message);
        if (__logToStderr) {
            NSString *result = [[NSString alloc] initWithFormat:[[NSString alloc] initWithUTF8String:message] arguments:arguments];
            switch (level) {
                case CUILogLevelDefault:
                case CUILogLevelInfo:
                case CUILogLevelDebug:
                    fprintf(stderr, "%s\n", [result UTF8String]);
                    break;
                case CUILogLevelError:
                    fprintf(stderr, "%s\n", [result UTF8String]);
                    lastErrorString = [result UTF8String];
                default:
                    break;
            }
        } else {
            NSString *result = [[NSString alloc] initWithFormat:[[NSString alloc] initWithUTF8String:message] arguments:arguments];
            switch (level) {
                case CUILogLevelDefault:
                    os_log(_CUILogHandle(), "%{public}@", result);
                    break;
                case CUILogLevelInfo:
                    os_log_info(_CUILogHandle(), "%{public}@", result);
                    break;
                case CUILogLevelDebug:
                    os_log_debug(_CUILogHandle(), "%{public}@", result);
                    break;
                case CUILogLevelError:
                    os_log_error(_CUILogHandle(), "%{public}@", result);
                    os_log_fault(_CUILogHandle(), "%{public}@", result);
                    lastErrorString = [result UTF8String];
                    break;
                default:
                    break;
            }
        }
        va_end(arguments);
    }
}

os_log_t _CUILogHandle(void) {
    static os_log_t __handle;
    static dispatch_once_t __onceToken;
    dispatch_once(&__onceToken, ^{
        __handle = os_log_create("com.apple.coreui", "framework");
    });
    return __handle;
}

void CUILogLogToStderr(int32_t verbose) {
    __logToStderr = verbose;
}
