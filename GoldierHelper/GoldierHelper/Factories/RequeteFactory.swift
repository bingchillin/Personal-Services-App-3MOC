//
//  RequeteFactory.swift
//  GoldierHelper
//
//  Created by Thanudi Madawala on 27/08/2023.
//

import Foundation

class RequeteFactory {
    
    class func requete(from dict: [String: Any]) -> Requete? {
        guard let id = dict["id"] as? Int,
              let client = dict["client"] as? Int,
              let timer = dict["timer"] as? String,
              let type = dict["type"] as? Int,
              let title = dict["title"] as? String,
              let slots = dict["slots"] as? Int else {
            return nil
        }
        
        let accepted = dict["accepted"] as? Bool
        let done = dict["done"] as? Bool
        
        return Requete(id: id, client: client, timer: timer, type: type, title: title, slots: slots, accepted: accepted, done: done)
    }
    
    class func requetes(from arr: [[String: Any]]) -> [Requete] {
        return arr.compactMap { dict in
            return requete(from: dict)
        }
    }
}

