//
//  URL+Extension.swift
//  Alamofire
//
//  Created by Dinesh on 01/03/21.
//

import Foundation


public extension URL {
    var queryParameters: QueryParameters { return QueryParameters(url: self) }
    
    func appending(_ queryItem: String, value: String?) -> URL {

           guard var urlComponents = URLComponents(string: absoluteString) else { return absoluteURL }

           // Create array of existing query items
           var queryItems: [URLQueryItem] = urlComponents.queryItems ??  []

           // Create query item
           let queryItem = URLQueryItem(name: queryItem, value: value)

           // Append the new query item in the existing query items array
           queryItems.append(queryItem)

           // Append updated query items array in the url component object
           urlComponents.queryItems = queryItems

           // Returns the url from new url components
           return urlComponents.url!
       }
}

public class QueryParameters {
    let queryItems: [URLQueryItem]
    public init(url: URL?) {
        queryItems = URLComponents(string: url?.absoluteString ?? "")?.queryItems ?? []
        print(queryItems)
    }
    public subscript(name: String) -> String? {
        return queryItems.first(where: { $0.name == name })?.value
    }
    
}
