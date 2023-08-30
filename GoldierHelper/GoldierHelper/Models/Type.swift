//
//  Type.swift
//  GoldierHelper
//
//  Created by Thanudi Madawala on 30/08/2023.
//

import Foundation

class Type: CustomStringConvertible {
    let id: Int
    let name: String
    
    var description: String {
        return "<Type id='\(id)' name='\(name)'/>"
    }
    
    init(id: Int, name: String) {
        self.id = id
        self.name = name
    }
}
