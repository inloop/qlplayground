#include <CoreFoundation/CoreFoundation.h>
#include <CoreServices/CoreServices.h>
#include <QuickLook/QuickLook.h>
#include <WebKit/WebKit.h>
#import "QLPlayground-swift.h"

OSStatus GenerateThumbnailForURL(void *thisInterface, QLThumbnailRequestRef thumbnail, CFURLRef url, CFStringRef contentTypeUTI, CFDictionaryRef options, CGSize maxSize);
void CancelThumbnailGeneration(void *thisInterface, QLThumbnailRequestRef thumbnail);

/* -----------------------------------------------------------------------------
    Generate a thumbnail for file

   This function's job is to create thumbnail for designated file as fast as possible
   ----------------------------------------------------------------------------- */

OSStatus GenerateThumbnailForURL(void *thisInterface, QLThumbnailRequestRef thumbnail, CFURLRef url, CFStringRef contentTypeUTI, CFDictionaryRef options, CGSize maxSize)
{
    if (QLThumbnailRequestIsCancelled(thumbnail)) {
        return noErr;
    }

    PreviewBuilder *builder = [[PreviewBuilder alloc] initWithUrl:(__bridge NSURL *)url];

    NSData *data = [builder buildDataForThumbnail];

    if (QLThumbnailRequestIsCancelled(thumbnail)) {
        return noErr;
    }

    NSRect viewRect = NSMakeRect(0.0, 0.0, 600.0, 800.0);
    float scale = maxSize.height / 800.0;
    NSSize scaleSize = NSMakeSize(scale, scale);
    CGSize thumbSize = NSSizeToCGSize(NSMakeSize((maxSize.width * (600.0/800.0)), maxSize.height));

    WebView* webView = [[WebView alloc] initWithFrame: viewRect];
    [webView scaleUnitSquareToSize: scaleSize];
    [webView.mainFrame.frameView setAllowsScrolling:NO];
    [webView.mainFrame loadData: data
                       MIMEType: @"text/html"
               textEncodingName: @"utf-8"
                        baseURL: builder.resourceURL];

    while([webView isLoading]) {
        if (QLThumbnailRequestIsCancelled(thumbnail)) {
            return noErr;
        }
        CFRunLoopRunInMode(kCFRunLoopDefaultMode, 0, true);
    }

    [webView display];

    CGContextRef context = QLThumbnailRequestCreateContext(thumbnail, thumbSize, false, NULL);

    if (context) {
        NSGraphicsContext *nsContext = [NSGraphicsContext graphicsContextWithGraphicsPort:(void *)context flipped:[webView isFlipped]];
        [webView displayRectIgnoringOpacity:webView.bounds inContext:nsContext];

        QLThumbnailRequestFlushContext(thumbnail, context);
        
        CFRelease(context);
    }

    return noErr;
}

void CancelThumbnailGeneration(void *thisInterface, QLThumbnailRequestRef thumbnail)
{
    // Implement only if supported
}
