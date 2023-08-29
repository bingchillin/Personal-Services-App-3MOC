//
//  AppDelegate.swift
//  GoldierHelper
//
//  Created by Thanudi Madawala on 18/07/2023.
//

import UIKit

@main
class AppDelegate: UIResponder, UIApplicationDelegate {



    var window: UIWindow?
    
    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?) -> Bool {
        
        let window = UIWindow(frame: UIScreen.main.bounds)

        window.rootViewController = UINavigationController(rootViewController: AccountViewController())
        window.makeKeyAndVisible()

        self.window = window

        return true
    }



}

