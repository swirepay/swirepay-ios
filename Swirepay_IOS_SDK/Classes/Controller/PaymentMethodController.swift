//
//  PaymentMethodController.swift
//  Swirepay_IOS_SDK
//
//  Created by Emile Milot on 01/03/21.
//

import UIKit

class PaymentMethodController: BaseWebViewController {
    
    // MARK: - Payment method status callback
    
    public var onPaymentMethodViewDismissed  : ((String) -> Void)?

    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    

        self.loadPage(urlString:getUrlKey())
    }
    
    private func getUrlKey() -> String {
        
        let encodedVal = SwirepaySDK.shared.publishableKey.toBase64()
//        c2tfdGVzdF94a05ERzhWTGZOWUVxT01WdnJNaG85OEs2ME5Ha3V5UQ==
        let  url = URL(string: PAYMENT_METHOD_POST)!
        let finalURL = url.appending("key", value: encodedVal)
            .appending("redirectUrl", value:SUBSCRIPTION_REDIRECT_URL)
        Logger.shared.info(message: ("getUrlKey " + finalURL.absoluteString))
        return finalURL.absoluteString
    }
    
    override func onRedirect(url: URL) {
        Logger.shared.info(message: ("onRedirect " + url.absoluteString))
    
        let spSid = url.queryParameters[PAYMENT_METHOD_REDIRECT_KEY]
        if spSid != nil {
            Logger.shared.info(message:("spSessionId : => " + spSid!))
            self.onDismissView(spSessionId:spSid!)
        }
        
    }
    
    override func viewCancelled() {
        
        if SwirepaySDK.shared.paymentMethodListenerDelegate != nil {
            SwirepaySDK.shared.paymentMethodListenerDelegate!.didCanceled()
        }
        else {
            print("viewCancelled")
        }
        
    }
    
    private func onDismissView(spSessionId:String){
        
        self.dismiss(animated: true, completion: {
            self.onPaymentMethodViewDismissed!(spSessionId)
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
