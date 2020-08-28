//
//  UIViewController+Extension.swift
//  NewsAPP
//
//  Created by Aashish on 8/26/20.
//  Copyright © 2020 aashish. All rights reserved.
//

import UIKit
extension UIViewController{
    
    
   func showAlertMessage(titleStr:String, messageStr:String) {
    let alert = UIAlertController(title: titleStr, message: messageStr, preferredStyle: .alert)
    alert.modalPresentationStyle = .overCurrentContext
    alert.addAction(UIAlertAction(title: "OK", style: .cancel, handler: nil))
    self.present(alert, animated: true, completion: nil)
    }
    func showAlertWithAction(title:String,message: String,handler:@escaping () -> ()) {
        let alert = UIAlertController(title: title, message: message, preferredStyle: .alert)
        alert.addAction(UIAlertAction(title: "CANCEL", style: .cancel, handler: nil))
        alert.addAction(UIAlertAction(title: "YES", style: .default, handler: { (action) in
            handler()
        }))
        alert.modalPresentationStyle = .overCurrentContext
        self.present(alert, animated: true, completion: nil)
    }
    func showAlertWithOneAction(title:String,message: String,handler:@escaping () -> ()) {
        let alert = UIAlertController(title: title, message: message, preferredStyle: .alert)
        
        alert.addAction(UIAlertAction(title: "OK", style: .default, handler: { (action) in
            handler()
        }))
        alert.modalPresentationStyle = .overCurrentContext
        self.present(alert, animated: true, completion: nil)
    }
    open override func awakeFromNib() {
        navigationItem.backBarButtonItem = UIBarButtonItem(title: "", style: .plain, target: nil, action: nil)
    } 
   
}
