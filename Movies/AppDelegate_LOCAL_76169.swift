//
//  AppDelegate.swift
//  Movies
//
//  Created by mustafa içmen on 28.02.2021.
//

import UIKit
import AlamofireNetworkActivityLogger

@main
class AppDelegate: UIResponder, UIApplicationDelegate {
    
    var window: UIWindow?
    
    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?) -> Bool {
        initWindow()
        setRootViewController()
        logNetwork()
        return true
    }
    
    private func initWindow(){
        window = UIWindow(frame: UIScreen.main.bounds)
        window!.makeKeyAndVisible()
    }
    
    private func setRootViewController(){
        let vc = DependencyManager.shared.resolve(type: PopularMoviesViewController.self)
        window?.rootViewController = UINavigationController(rootViewController: vc)
    }
    
    private func logNetwork(){
        NetworkActivityLogger.shared.startLogging()
        NetworkActivityLogger.shared.level = .debug
    }
}

