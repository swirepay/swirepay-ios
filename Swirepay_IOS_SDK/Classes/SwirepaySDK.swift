//
//  SwirepaySDK.swift
//  Swirepay_IOS_SDK
//
//  Created by Dinesh on 10/02/21.
//

import UIKit
import Foundation
import SwiftyJSON


public class SwirepaySDK:NSObject  {
    
    // MARK: - Variable declaration
        
    public var publishableKey:String!
    
    public var paymentListenerDelegate:SwirePaymentListener?
    
    public var subscriptionListenerDelegate:SWSubscriptionListener?
    
    public var paymentMethodListenerDelegate:SWPaymentMethodListener?
    
    public var accountListenerDelegate:SWAccountListener?
    
    public var delegate:String?
    
    public var baseController:UIViewController?
    
    private var lastPaymentResponse = [String:Any]()
    
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
    
    public func cancel(){
        
        if baseController != nil {
            baseController?.dismiss(animated: true, completion: nil)
        }
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
        
        let vc:PaymentController = SWIREPAY_STORYBOARD.instantiateViewController(withIdentifier: "PaymentController") as! PaymentController
        vc.paymentlinkData = data.dictionaryObject!
        vc.onPaymentViewdismissed =  {paymentResponse in
            Logger.shared.info(message:"\("Checking payment status") \(paymentResponse)")
            self.lastPaymentResponse = paymentResponse
            let entity = paymentResponse["entity"] as! [String:Any]
            let gid = entity["gid"] as! String
            
            self.fetchPaymentResults(pgid: gid)
        }
        let nc = UINavigationController(rootViewController: vc)
        nc.modalPresentationStyle = .fullScreen
        context.present(nc, animated: true) {
            self.loader.hideLoader()
        }
        
        
    }
    
    // MARK: - functions : Get payment status by gid
    
    private func fetchPaymentResults(pgid:String){
        
        self.loader.showLoader(inView:self.containerView)
    
        let statusUrl = PAYMENTLINK + "/" + pgid
        
        ApiManager.shared.doGetRequest(requestUrl:statusUrl) { success,response,error in
            if success {
                Logger.shared.info(message: response)
                self.loader.hideLoader()
                self.paymentListenerDelegate!.didFinishPayment(responseData: response.dictionaryObject!)
                return
            }else{
                self.loader.hideLoader()
                self.paymentListenerDelegate?.onPaymentFailed(responseData:self.lastPaymentResponse,errorMessage: PAYMENTLINK_STATUS_FAILED)
                
            }
            
        }
        
    }
    
    // MARK: - functions : subscription view
    
    public func subscription(context:UIViewController,plan:SWPlan){
        
        self.loader.showLoader(inView:context.view)
        
        let requestParams = plan.toDic()
        
        ApiManager.shared.doPostRequest(requestUrl: CREATEPLAN, params: requestParams) { (sucess, json, error) in
            
            if sucess {
//                responseCode
                Logger.shared.info(message: json)
                
                self.createSubscription(parentContext:context,planDetails:json, plan: plan)
    
                return
                
            }else{
                
                self.loader.hideLoader()
                
                Logger.shared.error(message: error)
                
                if self.subscriptionListenerDelegate == nil {
                    Logger.shared.warning(message:"subscriptionListenerDelegate can't be nil")
                    return
                }
                
                self.subscriptionListenerDelegate?.didFailedSubscription(error: error)
            }
        }
        
    }
    
    
    private func createSubscription(parentContext:UIViewController,planDetails:JSON,plan:SWPlan){
        
       
        let swPlanDetails = SWPlanDetails(json: planDetails, requestedPlan: plan)
        let requestParams = swPlanDetails.toDic()
        
        ApiManager.shared.doPostRequest(requestUrl: SUBSCRIPTION_BUTTON, params: requestParams) { (success, json, error) in
            
            self.loader.hideLoader()
            
            if success {
                

                let swSubscription = SWSubscription(data:json,planDetails:swPlanDetails)
                
                let vc:SubscriptionController = SWIREPAY_STORYBOARD.instantiateViewController(withIdentifier: "SubscriptionController") as! SubscriptionController
               // vc.subscriptionUrl = link
                vc.swSubscription = swSubscription
                
                vc.onSubscriptionViewdismissed =  {subscription in
                   
                    self.fetchSubscriptionDetails(containerView:parentContext.view,subscriptionData:subscription)
                    
                }
                let nc = UINavigationController(rootViewController: vc)
                nc.modalPresentationStyle = .fullScreen
                parentContext.present(nc, animated: true) {
                }
                return
            }
            
            if self.subscriptionListenerDelegate == nil {
                Logger.shared.warning(message:"subscriptionListenerDelegate can't be nil")
                return
            }
            self.subscriptionListenerDelegate?.didFailedSubscription(error: error)

        }
        
        
    }
    
    
    private func fetchSubscriptionDetails(containerView:UIView,subscriptionData:SWSubscription){
        
        self.loader.showLoader(inView: containerView)
        
        let subscrioinGetUrl = SUBSCRIPTION_BUTTON + "/" + subscriptionData.gid
        ApiManager.shared.doGetRequest(requestUrl: subscrioinGetUrl) { (sucess, json, error) in
            Logger.shared.info(message: json)
            self.loader.hideLoader()
            if sucess {
                
                self.subscriptionListenerDelegate?.didFinishSubscription(responseData: json.dictionaryObject!)
                
            }else{
                self.subscriptionListenerDelegate?.didFailedSubscription(error: error)
            }
        }
    }
    
    
    public func createPaymentMethod(parentContext:UIViewController){
        
        if self.paymentMethodListenerDelegate == nil {
            Logger.shared.warning(message:"paymentMethodListener can't be nil")
            return
        }
        
        
        let vc:PaymentMethodController = SWIREPAY_STORYBOARD.instantiateViewController(withIdentifier: "PaymentMethodController") as! PaymentMethodController
    
        vc.onPaymentMethodViewDismissed =  { spSessionId in
            Logger.shared.info(message: ("fetching payment method session status " + spSessionId))
            self.fetchPaymentMethodSessionStatus(containerView: parentContext.view,spsId: spSessionId)
        }
        let nc = UINavigationController(rootViewController: vc)
        nc.modalPresentationStyle = .fullScreen
        parentContext.present(nc, animated: true) {
        }
    }
    
    private func fetchPaymentMethodSessionStatus(containerView:UIView,spsId:String){
        
        self.loader.showLoader(inView: containerView)
        
        let paymentSetupSessionUrl = PAYMENT_METHOD_GET + "/" + spsId
        
        ApiManager.shared.doGetRequest(requestUrl: paymentSetupSessionUrl) { (sucess, json, error) in
            
            self.loader.hideLoader()
            
            Logger.shared.info(message: "Payment method status :: ")
            Logger.shared.info(message: json)
            if sucess {
                self.paymentMethodListenerDelegate?.didFinishPaymentMethod(responseData: json.dictionaryObject!)
                return
            }
            self.paymentMethodListenerDelegate?.didFailedPaymentMethod(error: error)
           
    
        }
    }
    
    
    public func createAccount(parentContext:UIViewController){
        
        if self.accountListenerDelegate == nil {
            Logger.shared.warning(message:"accountListenerDelegate can't be nil")
            return
        }
        
        guard let key = self.publishableKey, !key.isEmpty else {
            self.accountListenerDelegate?.didFailedConnectAccount(error: "publishKey can't be empty")
            return
        }
        
        let vc:AccountConnectController = SWIREPAY_STORYBOARD.instantiateViewController(withIdentifier: "AccountConnectController") as! AccountConnectController
    
        vc.onAccountConnectViewdismissed =  { spAccountID in
            Logger.shared.info(message: ("fetching account status " + spAccountID))
            
            if self.accountListenerDelegate != nil {
                
                var results = [String:Any]()
                results["gid"] = spAccountID
                
                self.accountListenerDelegate?.didFinishConnectAccount(responseData:results)
            }
            
            //self.fetchAccountDetails(containerView: parentContext.view,spAId: spAccountID)
        }
        let nc = UINavigationController(rootViewController: vc)
        nc.modalPresentationStyle = .fullScreen
        parentContext.present(nc, animated: true) {
        }
    }
    
    private func fetchAccountDetails(containerView:UIView,spAId:String){
        
        self.loader.showLoader(inView: containerView)
        
        let accountUrl = CONNECT_ACCOUNT_GET + "/" + spAId
        
        ApiManager.shared.doGetRequest(requestUrl: accountUrl) { (sucess, json, error) in
            
            self.loader.hideLoader()
            
            Logger.shared.info(message: "Account status :: ")
            Logger.shared.info(message: json)
            
            
            if self.accountListenerDelegate != nil {
                
                self.accountListenerDelegate?.didFinishConnectAccount(responseData:json.dictionaryObject!)
            }
            
            
    
        }
    }

}

