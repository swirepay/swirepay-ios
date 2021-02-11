//
//  PaymentRequestParams.swift
//  Swirepay_IOS_SDK
//
//  Created by Dinesh on 10/02/21.
//

import Foundation

public struct PaymentRequestParams: Codable {
    
    var amount: String
    var currencyCode: String
    var paymentMethodType: String
    
    public func toDic() -> [String:Any]{
        return ["amount":self.amount,"currencyCode":self.currencyCode,"paymentMethodType":self.paymentMethodType]
    }
    
}
