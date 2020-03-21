//
//  AppDelegate.swift
//  AnalysisTest
//
//  Created by Ami Intwala on 21/03/20.
//

import UIKit

@UIApplicationMain
class AppDelegate: UIResponder, UIApplicationDelegate {

    var window: UIWindow?

    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?) -> Bool {
        // Override point for customization after application launch.
        if UserDefaults.standard.bool(forKey: UserDefaultsKeys.isLoggedIn.rawValue) {
            let mainStoryboard: UIStoryboard = UIStoryboard(name: "Main", bundle: nil)
            let exampleViewController = mainStoryboard.instantiateViewController(withIdentifier: "AdsVC") as! AdsVC
            let nav = UINavigationController.init(rootViewController: exampleViewController)
            self.window?.rootViewController = nav
            self.window?.makeKeyAndVisible()
        }
        
        return true
    }

}

