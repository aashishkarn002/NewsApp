//
//  CustomNavigationController.swift
//  NewsAPP
//
//  Created by Aashish on 8/27/20.
//  Copyright © 2020 aashish. All rights reserved.
//

import Foundation
import UIKit

class CustomNavigationController: UINavigationController {
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        //Turns of clipping for Navigation Controller.
        self.view.subviews[0].clipsToBounds = false
        self.navigationBar.setBackgroundImage(UIImage(), for: .default)
        self.navigationBar.shadowImage = UIImage()
        self.navigationBar.isTranslucent = false
        self.navigationBar.tintColor = UIColor.white
        self.navigationBar.titleTextAttributes = [NSAttributedString.Key.foregroundColor : UIColor.white]
        self.navigationBar.backIndicatorTransitionMaskImage = UIImage()
        self.navigationBar.barTintColor = UIColor.appColor
        self.navigationBar.backgroundColor = .clear
        self.view.backgroundColor = .clear
        self.navigationBar.barStyle = .default
    
    }
   
    override var shouldAutorotate: Bool {
        return true
    }
}
