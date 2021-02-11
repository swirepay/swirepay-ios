//
//  PaymentController.swift
//  Alamofire
//
//  Created by Dinesh on 10/02/21.
//

import UIKit
import WebKit
import SwiftyJSON


class PaymentController: UIViewController {
    
    // MARK: - Variable declaration
    
    private weak var paymentUrl:String!
    
    public weak var paymentlinkData = [String:Any]()
    
    // MARK: - Payment status callback
    
    public var onPaymentViewdismissed  : (([String:Any]) -> Void)?
    
    // MARK: - View Life cycles

    override func viewDidLoad() {
        super.viewDidLoad()
        
        // MARK: - Creating Payment view using webview

        let paymentView = WKWebView()
        self.view = paymentView
        
        // MARK: - parsing payment info
        
        let paymentEntity = self.paymentlinkData["entity"] as! [String:Any]
        let paymentViewUrl = paymentEntity["link"]
        self.paymentUrl = paymentViewUrl as! String
        
        // MARK: - Make sure paymentUrl not returning nil
        
        if self.paymentUrl == nil {
            self.onDismissView()
            return
        }
  
        // MARK: - Assign navigationDelegate
        
        paymentView.navigationDelegate = self
        
        // MARK: - Loading payment request
        
        let request = URLRequest(url: URL(string:self.paymentUrl)!)
        paymentView.load(request)
        
    }
    
    // MARK: - Functions : dismiss current controller
    
    private func onDismissView(){
        self.dismiss(animated: true, completion: nil)
        self.onPaymentViewdismissed!(self.paymentlinkData)
    }

}


// MARK: - Extensions : WKNavigationDelegate


extension PaymentController:WKNavigationDelegate{
    
    func webView(_ webView: WKWebView, didStartProvisionalNavigation navigation: WKNavigation!) {}
    
    func webView(_ webView: WKWebView, didFinish navigation: WKNavigation!) {}
    
    func webView(_ webView: WKWebView, decidePolicyFor navigationAction: WKNavigationAction, decisionHandler: @escaping (WKNavigationActionPolicy) -> Void) {
        
        // print("decidePolicyFor",navigationAction.request.url)
        
        if navigationAction.request.url != nil {
            if let urlStr = navigationAction.request.url?.absoluteString{
                if urlStr == PAYMENT_REDIRECT_URL {
                    decisionHandler(.cancel)
                    self.onDismissView()
                }else{
                    decisionHandler(.allow)
                }
                
            }else{
                decisionHandler(.allow)
            }
            
        }else{
            decisionHandler(.allow)
        }
        
    }
}
