//
//  SwirepayLoader.swift
//  Swirepay_IOS_SDK
//
//  Created by Dinesh on 11/02/21.
//

import Foundation
import UIKit

public class SwirepayLoader:UIView {
    
    // MARK: - Variable declaration
    
    var indicator:UIActivityIndicatorView!
    
    var overLay:UIView!
    
    // MARK: - init func

     init(){
        let frame : CGRect = CGRect(x: 0, y: 0, width: SCREEN_WIDTH, height: SCREEN_HEIGHT)
        
        overLay = UIView(frame: frame)
        overLay.backgroundColor = UIColor.black.withAlphaComponent(0.5)
        
        super.init(frame: frame)
        
        indicator = UIActivityIndicatorView(activityIndicatorStyle: .gray)
        // Position Activity Indicator in the center of the main view
        indicator.center = self.center

        // If needed, you can prevent Acivity Indicator from hiding when stopAnimating() is called
        indicator.hidesWhenStopped = false
    
        self.addSubview(indicator)
    
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    // MARK: - Functions

    public  func showLoader(inView:UIView){
                
        inView.addSubview(overLay)
        inView.addSubview(indicator)
        
        
        // Start Activity Indicator
        indicator.startAnimating()
    }
    
    public  func hideLoader(){
        // Start Activity Indicator
        indicator.stopAnimating()
        
        indicator.removeFromSuperview()
        overLay.removeFromSuperview()
    }
}
