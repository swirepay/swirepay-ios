//
//  SWPlan.swift
//  Swirepay_IOS_SDK
//
//  Created by Dinesh on 25/02/21.
//

import Foundation

public struct SWPlan {
    
    var currencyCode: String
    
    var name: String
    
    var amount: Int
    
    var description:String
    
    var note:String
    
    var billingPeriod:Int
    
    var billingFrequency:String
    
   public init(currencyCode:String,name:String,amount:Int,description:String ,note:String,billingPeriod:Int,billingFrequency:String) {
    
        self.currencyCode = currencyCode
        self.name = name
        self.amount = amount
        self.description = description
        self.note = note
        self.billingPeriod = billingPeriod
        self.billingFrequency = billingFrequency
   }
    
    public func toDic() -> [String:Any]{
        
        var reqParams = [String:Any]()
        reqParams["currencyCode"] = self.currencyCode
        reqParams["name"] = self.name
        reqParams["amount"] = self.amount
        reqParams["description"] = self.description
        reqParams["note"] = self.note
        reqParams["billingPeriod"] = self.billingPeriod
        reqParams["billingFrequency"] = self.billingFrequency

        return reqParams
    }
    
    public func toDetailDic() -> [String:Any]{
        
        var reqParams = [String:Any]()
        reqParams["currencyCode"] = self.currencyCode
        reqParams["name"] = self.name
        reqParams["planAmount"] = self.amount
        reqParams["description"] = self.description
        reqParams["planBillingPeriod"] = self.billingPeriod
        reqParams["planBillingFrequency"] = self.billingFrequency

        return reqParams
    }
    
}
