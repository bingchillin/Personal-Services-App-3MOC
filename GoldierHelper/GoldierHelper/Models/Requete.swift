//
//  Requete.swift
//  GoldierHelper
//
//  Created by Thanudi Madawala on 27/08/2023.
//

import Foundation

class Requete: CustomStringConvertible {
    let id: Int?
    let client: Int
    let timer: String
    let type: Int
    let title: String
    let slots: Int
    let accepted: Bool?
    let done: Bool?
    
    var description: String {
        return "<requete id='\(String(describing: id))' client='\(client)' timer='\(timer)' type='\(type)' title='\(title)' slots='\(slots)' accepted='\(String(describing: accepted))' done='\(String(describing: done))'/>"
    }
    
    init(id: Int?, client: Int, timer: String, type: Int, title: String, slots: Int, accepted: Bool?, done: Bool?) {
        self.id = id
        self.client = client
        self.timer = timer
        self.type = type
        self.title = title
        self.slots = slots
        self.accepted = accepted
        self.done = done
    }
}
