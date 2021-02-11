//
//  Logger.swift
//  Swirepay_IOS_SDK
//
//  Created by Dinesh on 10/02/21.
//

import Foundation

public class Logger {
    
    public static let shared = Logger()
    
    private let TAG = "Swirepay-Logger"
    
    public func info(message:Any){
        #if DEBUG
            print("INFO :: ","\(message)")
        #endif
    }
    public func error(message:Any){
        #if DEBUG
            print("ERROR :: => ",message)
        #endif
    }
}
