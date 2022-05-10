//
//  AppDelegate.swift
//  MailValidate
//
//  Created by Leha on 10.05.2022.
//

import UIKit

@main
class AppDelegate: UIResponder, UIApplicationDelegate {

    var window: UIWindow?

    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?) -> Bool {

        window = UIWindow(frame: UIScreen.main.bounds)
        window?.rootViewController = VerificationViewController()
        window?.makeKeyAndVisible()

        return true
    }

}

