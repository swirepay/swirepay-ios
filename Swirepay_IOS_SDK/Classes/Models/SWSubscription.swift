//
//  SWSubscription.swift
//  Swirepay_IOS_SDK
//
//  Created by Dinesh on 01/03/21.
//

import Foundation
import SwiftyJSON

public struct SWSubscription {
    
    public var swPlanDetails:SWPlanDetails!
    public var gid:String!
    public var link:String!
    public var status:String!

    
    public init(){
        
    }
    
    public init(data:JSON,planDetails:SWPlanDetails){
        
        self.swPlanDetails = planDetails
        let entity = data["entity"].dictionaryObject
        self.link = (entity!["link"] as! String)
        self.gid = (entity!["gid"] as! String)
    }
    
    public mutating func parse(data:JSON) -> SWSubscription {
        let entity = data["entity"].dictionaryObject
        self.status = (entity!["status"] as! String)
        return self
    }
}
