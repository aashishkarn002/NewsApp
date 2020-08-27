//
//  AppDelegate.swift
//  NewAPP
//
//  Created by Aashish on 8/24/20.
//  Copyright © 2020 aashish. All rights reserved.
//

import UIKit
import CoreData
import NVActivityIndicatorView
@UIApplicationMain
class AppDelegate: UIResponder, UIApplicationDelegate {
    
    var window: UIWindow?
    lazy var coreDataStack = CoreDataStack()
    lazy var nvActivityData = ActivityData(size: CGSize(width: 50.0, height: 50.0), message: "Loading....", messageFont: UIFont(name: "Montserrat", size: 18), messageSpacing: 10.0, type: .ballSpinFadeLoader, color: .appColor, padding: 10.0, displayTimeThreshold: 8, minimumDisplayTime: 5, backgroundColor: .clear, textColor: .appColor)
    var navigationController: UINavigationController?
    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?) -> Bool {
        if #available(iOS 13.0, *) {
            window?.overrideUserInterfaceStyle = .light
        }
        self.loadTabBarVC()
        self.navigationController = CustomNavigationController()
        return true
    }
    
    // MARK: UISceneSession Lifecycle
    func applicationWillTerminate(_ application: UIApplication) {
        // Called when the application is about to terminate. Save data if appropriate. See also applicationDidEnterBackground:.
        // Saves changes in the application's managed object context before the application terminates.
        
        self.coreDataStack.saveMainContext()
    }
    
    
}

