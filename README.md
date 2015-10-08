QLPlayground
================================
**QLPlayground** is a QuickLook generator for Xcode Playgrounds. Supports both single and multiple paged playgrounds.

Installation
------------
To install, either build the `QLPlayground` target or download [latest release](https://github.com/inloop/qlplayground/releases/latest). Then move the `QLPlayground.qlgenerator` into `~/Library/QuickLook/` or into `/Library/QuickLook/`. Later will make it available for all users.
Optionally run `qlmanage -r` to reload QL generators.

Customization
-------------

The generator uses [SyntaxHighlighter](http://alexgorbatchev.com/SyntaxHighlighter/) to highlight the source. You can customize the output by editing files under `.../QLPlayground.qlgenerator/Contents/Resources/`. 

