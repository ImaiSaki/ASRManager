![AsReader](https://github.com/asx-co-jp/ASRManager/blob/feature/edit-readme/logo.png?raw=true)

# ASRManager

Convenience library  for AsReader
=======

[![CI Status](http://img.shields.io/travis/koda/ASRManager.svg?style=flat)](https://travis-ci.org/koda/ASRManager)
[![Version](https://img.shields.io/cocoapods/v/ASRManager.svg?style=flat)](http://cocoapods.org/pods/ASRManager)
[![License](https://img.shields.io/cocoapods/l/ASRManager.svg?style=flat)](http://cocoapods.org/pods/ASRManager)
[![Platform](https://img.shields.io/cocoapods/p/ASRManager.svg?style=flat)](http://cocoapods.org/pods/ASRManager)

ASRManager is a delightful library to use [AsReader](http://www.asreader.com) for iOS.
ASRManager provides singleton instance including AsReader SDK.

## Installation

ASRManager is available through [CocoaPods](http://cocoapods.org). To install
it, simply add the following line to your Podfile:

```ruby
pod "ASRManager"
```

## Usage

### Import header file.
```objective-c
#import <ASRManager.h>
```

### Add protocol to Supported external accessory protocols in plist.
- Barcode => 'jp.co.asx.asreader.barcode'
- RFID    => 'jp.co.asx.asreader.rfid' ( RFID is not yet available.)

### Instance Method
#### Open connection with AsReader.
```objective-c
[[ASRManager sharedInstance] open];
```

### Close connection with AsReader.
```objective-c
[[ASRManager sharedInstance] close];
```

### Start to read a barcode.
```objective-c
[[ASRManager sharedInstance] startReadBarcodeOnce];
```

### Stop to read a barcode.
```objective-c
[[ASRManager sharedInstance] stopReadBarcode];
```

### Delegate Method
#### Receive connection status with AsReader
```objective-c
- (void)ASRManagerPlugged:(ASRManager *)manager isPlugged:(BOOL)isPlugged{
    if(isPlugged){
        NSLog(@"First ViewController : AsReader Plugged");
    }else{
        NSLog(@"First ViewController : AsReader Unplugged");
    }
}
```
#### Receive barcode data  read with AsReader.
```objective-c
- (void)ASRManagerOnBarcodeScanned:(ASRManager *)manager value:(NSString *)value
{
    dispatch_async(dispatch_get_main_queue(), ^{
        _inputTextField.text = value;
    });
}
```

#### Received battery charge(%).
```objective-c
-(void)ASRManagerBattery:(ASRManager *)manager battery:(int)battery
{
    NSLog(@"battery %d%%",battery);
}
```

To run the example project, clone the repo, and run `pod install` from the Example directory first.




## Author

Asterisk.inc Technical Team, tech@asx.co.jp

## License

ASRManager is available under the MIT license. See the LICENSE file for more info.
