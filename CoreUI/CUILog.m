//
//  CUILog.m
//  CoreUI
//
//  Audited for macOS 15.0
//  Status: WIP

#import "CUILog.h"

int32_t __logToStderr = 0;

void _CUILog(int32_t verbose, const char * _Nonnull message, ...) {
    static BOOL _showDebugLogs = NO;
    static dispatch_once_t _onceDefaultToken;
    dispatch_once(&_onceDefaultToken, ^{
        _showDebugLogs = [NSUserDefaults.standardUserDefaults boolForKey:@"CUIShowDebugLogs"];
    });
    if (verbose == 3 && !_showDebugLogs) {
        return;
    }
    @autoreleasepool {
        // TODO
        va_list arguments;
        va_start(arguments, message);
        if (__logToStderr == 0) {
            // NSString *result = [[NSString alloc] initWithFormat:[[NSString alloc] initWithUTF8String:message] arguments:arguments];
        } else {
            
        }
        va_end(arguments);
    }
}

void CUILogLogToStderr(int32_t verbose) {
    __logToStderr = verbose;
}
