//
//  AccountConnectController.swift
//  Swirepay_IOS_SDK
//
//  Created by Emile Milot on 01/03/21.
//

import UIKit

class AccountConnectController: BaseWebViewController {
    
    // MARK: - Payment status callback
    
    public var onAccountConnectViewdismissed  : ((String) -> Void)?

    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        
        self.loadPage(urlString: self.getUrlKey())
    }
    
   
    
    private func getUrlKey() -> String {
        
        let encodedVal = SwirepaySDK.shared.publishableKey.toBase64()
        let  url = URL(string: CONNECT_ACCOUNT_POST)!
        let finalURL = url.appending("key", value: encodedVal)
            .appending("redirectUrl", value:SUBSCRIPTION_REDIRECT_URL)
        Logger.shared.info(message: ("getUrlKey " + finalURL.absoluteString))
        return finalURL.absoluteString
    }
    
    override func onRedirect(url: URL) {
        Logger.shared.info(message: ("onRedirect " + url.absoluteString))
    
        let spAid = url.queryParameters[CONNECT_ACCOUNT_REDIRECT_KEY]
        if spAid != nil {
            Logger.shared.info(message:("SWAccount : => " + spAid!))
            self.onDismissView(spAccountId:spAid!)
        }
        
    }
    
    private func onDismissView(spAccountId:String){
        
        self.dismiss(animated: true, completion: {
            self.onAccountConnectViewdismissed!(spAccountId)
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
