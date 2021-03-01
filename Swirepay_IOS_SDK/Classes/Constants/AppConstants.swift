//
//  AppConstants.swift
//  Swirepay_IOS_SDK
//
//  Created by Dinesh on 10/02/21.
//

import Foundation

// MARK: - Api Url Declaration

let AUTHORISATION_KEY = "x-api-key"
let BASEURL = "https://api.swirepay.com/v1/"
let STAGGING_URL = "https://staging-backend.swirepay.com/v1/"
let STAGGING_SECURE_URL = "https://staging-secure.swirepay.com/"

let PAYMENTLINK =  "\(BASEURL)payment-link"
let PAYMENT_REDIRECT_URL = "https://ios.sdk.redirect/"
let CREATEPLAN =  "\(STAGGING_URL)plan"
let SUBSCRIPTION_BUTTON = "\(STAGGING_URL)subscription-button"
let SUBSCRIPTION_REDIRECT_URL = "https://ios.sdk.subscription.redirect/"

let PAYMENT_METHOD_POST = "\(STAGGING_SECURE_URL)setup-session"
let PAYMENT_METHOD_GET = "\(STAGGING_URL)setup-session"

let CONNECT_ACCOUNT_POST = "\(STAGGING_SECURE_URL)connect"
let CONNECT_ACCOUNT_GET = "\(STAGGING_URL)connect"


// MARK: - Payment status

let PAYMENTLINK_STATUS_SUCCESS = "SUCCESS"
let PAYMENTLINK_STATUS_FAILED = "FAILED"

let HTTTP_OK = 200
let AUTHORIZATION_FAILED = 401

//API REDIRECT URL KEYS

let PAYMENT_METHOD_REDIRECT_KEY = "sp-session-id"
let SUBSCRIPTION_BUTTON_REDIRECT_KEY = "SpSubscriptionnbutton"
let CONNECT_ACCOUNT_REDIRECT_KEY = "sp-account"

struct CurrencyCode {
    
    static var INR = "someString"
}


// MARK: - Application settings

let BUNDLE_ID = "org.cocoapods.Swirepay-IOS-SDK"
let STORYBOARD_NAME = "Swirepay"
let SWIREPAY_BUNDLE = Bundle(identifier: BUNDLE_ID)
let SWIREPAY_STORYBOARD = UIStoryboard(name:STORYBOARD_NAME, bundle: SWIREPAY_BUNDLE)

// MARK: - UI Settings

let SCREEN_WIDTH = UIScreen.main.bounds.size.width
let SCREEN_HEIGHT = UIScreen.main.bounds.size.height



