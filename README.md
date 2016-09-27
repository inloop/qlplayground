QLPlayground
================================
**QLPlayground** is a QuickLook generator for Xcode Playgrounds. Supports both single and multiple paged playgrounds.

![Screenshot of QLPlayground](https://github.com/inloop/qlplayground/blob/master/qlplayground-screen-1.png)

Installation
------------
To install, either build the `QLPlayground` target or download the [latest release](https://github.com/inloop/qlplayground/releases/latest). Then move the `QLPlayground.qlgenerator` into `~/Library/QuickLook/` or into `/Library/QuickLook/`. Later will make it available for all users.
Optionally run `qlmanage -r` to reload QL generators.

####[Homebrew-Cask](https://github.com/caskroom/homebrew-cask)
`$ brew cask install inloop-qlplayground`

Customization
-------------

The generator uses [SyntaxHighlighter](http://alexgorbatchev.com/SyntaxHighlighter/) to highlight the source. You can customize the output by editing files under `.../QLPlayground.qlgenerator/Contents/Resources/`. 

License
-------

Copyright (c) 2015 Inloop, s.r.o.

Permission is hereby granted, free of charge, to any person obtaining
a copy of this software and associated documentation files (the
"Software"), to deal in the Software without restriction, including
without limitation the rights to use, copy, modify, merge, publish,
distribute, sublicense, and/or sell copies of the Software, and to
permit persons to whom the Software is furnished to do so, subject to
the following conditions:

The above copyright notice and this permission notice shall be
included in all copies or substantial portions of the Software.

THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND,
EXPRESS OR IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF
MERCHANTABILITY, FITNESS FOR A PARTICULAR PURPOSE AND
NONINFRINGEMENT. IN NO EVENT SHALL THE AUTHORS OR COPYRIGHT HOLDERS BE
LIABLE FOR ANY CLAIM, DAMAGES OR OTHER LIABILITY, WHETHER IN AN ACTION
OF CONTRACT, TORT OR OTHERWISE, ARISING FROM, OUT OF OR IN CONNECTION
WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN THE SOFTWARE.
