//
//  AccessoryServiceInterfaceController.swift
//  EveDegreeController WatchKit Extension
//
//  Created by Prescilla LECURIEUX on 23/01/2020.
//  Copyright © 2020 Léo LEGRON. All rights reserved.
//

import WatchKit
import Foundation


class AccessoryServiceInterfaceController: WKInterfaceController {

    @IBOutlet weak var servicesTable: WKInterfaceTable!
    
    override func awake(withContext context: Any?) {
        super.awake(withContext: context)
        
        loadTableData()
    }

    private func loadTableData(){
         let count = 6
         let name = "OJOONEOFNFOLN"
         
         self.servicesTable.setNumberOfRows(count, withRowType: "servicecell")
            
         for i in 0 ..< count {
             if let cellController = self.servicesTable.rowController(at: i) as?  AccessoryServiceCellRowController {
                 cellController.servicelabel.setText(name)
             }
         }
    }
     
     override func contextForSegue(withIdentifier segueIdentifier: String, in table: WKInterfaceTable, rowIndex: Int) -> Any? {
         return self.servicesTable.rowController(at: rowIndex)
     }

}
