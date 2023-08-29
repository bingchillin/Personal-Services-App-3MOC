//
//  RequeteSubFactory.swift
//  GoldierHelper
//
//  Created by Thanudi Madawala on 27/08/2023.
//

import Foundation

class RequeteSubFactory {
    
    class func requeteSub(from dict: [String: Any]) -> RequeteSub? {
        guard let id = dict["id"] as? Int,
              let requete = dict["requete"] as? Int,
              let user = dict["user"] as? Int,
              let accepted = dict["accepted"] as? Bool else {
            return nil
        }
        
        return RequeteSub(id: id, requete: requete, user: user, accepted: accepted)
    }
    
    class func requeteSubs(from arr: [[String: Any]]) -> [RequeteSub] {
        return arr.compactMap { dict in
            return requeteSub(from: dict)
        }
    }
}
