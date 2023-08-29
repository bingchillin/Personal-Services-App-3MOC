//
//  RequeteSub.swift
//  GoldierHelper
//
//  Created by Thanudi Madawala on 27/08/2023.
//

import Foundation

class RequeteSub: CustomStringConvertible {
    let id: Int
    let requete: Int
    let user: Int
    let accepted: Bool
    
    var description: String {
        return "<requeteSub id='\(id)' requete='\(requete)' user='\(user)' accepted='\(accepted)'/>"
    }
    
    init(id: Int, requete: Int, user: Int, accepted: Bool) {
        self.id = id
        self.requete = requete
        self.user = user
        self.accepted = accepted
    }
}
