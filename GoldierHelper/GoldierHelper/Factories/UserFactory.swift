//
//  UserFactory.swift
//  GoldierHelper
//
//  Created by Thanudi Madawala on 18/07/2023.
//

import Foundation

class UserFactory {
    

    class func user(from dict: [String: Any]) -> User? {
        guard let id = dict["id"] as? Int,
              let fn = dict["firstname"] as? String,
              let ln = dict["lastname"] as? String,
              let pw = dict["password"] as? String,
              let e = dict["email"] as? String,
              let bd = dict["birthdate"] as? String,
              let pf = dict["profession"] as? Int,
              let ds = dict["dateSignIn"] as? String,
              let r = dict["role"] as? Int else {
            return nil
        }
        return User(id: id, firstname: fn, lastname: ln, password: pw, email: e, birthdate: bd, profession: pf, dateSignIn: ds, role: r)
    }
    
    class func users(from arr: [ [String: Any ] ]) -> [User] {
        return arr.compactMap { dict in
            return user(from: dict)
        }
    }
}
