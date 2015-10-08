//
//  PreviewBuilder.swift
//  QLPlayground
//
//  Created by Jakub Petrík on 10/7/15.
//  Copyright © 2015 Inloop, s.r.o. All rights reserved.
//

import Foundation
import QuickLook

private extension NSData {
    convenience init(contentsOfResource resource: String, inBundle bundle: NSBundle) {
        if let resourceURL = bundle.URLForResource(resource, withExtension: nil) {
            self.init(contentsOfURL: resourceURL)!
        }
        else {
            self.init()
        }
    }
}

private extension String {
    var cid: String {
        return "cid:" + self
    }
}


@objc public class PreviewBuilder: NSObject {
    private let url: NSURL
    private let bundle = NSBundle(forClass: PreviewBuilder.self)

    private struct Attachment {
        static let coreCss = "shCore.css"
        static let themeCss = "theme.css"
        static let coreJs = "shCore.js"
        static let brushJs = "brush.js"
    }

    private struct MimeType {
        static let js = "text/javascript"
        static let css = "text/css"
    }

    public var resourceURL: NSURL? {
        return bundle.resourceURL
    }

    public init(url: NSURL) {
        self.url = url
    }

    private func buildData(useCid: Bool) -> CFDataRef? {
        guard
            let formatPath = bundle.pathForResource("format", ofType: "html"),
            let format = try? String(contentsOfFile: formatPath, encoding: NSUTF8StringEncoding)
            else { return nil }

        let source = PlaygroundParser.parsePlaygroundAtURL(url)
        let html: NSString

        if useCid {
            html = NSString(format: format, Attachment.coreCss.cid, Attachment.themeCss.cid, source, Attachment.coreJs.cid, Attachment.brushJs.cid)
        }
        else {
            html = NSString(format: format, Attachment.coreCss, Attachment.themeCss, source, Attachment.coreJs, Attachment.brushJs)
        }

        if let data = html.dataUsingEncoding(NSUTF8StringEncoding) {
            return data
        }
        return nil
    }

    public func buildDataForPreview() -> CFDataRef? {
        return buildData(true) as CFDataRef?
    }

    public func buildDataForThumbnail() -> NSData? {
        return buildData(false)
    }

    public func buildPreviewProperties() -> CFDictionaryRef {
        return [
            kQLPreviewPropertyTextEncodingNameKey as String : "UTF-8",
            kQLPreviewPropertyMIMETypeKey as String : "text/html",
            kQLPreviewPropertyAttachmentsKey as String : [
                Attachment.coreCss : [
                    kQLPreviewPropertyMIMETypeKey as String: MimeType.css,
                    kQLPreviewPropertyAttachmentDataKey as String: NSData(contentsOfResource: Attachment.coreCss, inBundle: bundle)
                ],
                Attachment.themeCss : [
                    kQLPreviewPropertyMIMETypeKey as String: MimeType.css,
                    kQLPreviewPropertyAttachmentDataKey as String: NSData(contentsOfResource: Attachment.themeCss, inBundle: bundle)
                ],
                Attachment.coreJs : [
                    kQLPreviewPropertyMIMETypeKey as String: MimeType.js,
                    kQLPreviewPropertyAttachmentDataKey as String: NSData(contentsOfResource: Attachment.coreJs, inBundle: bundle)
                ],
                Attachment.brushJs : [
                    kQLPreviewPropertyMIMETypeKey as String: MimeType.js,
                    kQLPreviewPropertyAttachmentDataKey as String: NSData(contentsOfResource: Attachment.brushJs, inBundle: bundle)
                ]
            ]
        ] as CFDictionaryRef
    }
    
}



