//
//  JBHelper.swift
//  Weather
//
//  Created by Jithin on 10/1/18.
//  Copyright © 2018 Jithinpala. All rights reserved.
//

import UIKit

class JBHelper: NSObject {
    
    static let sharedInstance = JBHelper()
    
    /// Show Alert on current controller
    ///
    /// - parameter msg: Message to be alerted with
    /// - parameter vc:  Controller where alert to be shown in
    class func ShowSimpleAlert(withMessage msg:String, inController vc:UIViewController?){
        
        let alert = UIAlertController(title: Product_Display_Name, message: msg, preferredStyle: .alert)
        let actionOk = UIAlertAction(title: "OK", style: .default) { (action) in
            alert.dismiss(animated: true, completion: nil)
        }
        alert.addAction(actionOk)
        guard vc != nil else{
            UIApplication.topViewController()!.present(alert, animated: true, completion: nil)
            return
        }
        vc!.present(alert, animated: true, completion: nil)
    }
    
    /// Show Alert on current controller
    ///
    /// - parameter msg: Message to be alerted with
    /// - parameter vc:  Controller where alert to be shown in
    
    
    /// how Alert on current controller
    ///
    /// - Parameters:
    ///   - msg: Message to be alerted with
    ///   - vc: Controller where alert to be shown in
    ///   - completionHandler: call back, OK button tap action
    class func ShowSimpleAlertWithHandler(withMessage msg:String, inController vc:UIViewController?, completionHandler: @escaping (_ result: Bool?) -> Void){
        
        let alert = UIAlertController(title: Product_Display_Name, message: msg, preferredStyle: .alert)
        let actionOk = UIAlertAction(title: "OK", style: .default) { (action) in
            alert.dismiss(animated: true, completion: nil)
            completionHandler(true)
            
        }
        alert.addAction(actionOk)
        guard vc != nil else{
            UIApplication.topViewController()!.present(alert, animated: true, completion: nil)
            return
        }
        vc!.present(alert, animated: true, completion: nil)
    }

}
