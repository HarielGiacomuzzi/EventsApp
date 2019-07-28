# EventsApp

### Pre-requisites:
- iOS 11.0+
- Xcode 9.0+
- Swift 4.0+
- [CocoaPods](https://cocoapods.org/)
- [Swiftlint](https://github.com/realm/SwiftLint)

### Swiftlint
[Swiftlint](https://github.com/realm/SwiftLint) is a tool to enforce swift style and conventions. 
To install the tool, just donwload the [swiftLint.pkg](https://github.com/realm/SwiftLint/releases/download/0.23.1/SwiftLint.pkg) and running it.

After the installation, go to XCode in the build phase tab and add a new "Run Script Phase" and type

```bash
if which swiftlint >/dev/null; then
swiftlint
else
echo "warning: SwiftLint not installed, download from https://github.com/realm/SwiftLint"
fi
```

### CocoaPods

[CocoaPods](http://cocoapods.org) is a dependency manager for Cocoa projects. You can install it with the following command:

```bash
$ gem install cocoapods
```
