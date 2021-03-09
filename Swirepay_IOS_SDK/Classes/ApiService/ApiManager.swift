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
    
    
    private func getErrorMessage(code:Int) -> String {
        Logger.shared.error(message: "getErrorMessage")
        Logger.shared.error(message: code)

        switch code {
        case 400:
            return "ValidationFailed"
        case 401:
            return "UnAuthorized Api Key"
        default:
            return "ValidationFailed"
        }
    }
    
    
    // MARK: - Post request to server and return the api response by using completion handler

    public func doPostRequest(requestUrl:String,params:[String:Any],completion: @escaping (Bool,JSON,String) -> Void){
        
        guard let key = SwirepaySDK.shared.publishableKey, !key.isEmpty else {
            print("publishKey can't be empty")
            completion(false,[:],"publishKey can't be empty")
            return
        }
        
        Logger.shared.info(message:requestUrl)
        Logger.shared.info(message: params)
        Logger.shared.info(message: ("SwirepaySDK.shared.publishableKey " + SwirepaySDK.shared.publishableKey))
    
        Alamofire.request(requestUrl, method: .post, parameters: params,encoding: JSONEncoding.default, headers: [AUTHORISATION_KEY:SwirepaySDK.shared.publishableKey]).validate(statusCode: 200..<300).responseJSON {
        response in
            
            switch response.result {
            case .success:
                let json = JSON(response.result.value!)
                Logger.shared.info(message:"POST RESPONSE ")
                Logger.shared.info(message:json)
                completion(true,json,"")
                break
            case .failure:
                let errorCode = response.response?.statusCode
                Logger.shared.error(message: response.error)
                completion(false,[:],self.getErrorMessage(code: errorCode!))
                break
            }
            
        }
        
    }
    
    // MARK: - Get request to server and return the api response by using completion handler

    public func doGetRequest(requestUrl:String,completion: @escaping (Bool,JSON,String) -> Void){
        
        Logger.shared.info(message:requestUrl)
        
        guard let key = SwirepaySDK.shared.publishableKey, !key.isEmpty else {
            print("publishKey can't be empty")
            completion(false,[:],"publishKey can't be empty")
            return
        }
        
        Alamofire.request(requestUrl, method: .get, parameters: nil,encoding: JSONEncoding.default, headers: [AUTHORISATION_KEY:SwirepaySDK.shared.publishableKey]).responseJSON {
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
