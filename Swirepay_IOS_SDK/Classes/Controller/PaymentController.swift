//
//  PaymentController.swift
//  Alamofire
//
//  Created by Dinesh on 10/02/21.
//

import UIKit
import WebKit
import SwiftyJSON


class PaymentController: BaseWebViewController {
    
    // MARK: - Variable declaration
    
    private var paymentUrl:String!
    
    public  var paymentlinkData = [String:Any]()
    
    // MARK: - Payment status callback
    
    public var onPaymentViewdismissed  : (([String:Any]) -> Void)?
    
    // MARK: - View Life cycles

    override func viewDidLoad() {
        super.viewDidLoad()
        
        // MARK: - Creating Payment view using webview

    /*    let paymentView = WKWebView()
        
        self.view = paymentView
        
        NSLayoutConstraint.activate([
            paymentView.topAnchor
                        .constraint(equalTo: self.view.safeAreaLayoutGuide.topAnchor),
            paymentView.leftAnchor
                        .constraint(equalTo: self.view.safeAreaLayoutGuide.leftAnchor),
            paymentView.bottomAnchor
                        .constraint(equalTo: self.view.safeAreaLayoutGuide.bottomAnchor),
            paymentView.rightAnchor
                        .constraint(equalTo: self.view.safeAreaLayoutGuide.rightAnchor)
                ])  */
        
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
        
      //  paymentView.navigationDelegate = self
        
        // MARK: - Loading payment request
        self.loadPage(urlString: self.paymentUrl)

        
       // let request = URLRequest(url: URL(string:self.paymentUrl)!)
      //  paymentView.load(request)
        
    }
    
    // MARK: - Functions : dismiss current controller
    
    private func onDismissView(){
        self.dismiss(animated: true, completion: nil)
        self.onPaymentViewdismissed!(self.paymentlinkData)
    }
    
    
    override func viewCancelled() {
        
        if SwirepaySDK.shared.paymentListenerDelegate != nil {
            SwirepaySDK.shared.paymentListenerDelegate!.didCanceled()
        }
        else {
            print("viewCancelled")
        }
      
    }
    override func onRedirect(url: URL) {
        
        
        let gid = url.queryParameters["sp-payment-link"]
        if gid != nil {
            Logger.shared.info(message:("GID : => " + gid!))
            self.onDismissView()
        }
        
//        if url.absoluteString == PAYMENT_REDIRECT_URL {
//            self.onDismissView()
//        }

}

}

// MARK: - Extensions : WKNavigationDelegate


/*extension PaymentController:WKNavigationDelegate{
    
    func webView(_ webView: WKWebView, didStartProvisionalNavigation navigation: WKNavigation!) {}
    
    func webView(_ webView: WKWebView, didFinish navigation: WKNavigation!) {}
    
    func webView(_ webView: WKWebView, decidePolicyFor navigationAction: WKNavigationAction, decisionHandler: @escaping (WKNavigationActionPolicy) -> Void) {
        
         print("decidePolicyFor",navigationAction.request.url)
        
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
}  */
