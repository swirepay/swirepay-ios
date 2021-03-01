//
//  BaseWebViewController.swift
//  Swirepay_IOS_SDK
//
//  Created by Emile Milot on 01/03/21.
//

import UIKit
import WebKit


 class BaseWebViewController: UIViewController {
    
    private let paymentView = WKWebView()

    public override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    
    /*    self.view = paymentView
        
        NSLayoutConstraint.activate([
            paymentView.topAnchor
                        .constraint(equalTo: self.view.safeAreaLayoutGuide.topAnchor),
            paymentView.leftAnchor
                        .constraint(equalTo: self.view.safeAreaLayoutGuide.leftAnchor),
            paymentView.bottomAnchor
                        .constraint(equalTo: self.view.safeAreaLayoutGuide.bottomAnchor),
            paymentView.rightAnchor
                        .constraint(equalTo: self.view.safeAreaLayoutGuide.rightAnchor)
                ])
        
        // MARK: - Assign navigationDelegate
        
        paymentView.navigationDelegate = self  */
        
    }
    
    // MARK: - Loading payment request
    func loadPage(urlString:String){
        
        let request = URLRequest(url: URL(string:urlString)!)
        paymentView.navigationDelegate = self
        self.view = paymentView
        paymentView.load(request)
    }
    
    func onRedirect(url:URL){
        
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

extension BaseWebViewController:WKNavigationDelegate{
    
    func webView(_ webView: WKWebView, didStartProvisionalNavigation navigation: WKNavigation!) {}
    
    func webView(_ webView: WKWebView, didFinish navigation: WKNavigation!) {}
    
     func webView(_ webView: WKWebView, decidePolicyFor navigationAction: WKNavigationAction, decisionHandler: @escaping (WKNavigationActionPolicy) -> Void) {
        
        Logger.shared.info(message: ("decidePolicyFor " + navigationAction.request.url!.absoluteString))
          onRedirect(url: navigationAction.request.url!)
          decisionHandler(.allow)

    }
}
