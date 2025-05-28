//
//  AppDelegate.swift
//  Bookxpert_Assignment
//
//  Created by Viswanath M on 26/05/25.
//

import UIKit
import Firebase
import FirebaseAuth
import GoogleSignIn
 

class AppDelegate: NSObject,UIApplicationDelegate{
    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey : Any]? = nil) -> Bool {
        // configure firebase for notifications
        FirebaseApp.configure()
        return true
    }
    
    func application(_ app: UIApplication, open url: URL, options: [UIApplication.OpenURLOptionsKey : Any] = [:]) -> Bool {
        return GIDSignIn.sharedInstance.handle(url)
    }
}


