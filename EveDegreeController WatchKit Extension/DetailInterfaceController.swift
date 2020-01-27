//
//  DetailInterfaceController.swift
//  EveDegreeController WatchKit Extension
//
//  Created by Prescilla LECURIEUX on 23/01/2020.
//  Copyright © 2020 Léo LEGRON. All rights reserved.
//

import WatchKit
import WatchConnectivity
import Foundation


class DetailInterfaceController: WKInterfaceController {
    
    @IBOutlet weak var detailLabel: WKInterfaceLabel!
    
    var session = WCSession.default
    
    override func awake(withContext context: Any?) {
        super.awake(withContext: context)
        
        guard self.session.isReachable else {
            return
        }
        
        self.session.delegate = self
        self.session.sendMessage(["detail": context as Any], replyHandler: nil)
    }
    

}
extension DetailInterfaceController: WCSessionDelegate {
    
    func session(_ session: WCSession, activationDidCompleteWith activationState: WCSessionActivationState, error: Error?) {
        print("Session activated!")
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
        /*print(message[context] as? [String:Any] ?? "No detail")
        if(message["detail"] as? [String:Any] != nil){
            self.detailLabel.setText(message[context] as? String)
        }
         */
    }

    
}

