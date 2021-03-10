# Swirepay_IOS_SDK

[![CI Status](https://img.shields.io/travis/swirepay/Swirepay_IOS_SDK.svg?style=flat)](https://travis-ci.org/swirepay/Swirepay_IOS_SDK)
[![Version](https://img.shields.io/cocoapods/v/Swirepay_IOS_SDK.svg?style=flat)](https://cocoapods.org/pods/Swirepay_IOS_SDK)
[![License](https://img.shields.io/cocoapods/l/Swirepay_IOS_SDK.svg?style=flat)](https://cocoapods.org/pods/Swirepay_IOS_SDK)
[![Platform](https://img.shields.io/cocoapods/p/Swirepay_IOS_SDK.svg?style=flat)](https://cocoapods.org/pods/Swirepay_IOS_SDK)

## Swirepay IOS SDK

Swirepay iOS SDK helps developers implement a native payment experience in their iOS application. The SDK requires minimal setup to get started and helps developers process payments under 30 seconds while being PCI compliant.

## Example

To run the example project, clone the repo, and run `pod install` from the Example directory first.

AppDelegate.swift

import Swirepay_IOS

Add the following code to the start of your didFinishLaunchingWithOptions function:

SwirepaySDK.shared.initSDK(publishKey:"api_key")

Using the Swirepay_IOS_SDK:

1.Pay

Sample Request Parameters:

    let paymentList = ["CARD"]

    let paymentRequestParam = [
    "amount":String(amount),
    "currencyCode":"INR",
    "paymentMethodType":paymentList,
    "redirectUri":"https://ios.sdk.redirect"
    ] as [String : Any]
    
    SwirepaySDK.shared.doPayment(parentView:UIViewController,requestParam:[String:Any])
    
Delegate Methods : Which is used to get the payment responses

Assign delegate to current view controller

SwirePaymentListener
   
    SwirepaySDK.shared.paymentListenerDelegate = self
    
    // MARK: - Payment response listeners

    public protocol SwirePaymentListener {
        
        // MARK: - it will return the payment response after successfull payment.
        
        func didFinishPayment(responseData:[String:Any])
        
        // MARK: - it will return the payment failed response.

        func onPaymentFailed(responseData:[String:Any],errorMessage:String)
        
        // MARK: - it will return failed response when the payment sdk is not intialized yet.

        func onPaymentConfigurationFailed(errorMessage:String)
        
        //  MARK: ; it will return when the payment view canceled by user
        func didCanceled()
    }
    
    






## Requirements

## Installation

Swirepay_IOS_SDK is available through [CocoaPods](https://cocoapods.org). To install
it, simply add the following line to your Podfile:

```ruby
pod 'Swirepay_IOS','1.0.beta'
```

## Author

Swirepay, developer@swirepay.com

## License

Swirepay_IOS_SDK is available under the MIT license. See the LICENSE file for more info.
