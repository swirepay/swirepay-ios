//
//  SWAccountListener.swift
//  Swirepay_IOS_SDK
//
//  Created by Dinesh on 03/03/21.
//

import Foundation

// MARK: - SWAccountListener response listeners

public protocol SWAccountListener {
    
    func didFinishConnectAccount(responseData:[String:Any])
    func didFailedConnectAccount(error:String)

}
