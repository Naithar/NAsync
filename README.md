[![Build Status](https://travis-ci.org/Naithar/NAsync.svg?branch=master)](https://travis-ci.org/Naithar/NAsync)
[![Coverage Status](https://coveralls.io/repos/Naithar/NAsync/badge.svg?branch=master)](https://coveralls.io/r/Naithar/NAsync?branch=master)

## Author

Naithar, devias.naith@gmail.com

## Setup
 * Add ```pod 'NAsync', :git => 'https://github.com/naithar/NAsync.git'``` to your [Podfile](http://cocoapods.org/)
 * Add ```!use_framework``` to your [Podfile](http://cocoapods.org/) as pod uses swift files
 * Run ```pod install```
 * Open created ```.xcworkspace``` file
 * Add ```@import NAsync``` in your source code
 
## Non Framework Setup
 * Clone  source files from ```Pod``` folder
 * Add this source files to your Project
 * Add ```objc
 #ifndef __NHASYNC_NO_FRAMEWORK
 #define __NHASYNC_NO_FRAMEWORK
 #endif
 ``` to your project's .phc file
 * Add ```#import "NAsync.h"``` in your source code and swift bridging header

 
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
