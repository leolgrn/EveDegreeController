//
//  SharedHomeManager.swift
//  IOTController
//
//  Created by Léo LEGRON on 22/12/2019.
//  Copyright © 2019 Léo LEGRON. All rights reserved.
//

import Foundation
import HomeKit

class SharedHomeManager {
    
    static let `default` = SharedHomeManager()
    
    lazy var manager = HMHomeManager()
    
}
