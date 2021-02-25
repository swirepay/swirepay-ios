//
//  ViewController.swift
//  Swirepay_IOS_SDK
//
//  Created by Dinesh on 02/10/2021.
//  Copyright (c) 2021 Swirepay. All rights reserved.
//

import UIKit
import Swirepay_IOS_SDK

class ViewController: UIViewController, SwirePaymentListener,SWSubscriptionListener {
    
    

    // MARK: - UIInterface reference

    @IBOutlet weak var priceTextField:UITextField!
    @IBOutlet weak var payBtn:UIButton!
    @IBOutlet weak var responseResultView:UITextView!
    @IBOutlet weak var segmentedControl:UISegmentedControl!

    // MARK: - View life cycles

    override func viewDidLoad() {
        super.viewDidLoad()
        
        // MARK: - assign payment response listener

        SwirepaySDK.shared.paymentListenerDelegate = self
        
        SwirepaySDK.shared.subscriptionListenerDelegate = self
                
        // MARK: - Adding done button in keyboard

        self.setupKeyboard()
        
        // MARK: -Configure segment button 
        
        let titleTextAttributesnormal = [NSAttributedString.Key.foregroundColor: UIColor.black]
        let titleTextAttributesselected = [NSAttributedString.Key.foregroundColor: UIColor.white]
        self.segmentedControl.setTitleTextAttributes(titleTextAttributesnormal, for: .normal)
        self.segmentedControl.setTitleTextAttributes(titleTextAttributesselected, for: .selected)
            
    }

    // MARK: - Dispose of any resources that can be recreated.

    override func didReceiveMemoryWarning() {super.didReceiveMemoryWarning()}
    
    // MARK: - Functions : configure keyboard

    private func setupKeyboard(){
        
        let toolbar: UIToolbar = UIToolbar()
            toolbar.barStyle = .default
            toolbar.items = [

                UIBarButtonItem(barButtonSystemItem: .flexibleSpace, target: self, action: nil),
                UIBarButtonItem(title: "Done", style: .done, target: self, action:#selector(doneButtonTapped))
            ]
            toolbar.sizeToFit()

        self.priceTextField.inputAccessoryView = toolbar
    }
    
    // MARK: - Functions : keyboard Done Button actions

    @objc func doneButtonTapped() {
        self.priceTextField.resignFirstResponder()
        
        if isPriceValid() {
            let priceAmount = "PAY " + self.priceTextField.text!
            self.payBtn.setTitle(priceAmount, for: .normal)
        }
    
    }
    
    // MARK: - Functions : Price validation
    
    func isPriceValid() -> Bool {
        
        guard let text = self.priceTextField.text, !text.isEmpty else {
            return false
        }
        
        return true
    }

    
    // MARK: - Functions : Paybutton action

    @IBAction func payButtonClicked(sender:UIButton){
        
        if isPriceValid() {
            
            let amount = Int(self.priceTextField.text!)! * 100
            
            let paymentList = ["CARD"]
            
            let paymentRequestParam = [
                "amount":String(amount),
                "currencyCode":"INR",
                "paymentMethodType":paymentList,
                "redirectUri":"https://ios.sdk.redirect"
                ] as [String : Any]
            
            self.initPayment(param:paymentRequestParam)
        
        }
        else{
            
            Logger.shared.error(message:"please enter price amount")
            return
        }
    
    }
    
    @IBAction func segmentBtnTabbed(sender:UISegmentedControl){
        
        switch sender.tag {
        case 1:
            self.showSubscriptionView()
        default:
            break
        }
       
    }
    
    // MARK: - Functions : Starting payment process
    
    private func showSubscriptionView(){
         
        let swplan = SWPlan(currencyCode:CurrencyType.INR, name: "Test Plan IOS", amount: 40000, description: "Test Plan IOS", note: "Test", billingPeriod:1, billingFrequency:BillingFrequency.MONTH)
        
        SwirepaySDK.shared.subscription(context: self,plan:swplan)
    }

    private func initPayment(param:[String:Any]){
        self.priceTextField.text = ""
        self.payBtn.setTitle("PAY", for: .normal)
        SwirepaySDK.shared.doPayment(parentView: self, requestParam:param)
    }
    
    // MARK: - Functions : Alert
    
    private func showAlert(message:String){
        let alert = UIAlertController(title: "Payment Response", message: message, preferredStyle: UIAlertControllerStyle.alert)
        alert.addAction(UIAlertAction(title: "Ok", style: UIAlertActionStyle.default, handler: nil))
        self.present(alert, animated: true, completion: nil)
    }
    
    // MARK: - SwirePaymentListener

    func didFinishPayment(responseData: [String:Any]) {
        print("didFinishPayment",responseData)
        self.responseResultView.text = String(format:"%@", responseData)
    }
    
    func onPaymentFailed(responseData: [String : Any], errorMessage: String) {
        print("payment failed",errorMessage)
        print("payment response",responseData)
        self.showAlert(message: errorMessage)
    }
    
    func onPaymentConfigurationFailed(errorMessage: String) {
        self.showAlert(message: errorMessage)
    }
    
    
    func didFinishSubscription(responseData: [String : Any]) {
        print("didFinishSubscription",responseData)
    }
    
    func didFailedSubscription(error: String) {
        print("didFailedSubscription",error)

    }
    
}

