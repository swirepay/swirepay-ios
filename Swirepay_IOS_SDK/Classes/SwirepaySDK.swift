//
//  SwirepaySDK.swift
//  Swirepay_IOS_SDK
//
//  Created by Dinesh on 10/02/21.
//

import UIKit
import Foundation
import SwiftyJSON

// MARK: - Payment response listeners

public protocol SwirePaymentListener {
    
    // MARK: - it will return the payment response after successfull payment.
    
    func didFinishPayment(responseData:[String:Any])
    
    // MARK: - it will return the payment failed response.

    func onPaymentFailed(responseData:[String:Any],errorMessage:String)
    
    // MARK: - it will return failed response when the payment sdk is not intialized yet.

    func onPaymentConfigurationFailed(errorMessage:String)
}

public class SwirepaySDK:NSObject  {
    
    // MARK: - Variable declaration
        
    public var publishableKey:String!
    
    public var paymentListenerDelegate:SwirePaymentListener?
    
    public var delegate:String?
    
    // MARK: - Instances declaration
    
    private var containerView:UIView!
    
    public static let shared = SwirepaySDK()
    
    var loader = SwirepayLoader()
    
    // MARK: - init func
    
    private override init() { }
    
    // MARK: - init SDK function
    
    public func initSDK(publishKey:String){
        
        if publishKey.isEmpty {
            Logger.shared.error(message:"publishKey can't be empty")
            return
        }
        self.publishableKey = publishKey
        Logger.shared.info(message:self.publishableKey)
        
    }
    
    // MARK: - functions
    
    public func doPayment(parentView:UIViewController,requestParam:[String:Any]){
        
        guard let key = self.publishableKey, !key.isEmpty else {
            self.paymentListenerDelegate?.onPaymentConfigurationFailed(errorMessage: "publishKey can't be empty")
            return
        }
        
        self.containerView = parentView.view
        loader.showLoader(inView:self.containerView)
        
        ApiManager.shared.doPostRequest(requestUrl:PAYMENTLINK, params: requestParam) { [self] success,response,error in
            if success {
                let paymentLineStatus = response["status"].string
                if paymentLineStatus == PAYMENTLINK_STATUS_SUCCESS {
                    self.processPaymentLinKResults(context:parentView,data: response)
                }else{
                    self.loader.hideLoader()
                    self.paymentListenerDelegate?.onPaymentFailed(responseData:response.dictionaryObject!,errorMessage: PAYMENTLINK_STATUS_FAILED)
                }
                return
                
            }else{
                self.loader.hideLoader()
                self.paymentListenerDelegate?.onPaymentFailed(responseData:[:],errorMessage: error)
            }
            
        }
    }
    
    // MARK: - functions : parse payment line responses and naviagate to payment view
    
    
    private func processPaymentLinKResults(context:UIViewController,data:JSON){
        
        
        
        let bundle = Bundle(identifier: BUNDLE_ID)
        let storyboard = UIStoryboard(name:STORYBOARD_NAME, bundle: bundle)
        let vc:PaymentController = storyboard.instantiateViewController(withIdentifier: "PaymentController") as! PaymentController
        vc.paymentlinkData = data.dictionaryObject!
        vc.onPaymentViewdismissed =  {paymentResponse in
            Logger.shared.info(message:"\("Checking payment status") \(paymentResponse)")
            self.fetchPaymentResults(responseData: paymentResponse)
        }
        let nc = UINavigationController(rootViewController: vc)
        nc.modalPresentationStyle = .fullScreen
        context.present(nc, animated: true) {
            self.loader.hideLoader()
        }
        
        
    }
    
    // MARK: - functions : Get payment status by gid
    
    private func fetchPaymentResults(responseData:[String:Any]){
        
        self.loader.showLoader(inView:self.containerView)
        
        let entity = responseData["entity"] as! [String:Any]
        let gid = entity["gid"] as! String
        
        let statusUrl = PAYMENTLINK + "/" + gid
        
        ApiManager.shared.doGetRequest(requestUrl:statusUrl) { success,response,error in
            if success {
                Logger.shared.info(message: response)
                self.loader.hideLoader()
                self.paymentListenerDelegate!.didFinishPayment(responseData: response.dictionaryObject!)
                return
            }else{
                self.loader.hideLoader()
                self.paymentListenerDelegate?.onPaymentFailed(responseData:responseData,errorMessage: PAYMENTLINK_STATUS_FAILED)
                
            }
            
        }
        
    }
    
}

