//
//  PaymentResponse.swift
//  Swirepay_IOS_SDK
//
//  Created by Dinesh on 11/02/21.
//

import Foundation


struct Person: Codable {
    var name: String
    var age: Int
}

public func toObject(jsonData:Data){
    
    let decoder = JSONDecoder()

    do {
        let people = try decoder.decode([Person].self, from: jsonData)
        print(people)
    } catch {
        print(error.localizedDescription)
    }
}

