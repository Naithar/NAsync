[![Build Status](https://travis-ci.org/Naithar/NAsync.svg?branch=master)](https://travis-ci.org/Naithar/NAsync)

## Author

Naithar, devias.naith@gmail.com

## Setup
 * Add ```pod 'NAsync', :git => 'https://github.com/naithar/NAsync.git'``` to your [Podfile](http://cocoapods.org/)
 * Add ```!use_framework``` to your [Podfile](http://cocoapods.org/) as pod uses swift files
 * Run ```pod install```
 * Open created ```.xcworkspace``` file
 * Add ```@import NAsync``` in your source code

## Usage
```objc
 [[NAsync main:^(NHAsyncOperation *operation, id value) {
    ...your code...
 }];
```
 
```swift
 NAsync.main { _ in
    ...your code...
 }
```
 
 
## License

NAsync is available under the MIT license. See the LICENSE file for more info.
