//
//  PlaygroundParser.swift
//  QLPlayground
//
//  Created by Jakub Petrík on 10/8/15.
//  Copyright © 2015 Inloop, s.r.o. All rights reserved.
//

import Foundation

struct PlaygroundParser {
    static let fileManager = NSFileManager.defaultManager()
    static let pagesDirectoryName = "Pages"
    static func parsePlaygroundAtURL(url: NSURL) -> String {

        guard let path: NSString = url.path else { return "" }

        let isPaged = fileManager.fileExistsAtPath(path.stringByAppendingPathComponent(pagesDirectoryName), isDirectory:nil)
        let parsedContents: String

        if isPaged {
            parsedContents = parseMultiPagedPlayground(url)
        }
        else {
            parsedContents = parseSinglePagedPlayground(url)
        }

        return parsedContents
    }

    private static func parseSinglePagedPlayground(url: NSURL) -> String {
        guard
            let contents = (try? fileManager.contentsOfDirectoryAtURL(url, includingPropertiesForKeys: nil, options: .SkipsHiddenFiles))?.filter({$0.pathExtension == "swift"}).first,
            let source = try? String(contentsOfURL: contents, encoding: NSUTF8StringEncoding) else { return "" }
        return source
    }

    private static func parseMultiPagedPlayground(url: NSURL) -> String {
        let pagesRootURL = url.URLByAppendingPathComponent(pagesDirectoryName)
        guard let pages = (try? fileManager.contentsOfDirectoryAtURL(pagesRootURL, includingPropertiesForKeys: nil, options: .SkipsHiddenFiles))?.filter({$0.pathExtension == "xcplaygroundpage" }) else { return "" }
        return pages
            .map {
                return $0.URLByAppendingPathComponent("Contents.swift")
            }
            .reduce("") {
                guard let page = try? String(contentsOfURL: $1) else { return $0 }
                return $0 + page
            }
    }
}
