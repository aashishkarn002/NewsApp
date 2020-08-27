//
//  HomeTabBarController.swift
//  NewsAPP
//
//  Created by Aashish on 8/27/20.
//  Copyright © 2020 aashish. All rights reserved.
//

import UIKit
import NVActivityIndicatorView
class HomeTabBarViewController: UITabBarController {
    
    var coreDataStack: CoreDataStack!
    var nvActivityData: ActivityData!
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // Do any additional setup after loading the view.
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        self.tabBar.backgroundImage = UIImage()
        self.tabBar.shadowImage = UIImage()
        self.tabBar.tintColor = UIColor.appColor
        self.tabBar.barTintColor = UIColor.white
        self.tabBar.unselectedItemTintColor = UIColor.gray
        self.tabBar.isTranslucent = false
        self.tabBarItem.setTitleTextAttributes([NSAttributedString.Key.foregroundColor: UIColor.appColor], for:.selected)
        
        setNeedsStatusBarAppearanceUpdate()
        self.loadViewControllers()
        
    }
    func loadViewControllers() {
        let mainStory = UIStoryboard(name: StoryBoardName.Main.rawValue, bundle: nil)
        let bookMarksStory = UIStoryboard(name:StoryBoardName.BookMark.rawValue, bundle: nil)
        let newsVC = mainStory.instantiateViewController(withIdentifier: ViewControllerName.NewsViewController.rawValue)as! NewsViewController
        newsVC.coreDataStack = self.coreDataStack
        newsVC.nvActivityData = self.nvActivityData
        let bookMarkVC = bookMarksStory.instantiateViewController(withIdentifier: ViewControllerName.BookMarkViewController.rawValue) as! BookMarkViewController
        bookMarkVC.coreDataStack = self.coreDataStack
        bookMarkVC.nvActivityData = self.nvActivityData
        let homeNav = CustomNavigationController(rootViewController: newsVC)
        let bookMarkNav = CustomNavigationController(rootViewController: bookMarkVC)
        self.viewControllers = [homeNav,bookMarkNav]
    }
}
