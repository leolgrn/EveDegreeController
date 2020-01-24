//
//  InterfaceController.swift
//  EveDegreeController WatchKit Extension
//
//  Created by Léo LEGRON on 29/12/2019.
//  Copyright © 2019 Léo LEGRON. All rights reserved.
//

import WatchKit
import WatchConnectivity
import Foundation


class InterfaceController: WKInterfaceController {
    
    var session = WCSession.default
    
    override func awake(withContext context: Any?) {
        super.awake(withContext: context)
    }
    
    override func willActivate() {
        super.willActivate()
        
        guard WCSession.isSupported() else {
            return
        }
        session.delegate = self
        session.activate()
        
    }
    
    override func didDeactivate() {
        super.didDeactivate()
    }
        
    override func contextForSegue(withIdentifier segueIdentifier: String) -> Any? {        
        return nil
    }
    
}

extension InterfaceController: WCSessionDelegate {
    
    func session(_ session: WCSession, activationDidCompleteWith activationState: WCSessionActivationState, error: Error?) {
        print("Session activated!")
        guard self.session.isReachable else {
            return
        }
        self.session.sendMessage(["state": "on"], replyHandler: nil)
    }
    func sessionDidDeactivate(session: WCSession) {
        print("Session deactivated!")
    }

    func sessionDidBecomeInactive(session: WCSession) {
        print("Session became inactive!")
    }

    func sessionReachabilityDidChange(_ session: WCSession) {
        print("Reachability changed to \(session.isReachable)")

    }
    
    func session(_ session: WCSession, didReceiveMessage message: [String : Any]) {
        print(message)
    }
    
}
