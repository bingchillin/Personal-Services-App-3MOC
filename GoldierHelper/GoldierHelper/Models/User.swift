//
//  User.swift
//  GoldierHelper
//
//  Created by Thanudi Madawala on 18/07/2023.
//

import Foundation

class User: CustomStringConvertible {
    let id: Int?
    let firstname: String
    let lastname: String
    let password: String
    let email: String
    let birthdate: String
    let profession: Int
    let dateSignIn: String
    let role: Int
    var description: String {
        return "<user id='\(String(describing: id))' firstname='\(firstname)' lastname='\(lastname)' password='\(password)' email='\(email)' birthdate='\(birthdate)' profession='\(profession)' dateSignIn='\(dateSignIn)' role='\(role)'/>"
    }
    
    init(id: Int, firstname: String, lastname: String, password: String, email: String, birthdate: String, profession: Int, dateSignIn: String, role: Int) {
        self.id = id
        self.firstname = firstname
        self.lastname = lastname
        self.password = password
        self.email = email
        self.birthdate = birthdate
        self.profession = profession
        self.dateSignIn = dateSignIn
        self.role = role
        
    }
}

