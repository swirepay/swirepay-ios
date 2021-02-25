//
//  Swirepay+PaymentListener.swift
//  Swirepay_IOS_SDK
//
//  Created by Dinesh on 23/02/21.
//

import Foundation

// MARK: - Payment response listeners

public protocol SwirePaymentListener {
    
    // MARK: - it will return the payment response after successfull payment.
    
    func didFinishPayment(responseData:[String:Any])
    
    // MARK: - it will return the payment failed response.

    func onPaymentFailed(responseData:[String:Any],errorMessage:String)
    
    // MARK: - it will return failed response when the payment sdk is not intialized yet.

    func onPaymentConfigurationFailed(errorMessage:String)
}
