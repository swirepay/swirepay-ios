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
let PAYMENTLINK =  "\(BASEURL)payment-link"
let PAYMENT_REDIRECT_URL = "https://www.swirepay.com/"

// MARK: - Payment status

let PAYMENTLINK_STATUS_SUCCESS = "SUCCESS"
let PAYMENTLINK_STATUS_FAILED = "FAILED"

// MARK: - Application settings

let BUNDLE_ID = "org.cocoapods.Swirepay-IOS-SDK"
let STORYBOARD_NAME = "Swirepay"

// MARK: - UI Settings

let SCREEN_WIDTH = UIScreen.main.bounds.size.width
let SCREEN_HEIGHT = UIScreen.main.bounds.size.height



