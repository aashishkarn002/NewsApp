//
//  AppDelegateExtension.swift
//  NewsAPP
//
//  Created by Aashish on 8/27/20.
//  Copyright © 2020 aashish. All rights reserved.
//

import UIKit
extension AppDelegate {

class func sharedAppDelegate() -> AppDelegate? {
    return UIApplication.shared.delegate as? AppDelegate
}
    func loadTabBarVC()  {
        
        let tabStoryBoard = UIStoryboard(name:StoryBoardName.HomeTabBar.rawValue, bundle: nil)
        let tabBarVC = tabStoryBoard.instantiateViewController(withIdentifier: ViewControllerName.HomeTabBarViewController.rawValue) as! HomeTabBarViewController
        tabBarVC.coreDataStack = self.coreDataStack
        tabBarVC.nvActivityData = self.nvActivityData
        self.window?.rootViewController = tabBarVC
        self.window?.makeKeyAndVisible()
    }
}
