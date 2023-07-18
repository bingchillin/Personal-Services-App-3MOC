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
              let n = dict["name"] as? String,
              let addr = dict["address"] as? String,
              let e = dict["email"] as? String,
              let c = dict["city"] as? String,
              let cp = dict["cp"] as? String,
              let psw = dict["password"] as? String,
              let w = dict["weight"] as? Double,
              let h = dict["height"] as? Double,
              let cl = dict["calorie"] as? Int else {
            return nil
        }
        return User(id: id, firstname: fn, name: n, address: addr, city: c, cp: cp, password: psw, weight: w, height: h, email: e, calorie: cl)
    }
    
    class func users(from arr: [ [String: Any ] ]) -> [User] {
        return arr.compactMap { dict in
            return user(from: dict)
        }
    }
}
