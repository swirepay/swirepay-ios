//
//  SubscriptionController.swift
//  Swirepay_IOS_SDK
//
//  Created by Dinesh on 23/02/21.
//

import UIKit
import WebKit


class SubscriptionController: BaseWebViewController {
    
    // MARK: - Variable declaration
    
    public var subscriptionUrl:String!
    
    public var swSubscription:SWSubscription!
    
    // MARK: - Subscription status callback
    
    public var onSubscriptionViewdismissed  : ((SWSubscription) -> Void)?

    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        
        //initView()
        
        self.loadPage(urlString: self.swSubscription.link)
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
        
        // MARK: - Assign navigationDelegate
        
        subscriptionView.navigationDelegate = self

        let request = URLRequest(url: URL(string:self.swSubscription.link)!)
        subscriptionView.load(request)
    }
    
    override func onRedirect(url: URL) {
        let gid = url.queryParameters[SUBSCRIPTION_BUTTON_REDIRECT_KEY]
        if gid != nil {
            Logger.shared.info(message:("GID : => " + gid!))
            self.onDismissView()
        }
    }
    
    override func viewCancelled() {
        
        if SwirepaySDK.shared.subscriptionListenerDelegate != nil {
            SwirepaySDK.shared.subscriptionListenerDelegate!.didCanceled()
        }
        else {
            print("viewCancelled")
        }
        
       /* self.dismiss(animated: true, completion: {
            if SwirepaySDK.shared.subscriptionListenerDelegate != nil {
                SwirepaySDK.shared.subscriptionListenerDelegate!.didCanceled()
            }
            else {
                print("viewCancelled")
            }
        }) */
        
       
    }
    
    private func onDismissView(){
        self.dismiss(animated: true, completion: {
            self.onSubscriptionViewdismissed!(self.swSubscription)
        })
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


/*extension SubscriptionController:WKNavigationDelegate{
    
    func webView(_ webView: WKWebView, didStartProvisionalNavigation navigation: WKNavigation!) {}
    
    func webView(_ webView: WKWebView, didFinish navigation: WKNavigation!) {}
    
    func webView(_ webView: WKWebView, decidePolicyFor navigationAction: WKNavigationAction, decisionHandler: @escaping (WKNavigationActionPolicy) -> Void) {
        
        Logger.shared.info(message: "decidePolicyFor .....")
        Logger.shared.info(message:navigationAction.request.url as Any)
         
        
        if navigationAction.request.url != nil {
            if let redirectUrl = navigationAction.request.url {
                let url = URL(string: redirectUrl.absoluteString)!
                let gid = url.queryParameters["SpSubscriptionnbutton"]
                if gid != nil {
                    Logger.shared.info(message:("GID : => " + gid!))
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
} */
