//
//  SWPaymentMethodListener.swift
//  Swirepay_IOS_SDK
//
//  Created by Dinesh on 01/03/21.
//

import Foundation


// MARK: - SWPaymentMethod response listeners

public protocol SWPaymentMethodListener {
    
    func didFinishPaymentMethod(responseData:[String:Any])
    func didFailedPaymentMethod(error:String)
    func didCanceled()

}
