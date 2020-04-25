# UIColor-LegacySemanticColors
A UIColor category that backports the new semantic colors of iOS 13 to iOS 12.

<img src="https://github.com/TimOliver/UIColor-LegacySemanticColors/raw/master/screenshot.jpg" align="right" width="400" />

[![Version](https://img.shields.io/cocoapods/v/UIColor-LegacySemanticColors.svg?style=flat)](http://cocoadocs.org/docsets/UIColor-LegacySemanticColors)
[![GitHub license](https://img.shields.io/badge/license-MIT-blue.svg)](https://raw.githubusercontent.com/TimOliver/UIColor-LegacySemanticColors/master/LICENSE)
[![PayPal](https://img.shields.io/badge/paypal-donate-blue.svg)](https://www.paypal.com/cgi-bin/webscr?cmd=_s-xclick&hosted_button_id=M4RKULAVKV7K8)
[![Twitch](https://img.shields.io/badge/twitch-timXD-6441a5.svg)](http://twitch.tv/timXD)

*A very basic back-port of the `UIColor` semantic color APIs introduced in iOS 13.*

`UIColor-LegacySemanticColors` is an Objective-C category on `UIColor` that uses features of the runtime to dynamically implement the semantic color API methods from iOS 13 with similar behaving ones in iOS 12. It also allows configuration to display either light or dark mode variants of each color.

On iOS 13 and up, this library is a no-op, ensuring there will not be any breaking behaviour in future versions of iOS.

The goal of this library is to simplify Dark Mode in iOS 13, while also supporting iOS 12.

## Features
* Source compatibility with the semantic color APIs in iOS 13.
* Support for light and dark color variants.
* Performs no runtime modifying code in iOS 13 and above, making it safe for future versions.

## Requirements
* iOS 12.0 
* Xcode 11.0 or higher

## Installation Instructions

<details>
	<summary><strong>CocoaPods</strong></summary>
	<br>
	<pre>pod 'UIColor+LegacySemanticColors'</pre>
</details>

<details>
	<summary><strong>Carthage</strong></summary>
	<br>
	Carthage is not supported at this time. If you would like Carthage support, please file a PR.
</details>

<details>
	<summary><strong>Manual Installation</strong></summary>
	<br>
	Simply move the `UIColor-LegacySemanticColors` folder to your Xcode project and import it.
</details>

## Sample Code

The API behaves just like the official one in iOS 13.

### Objective-C

```objc
// Set all returned colors to be dark variants
[UIColor setLegacyInterfaceStyle:UIUserInterfaceStyleDark];

// Get the default label color
UIColor *labelColor = [UIColor labelColor];
```

### Swift

```swift
// Set all returned colors to be dark variants
UIColor.setLegacyInterfaceStyle(.dark)

// Get the default label color
let labelColor = UIColor.label
```

## Credits

Developed by [Tim Oliver](http://twitter.com/TimOliverAU).

Device mockup by [Pixeden](http://pixeden.com).

Special thanks to [Noah Gilmore](https://twitter.com/noahsark769) for [publishing the hex codes](https://noahgilmore.com/blog/dark-mode-uicolor-compatibility/) for all of the semantic colors.

## License

`UIColor-LegacySemanticColors` is licensed under the MIT License, please see the [LICENSE](LICENSE) file.
