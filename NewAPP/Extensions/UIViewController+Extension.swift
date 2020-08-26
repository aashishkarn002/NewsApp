//
//  UIViewController+Extension.swift
//  NewsAPP
//
//  Created by Aashish on 8/26/20.
//  Copyright © 2020 aashish. All rights reserved.
//

import UIKit
extension UIViewController{
    
    // Global Alert
    // Define Your number of buttons, styles and completion
   func showAlertMessage(titleStr:String, messageStr:String) {
    let alert = UIAlertController(title: titleStr, message: messageStr, preferredStyle: .alert)
    alert.addAction(UIAlertAction(title: "OK", style: .cancel, handler: nil))
    self.present(alert, animated: true, completion: nil)
    }
}
