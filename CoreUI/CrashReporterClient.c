//
//  CrashReporterClient.c
//  CoreUI

#include "CrashReporterClient.h"

#ifndef LIBC_NO_LIBCRASHREPORTERCLIENT

// Instead of linking to CrashReporterClient.a (because it complicates the
// build system), define the only symbol from that static archive ourselves.
//
// The layout of this struct is CrashReporter ABI, so there are no ABI concerns
// here.
CRASH_REPORTER_CLIENT_HIDDEN
struct crashreporter_annotations_t gCRAnnotations __attribute__((
    __section__("__DATA," CRASHREPORTER_ANNOTATIONS_SECTION))) = {
    CRASHREPORTER_ANNOTATIONS_VERSION, 0, 0, 0, 0, 0, 0, 0};

#endif
