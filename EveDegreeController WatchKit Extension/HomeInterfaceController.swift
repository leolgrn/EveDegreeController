//
//  HomeInterfaceController.swift
//  EveDegreeController WatchKit Extension
//
//  Created by Prescilla LECURIEUX on 20/01/2020.
//  Copyright © 2020 Léo LEGRON. All rights reserved.
//

import WatchKit
import Foundation
import WatchConnectivity


class HomeInterfaceController: WKInterfaceController {
    
       //var session = WCSession.default
       var accessories = [HMAccessory]()
    
       @IBOutlet var accessoriesTable: WKInterfaceTable!
       
       override func awake(withContext context: Any?) {
            super.awake(withContext: context)
           
        self.accessoriesTable.setNumberOfRows(self.accessories.count, withRowType: "accessorycell")
           
        for i in 0 ..< self.accessories.count {
                if let cellController = self.accessoriesTable.rowController(at: i) as?  AccessoryCellRowController {
                    cellController.label.setText(self.accessories[i].name)
                }
            }
       }
/*
       @IBAction func selectAccessoryTouch() {
           guard self.session.isReachable else {
               return
           }
           self.session.sendMessage(["accessory": 1], replyHandler: nil)
       }
*/

    override func willActivate() {
        // This method is called when watch view controller is about to be visible to user
        super.willActivate()
    }

    override func didDeactivate() {
        // This method is called when watch view controller is no longer visible
        super.didDeactivate()
    }

}

/*
extension HomeInterfaceController: HMHomeManagerDelegate {
    func homeManagerDidUpdateHomes(_ manager: HMHomeManager) {
        SharedHomeManager.default.manager.homes.forEach { (home) in
            home.accessories.forEach { (accessory) in
                self.accessories.append(accessory)
            }
        }
        self.accessoryTableView.reloadData()
    }
}
*/
