QLPlayground
================================
**QLPlayground** is a QuickLook generator for Xcode Playgrounds. Supports both single and multiple paged playgrounds.

Installation
------------

To install, build the `QLPlayground` target and move the `QLPlayground.qlgenerator` into `~/Library/QuickLook/` or into `/Library/QuickLook/`. Later will make it available for all users.
Optionally run `qlmanage -r` to reload QL generators.

Customization
-------------

The generator uses [SyntaxHighlighter](http://alexgorbatchev.com/SyntaxHighlighter/) to highlight the source. You can customize the output by editing files under `.../QLPlayground.qlgenerator/Contents/Resources/`. 

