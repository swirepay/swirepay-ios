//
//  SPSubscriptionListener.swift
//  Swirepay_IOS_SDK
//
//  Created by dinesh on 23/02/21.
//

import Foundation


// MARK: - Subscription response listeners

public protocol SWSubscriptionListener {
    
    func didFinishSubscription(subscription:SWSubscription)
    func didFailedSubscription(error:String)

}
