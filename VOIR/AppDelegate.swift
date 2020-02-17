//
//  AppDelegate.swift
//  VOIR
//
//  Created by Andrew Krotov on 26/07/2019.
//  Copyright © 2019 Andrew Krotov. All rights reserved.
//

import UIKit

@UIApplicationMain
class AppDelegate: UIResponder, UIApplicationDelegate {
    var window: UIWindow?
    
    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?) -> Bool {
        self.window = UIWindow(frame: UIScreen.main.bounds)
        
        self.window?.rootViewController = LaunchAnimationController()
        self.window?.makeKeyAndVisible()
        
        return true
    }
}

extension AppDelegate {
    public func startMainWorkflow() {
        guard let window = window else { return }
        
        UIView.transition(
            with: window,
            duration: 0.3,
            options: .transitionCrossDissolve,
            animations: {
                window.rootViewController = StoreController()
            }
        )
        self.window?.makeKeyAndVisible()
    }
}

