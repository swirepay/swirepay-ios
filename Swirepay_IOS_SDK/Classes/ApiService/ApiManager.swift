//
//  ApiManager.swift
//  Swirepay_IOS_SDK
//
//  Created by Dinesh on 10/02/21.
//

import Foundation
import Alamofire
import SwiftyJSON


public class ApiManager {
    
    // MARK: - Instance declaration

    public static let shared = ApiManager()
    
    // MARK: - init declaration

    private init(){}
    
    
    // MARK: - Post request to server and return the api response by using completion handler

    public func doPostRequest(requestUrl:String,params:[String:Any],completion: @escaping (Bool,JSON,String) -> Void){
        
        Logger.shared.info(message:requestUrl)
        Logger.shared.info(message: params)
    
        Alamofire.request(requestUrl, method: .post, parameters: params,encoding: JSONEncoding.default, headers: [AUTHORISATION_KEY:SwirepaySDK.shared.publishableKey]).responseJSON {
        response in
            switch response.result {
            case .success:
                let json = JSON(response.result.value!)
                Logger.shared.info(message:json)
                completion(true,json,"")
                break
            case .failure:
                Logger.shared.error(message: response.error)
                completion(false,[:],response.error!.localizedDescription)
                break
            }
            
        }
        
    }
    
    // MARK: - Get request to server and return the api response by using completion handler

    public func doGetRequest(requestUrl:String,completion: @escaping (Bool,JSON,String) -> Void){
        
        Logger.shared.info(message:requestUrl)
        
        Alamofire.request(requestUrl, method: .get, parameters: nil,encoding: JSONEncoding.default, headers: ["x-api-key":SwirepaySDK.shared.publishableKey]).responseJSON {
        response in
            switch response.result {
            case .success:
                let json = JSON(response.result.value!)
                Logger.shared.info(message:json)
                completion(true,json,"")
                break
            case .failure:
                Logger.shared.error(message: response.error)
                completion(false,[:],response.error!.localizedDescription)
                break
            }
            
        }
    }
}
