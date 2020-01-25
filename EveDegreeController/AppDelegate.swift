//
//  AppDelegate.swift
//  EveDegreeController
//
//  Created by Léo LEGRON on 29/12/2019.
//  Copyright © 2019 Léo LEGRON. All rights reserved.
//

import UIKit
import WatchConnectivity
import BackgroundTasks

@UIApplicationMain
class AppDelegate: UIResponder, UIApplicationDelegate {

    var window: UIWindow?
    var session = WCSession.default

    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?) -> Bool {

        let window = UIWindow(frame: UIScreen.main.bounds)
        window.rootViewController = UINavigationController(rootViewController: HomeViewController())
        window.makeKeyAndVisible()
        self.window = window
        
        guard WCSession.isSupported() else {
            return true
        }
        session.delegate = self
        session.activate()
        
        return true
    }
    
    
}

extension AppDelegate: WCSessionDelegate {
    
    func session(_ session: WCSession, activationDidCompleteWith activationState: WCSessionActivationState, error: Error?) {
        print("ACTIVATED")
    }
    
    func sessionDidBecomeInactive(_ session: WCSession) {
        print("session did become inactive")
    }
    
    func sessionDidDeactivate(_ session: WCSession) {
        print("session did become inactive")
    }
    
    func session(_ session: WCSession, didReceiveMessage message: [String : Any]) {
        
         SharedHomeManager.default.manager.homes.forEach { (home) in
                   home.accessories.forEach { (accessory) in
                       
                       let dict : [String : Any] = ["Name": accessory.name, "Reachable": accessory.isReachable]
                       
                       guard self.session.isReachable else {
                           return
                       }
                           
                       do {
                           try self.session.updateApplicationContext(dict)
                       } catch {
                           print("Error sending dictionary \(dict) to Apple Watch!")
                       }
                   
                   }
               }
        
    }
    
}
