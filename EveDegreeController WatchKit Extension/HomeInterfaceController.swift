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

class HomeInterfaceController: WKInterfaceController {
    
    let accessories = [HMAccessory]()
    var session = WCSession.default

    @IBOutlet weak var accessoriesTable: WKInterfaceTable!
   
    override func awake(withContext context: Any?) {
        super.awake(withContext: context)
    
        guard self.session.isReachable else {
            return
        }
        self.session.sendMessage(["running": true], replyHandler: nil)
    
        loadTableData()
    }

    private func loadTableData(){
        
        let count = 6
        let name = "iujehgvbipue"
        
        self.accessoriesTable.setNumberOfRows(count, withRowType: "accessorycell")
           
        for i in 0 ..< count {
            if let cellController = self.accessoriesTable.rowController(at: i) as?  AccessoryCellRowController {
                cellController.accessorylabel.setText(name)
            }
        }
    }
    
    override func contextForSegue(withIdentifier segueIdentifier: String, in table: WKInterfaceTable, rowIndex: Int) -> Any? {
        return self.accessoriesTable.rowController(at: rowIndex)
    }

}
