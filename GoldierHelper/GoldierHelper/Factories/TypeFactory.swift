//
//  TypeFactory.swift
//  GoldierHelper
//
//  Created by Thanudi Madawala on 30/08/2023.
//

import Foundation

class TypeFactory {

    class func type(from dict: [String: Any]) -> Type? {
        guard let id = dict["id"] as? Int,
              let name = dict["name"] as? String else {
            return nil
        }
        return Type(id: id, name: name)
    }

    class func types(from arr: [[String: Any]]) -> [Type] {
        return arr.compactMap { dict in
            return type(from: dict)
        }
    }
}
