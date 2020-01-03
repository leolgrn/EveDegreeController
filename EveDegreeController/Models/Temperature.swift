//
//  File.swift
//  EveDegreeController
//
//  Created by Léo LEGRON on 29/12/2019.
//  Copyright © 2019 Léo LEGRON. All rights reserved.
//

import Foundation
import RealmSwift

class Temperature: Object {
    @objc dynamic var date = Date()
    @objc dynamic var value: Float = 0.0
    
    func save() {
      do {
        let realm = try Realm()
        try realm.write {
          realm.add(self)
        }
      } catch let error as NSError {
       fatalError(error.localizedDescription)
      }
    }
}
