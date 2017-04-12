//
//  WQAlertManager.swift
//  My二维码
//
//  Created by jorgon on 12/04/17.
//  Copyright © 2017年 jorgon. All rights reserved.
//

import UIKit

class WQAlertManager: NSObject {
    static let sharedInstance = WQAlertManager()
    private override init() {}
    
    func showAlert(targetVC: UIViewController, title: String?, message: String?, style: UIAlertControllerStyle, confirmTitle: String?, cancelTitle: String?) {
        let alertVC = UIAlertController.init(title: title, message: message, preferredStyle: style)
        let confirmA = UIAlertAction.init(title: confirmTitle, style: .default) { (action) in
            
        }
        alertVC.addAction(confirmA)
        
        if cancelTitle != nil {
            let cancelA = UIAlertAction.init(title: cancelTitle, style: .cancel, handler: nil)
            alertVC.addAction(cancelA)
        }
        
        targetVC.present(alertVC, animated: true, completion: nil)
    }
}
