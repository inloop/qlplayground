#include <CoreFoundation/CoreFoundation.h>
#include <CoreServices/CoreServices.h>
#include <QuickLook/QuickLook.h>
#import <Cocoa/Cocoa.h>
#import "QLPlayground-swift.h"

OSStatus GeneratePreviewForURL(void *thisInterface, QLPreviewRequestRef preview, CFURLRef url, CFStringRef contentTypeUTI, CFDictionaryRef options);
void CancelPreviewGeneration(void *thisInterface, QLPreviewRequestRef preview);

/* -----------------------------------------------------------------------------
   Generate a preview for file

   This function's job is to create preview for designated file
   ----------------------------------------------------------------------------- */

OSStatus GeneratePreviewForURL(void *thisInterface, QLPreviewRequestRef preview, CFURLRef url, CFStringRef contentTypeUTI, CFDictionaryRef options)
{
    if (QLPreviewRequestIsCancelled(preview)) {
        return noErr;
    }

    PreviewBuilder *builder = [[PreviewBuilder alloc] initWithUrl:(__bridge NSURL *)url];

    CFDataRef data = [builder buildDataForPreview];

    if (QLPreviewRequestIsCancelled(preview)) {
        return  noErr;
    }

    CFDictionaryRef properties = [builder buildPreviewProperties];

    if (QLPreviewRequestIsCancelled(preview)) {
        return  noErr;
    }

    QLPreviewRequestSetDataRepresentation(preview, data, kUTTypeHTML, properties);
    return noErr;
}

void CancelPreviewGeneration(void *thisInterface, QLPreviewRequestRef preview)
{
    // Implement only if supported
}
