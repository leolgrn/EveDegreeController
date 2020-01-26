//
//  HomeInterfaceController.swift
//  EveDegreeController WatchKit Extension
//
//  Created by Prescilla LECURIEUX on 20/01/2020.
//  Copyright © 2020 Léo LEGRON. All rights reserved.
//

import WatchKit
import WatchConnectivity
import Foundation
import HomeKit

class HomeInterfaceController: WKInterfaceController {
    
    var accessories = [String]() {
        didSet {
            self.loadTableData()
        }
    }
    var session = WCSession.default

    @IBOutlet weak var accessoriesTable: WKInterfaceTable!
   
    override func awake(withContext context: Any?) {
        super.awake(withContext: context)
    
        guard self.session.isReachable else {
            return
        }
        
        self.session.delegate = self
        self.session.sendMessage(["state": "accessories"], replyHandler: nil)
    }

    private func loadTableData(){
        
        let count = self.accessories.count
        
        self.accessoriesTable.setNumberOfRows(count, withRowType: "accessorycell")
           
        for i in 0 ..< count {
            if let cellController = self.accessoriesTable.rowController(at: i) as?  AccessoryCellRowController {
                cellController.accessoryLabel.setText(self.accessories[i])
            }
        }
    }
    
    override func contextForSegue(withIdentifier segueIdentifier: String, in table: WKInterfaceTable, rowIndex: Int) -> Any? {
        return self.accessoriesTable.rowController(at: rowIndex)
    }

}

extension HomeInterfaceController: WCSessionDelegate {
    
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
        print(message["accessories"] as? [String] ?? "No accessories")
        if(message["accessories"] as? [String] != nil){
            self.accessories.append(contentsOf: message["accessories"] as! [String])
        }
    }

    
}
