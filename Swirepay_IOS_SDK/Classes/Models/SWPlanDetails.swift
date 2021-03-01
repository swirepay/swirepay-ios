//
//  SWPlanDetails.swift
//  Swirepay_IOS_SDK
//
//  Created by Dinesh on 25/02/21.
//

import Foundation
import SwiftyJSON

public struct SWPlanDetails {
    
    var plan:SWPlan!
    var gid:String!
    var createdAt:String!
    var planQuantity:Int!
    var planStartDate:String!
    var planTotalPayments:String!
    var redirectUri:String = SUBSCRIPTION_REDIRECT_URL
    var status:String = "ACTIVE"
    
    public init(json:JSON,requestedPlan:SWPlan) {
        
        let entity = json["entity"].dictionaryObject
        self.plan = requestedPlan
        self.gid = (entity!["gid"] as! String)
        self.createdAt = (entity!["createdAt"] as! String)
        self.planQuantity = 1
        self.planStartDate = DateUtils.getStringFromDate(withFormat: "yyyy-MM-dd'T'HH:mm:ss", date: Date())
        self.planTotalPayments = "12"
        
    }
    
    public init(parse:JSON){
        
    }
    
    public func toDic() -> [String:Any]{
        
        var requestDic = self.plan.toDetailDic()
        requestDic["planGid"] = self.gid
        requestDic["planQuantity"] = self.planQuantity
        requestDic["planStartDate"] = self.planStartDate
        requestDic["planTotalPayments"] = self.planTotalPayments
        requestDic["redirectUri"] = self.redirectUri
        requestDic["status"] = self.status

        return requestDic
    }
    
    
}
