//
//  CoreUI.m
//  CoreUI
//
//  Audited for iOS 18.0 & macOS 15.0
//  Status: Complete

#import "CoreUI.h"
#import "CUILog.h"
#import <mach-o/dyld.h>
#import <CoreFoundation/CoreFoundation.h>

extern double CoreUIVersionNumber;

///**
/**
 * Determines if the current executable was linked on or after a specific OS version.
 *
 * @param version A hexadecimal version identifier (e.g., 0x3F7 represents a specific OS version)
 * @return YES if the executable was linked on or after the specified version, NO otherwise
 */
extern BOOL _CFExecutableLinkedOnOrAfter(int version);

int64_t CoreUICompatibleMode = 0;

@implementation CoreUI

+(void)_determineCompatibilityMode {
    #if TARGET_OS_OSX
    const char *library = "AppKit";
    int32_t version = NSVersionOfLinkTimeLibrary(library);
    uint16_t majorVersion = version >> 16;
    uint16_t shiftVersion = version >> 17;

    int32_t mode1 = shiftVersion > 0x238 ? 9999 : 100;
    int32_t mode2 = majorVersion == 0xFFFF ? 9999 : 100;

    int64_t compatibleMode = (majorVersion != 0xFFFF && shiftVersion > 4) ? mode1 : mode2;
    #else
    const char *library = "UIKit";
    int32_t version = NSVersionOfLinkTimeLibrary(library);
    uint16_t majorVersion = version >> 16;
    uint16_t shiftVersion = version >> 18;

    BOOL isNewBuild = _CFExecutableLinkedOnOrAfter(0x3F7);

    int32_t mode1 = majorVersion == 0xFFFF ? 9999 : 100;
    int32_t mode2 = shiftVersion > 0x250 ? 9999 : 100;

    int32_t newBuildMode = (version >= 0xA0000 || majorVersion == 0xFFFF) ? mode1 : mode2;
    int64_t compatibleMode = isNewBuild ? newBuildMode : 100;
    #endif

    CoreUICompatibleMode = compatibleMode;
    _CUILog(3, "CoreUI(DEBUG): Current version = %.1f, Linked %s version = %u, Compatibility mode = %ld", CoreUIVersionNumber, library, majorVersion, (long)compatibleMode);
}

+(int64_t)coreUICompatibleMode {
    return CoreUICompatibleMode;
}

@end
