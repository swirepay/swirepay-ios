//
//  SubscriptionController.swift
//  Swirepay_IOS_SDK
//
//  Created by Emile Milot on 23/02/21.
//

import UIKit
import WebKit


class SubscriptionController: UIViewController {
    
    // MARK: - Variable declaration
    
    public var subscriptionUrl:String!

    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        
        initView()
    }
    
    
    private func initView(){
        
        // MARK: - Creating Subscription view using webview

        let subscriptionView = WKWebView()
        
        self.view = subscriptionView
        
        NSLayoutConstraint.activate([
            subscriptionView.topAnchor
                        .constraint(equalTo: self.view.safeAreaLayoutGuide.topAnchor),
            subscriptionView.leftAnchor
                        .constraint(equalTo: self.view.safeAreaLayoutGuide.leftAnchor),
            subscriptionView.bottomAnchor
                        .constraint(equalTo: self.view.safeAreaLayoutGuide.bottomAnchor),
            subscriptionView.rightAnchor
                        .constraint(equalTo: self.view.safeAreaLayoutGuide.rightAnchor)
                ])
        
        let request = URLRequest(url: URL(string:self.subscriptionUrl)!)
        subscriptionView.load(request)
    }


    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

}


extension SubscriptionController:WKNavigationDelegate{
    
    func webView(_ webView: WKWebView, didStartProvisionalNavigation navigation: WKNavigation!) {}
    
    func webView(_ webView: WKWebView, didFinish navigation: WKNavigation!) {}
    
    func webView(_ webView: WKWebView, decidePolicyFor navigationAction: WKNavigationAction, decisionHandler: @escaping (WKNavigationActionPolicy) -> Void) {
        
        Logger.shared.info(message: "decidePolicyFor .....")
        Logger.shared.info(message:navigationAction.request.url as Any)
         
        
       /* if navigationAction.request.url != nil {
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
        }  */
        
    } 
}
