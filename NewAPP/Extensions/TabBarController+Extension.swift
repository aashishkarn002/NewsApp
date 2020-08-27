//
//  TabBarController+Extension.swift
//  NewsAPP
//
//  Created by Aashish on 8/27/20.
//  Copyright © 2020 aashish. All rights reserved.
//

import UIKit
extension UITabBarController {
     func showAlertControllerMessage(titleStr:String, messageStr:String) {
       let alert = UIAlertController(title: titleStr, message: messageStr, preferredStyle: .alert)
       alert.modalPresentationStyle = .overCurrentContext
       alert.addAction(UIAlertAction(title: "OK", style: .cancel, handler: nil))
       self.present(alert, animated: true, completion: nil)
       }
}
