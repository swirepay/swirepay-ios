//
//  PaymentRequestParams.swift
//  Swirepay_IOS_SDK
//
//  Created by Dinesh on 10/02/21.
//

import Foundation


enum NOTIFICATION_TYPE {
    
    case ALL,SMS,EMAIL
    
}

 public struct PaymentRequestParams: Codable {
    
    var amount: String
    var currencyCode: String
    var paymentMethodType: String
    var description: String
    var statementDescriptor: String
    var email:String
    var phoneNumber:String
    var name:String
    //var notificationType = NOTIFICATION_TYPE.ALL
    
    public func toDic() -> [String:Any]{
        return ["amount":self.amount,"currencyCode":self.currencyCode,"paymentMethodType":self.paymentMethodType]
    }
    
}
