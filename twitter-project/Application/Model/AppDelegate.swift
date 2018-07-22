//
//  AppDelegate.swift
//  twitter-project
//
//  Created by Дмитрий Матвеенко on 05.07.2018.
//  Copyright © 2018 Дмитрий Матвеенко. All rights reserved.
//

import UIKit
import RealmSwift
import Firebase

var realm : Realm!
var isLogin = false

@UIApplicationMain
class AppDelegate: UIResponder, UIApplicationDelegate {
    
    var window: UIWindow?
    
    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplicationLaunchOptionsKey: Any]?) -> Bool {
        
        FirebaseApp.configure()
        
        if Auth.auth().currentUser != nil {
            isLogin = true
        }
        
        self.window = UIWindow(frame: UIScreen.main.bounds)
        
        if isLogin != true {
            let mainStoryboard = UIStoryboard.init(name: "Main", bundle: nil)
            let loginViewController = mainStoryboard.instantiateViewController(withIdentifier: "LoginViewController") as! LoginViewController
            let navigationController = UINavigationController.init(rootViewController: loginViewController)
            self.window?.rootViewController = navigationController
            self.window?.makeKeyAndVisible()
        } else {
            let feedStoryboard = UIStoryboard.init(name: "Feed", bundle: nil)
            let feedViewController = feedStoryboard.instantiateViewController(withIdentifier: "FeedViewController") as! FeedViewController
            let navigationController = UINavigationController.init(rootViewController: feedViewController)
            self.window?.rootViewController = navigationController
            self.window?.makeKeyAndVisible()
        }
        
        return true
    }
}
