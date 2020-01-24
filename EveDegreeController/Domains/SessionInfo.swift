//
//  SessionInfo.swift
//  EveDegreeController
//
//  Created by Prescilla LECURIEUX on 24/01/2020.
//  Copyright © 2020 Léo LEGRON. All rights reserved.
//

import Foundation


class SessionInfo {
    
    var running: Bool
    
    static let instance = SessionInfo()
    
    private init(){
        self.running = false
    }
}
