//
//  AccessoryServiceInterfaceController.swift
//  EveDegreeController WatchKit Extension
//
//  Created by Prescilla LECURIEUX on 23/01/2020.
//  Copyright © 2020 Léo LEGRON. All rights reserved.
//

import WatchKit
import WatchConnectivity
import Foundation


class AccessoryServiceInterfaceController: WKInterfaceController {
    
    var services = [String]() {
        didSet {
            self.loadTableData()
        }
    }
    var session = WCSession.default

    @IBOutlet weak var servicesTable: WKInterfaceTable!
    
    override func awake(withContext context: Any?) {
        super.awake(withContext: context)
        
        guard self.session.isReachable else {
            return
        }
        
        self.session.delegate = self
        self.session.sendMessage(["services": "services"], replyHandler: nil)

    }

    private func loadTableData(){
        
         let count = self.services.count
         
         self.servicesTable.setNumberOfRows(count, withRowType: "servicecell")
            
         for i in 0 ..< count {
             if let cellController = self.servicesTable.rowController(at: i) as?  AccessoryServiceCellRowController {
                cellController.servicelabel.setText(self.services[i])
             }
         }
    }
    
    override func contextForSegue(withIdentifier segueIdentifier: String, in table: WKInterfaceTable, rowIndex: Int) -> Any? {
        return services[rowIndex]
    }

}

extension AccessoryServiceInterfaceController: WCSessionDelegate {
    
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
        print(message["services"] as? [String] ?? "No services")
        if(message["services"] as? [String] != nil){
            self.services.append(contentsOf: message["services"] as! [String])
        }
    }

    
}
