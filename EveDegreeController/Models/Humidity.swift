//
//  File.swift
//  EveDegreeController
//
//  Created by Léo LEGRON on 29/12/2019.
//  Copyright © 2019 Léo LEGRON. All rights reserved.
//

import Foundation

class Humidity {
    @objc dynamic var date: Date
    @objc dynamic var value: Float
    
    init(value: Float){
        self.value = value
        self.date = Date()
    }
}
