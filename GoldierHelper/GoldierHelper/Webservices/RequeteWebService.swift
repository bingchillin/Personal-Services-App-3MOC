//
//  RequeteWebService.swift
//  GoldierHelper
//
//  Created by Thanudi Madawala on 27/08/2023.
//

import Foundation

class RequeteWebService{
    
    class func getAllRequete(completion: @escaping ([Requete]?, Error?) -> Void) {
        guard let userURL = URL(string: "http://localhost:3000/requetes/") else {
            return
        }
        let task = URLSession.shared.dataTask(with: userURL) { data, res, err in
            guard err == nil, let d = data else {
                completion(nil, err)
                return
            }
            guard let json = try? JSONSerialization.jsonObject(with: d) as? [ [String: Any] ] else {
                completion(nil, NSError(domain: "com.esgi.requete.invalid-json", code: 1))
                return
            }
            let requetes = RequeteFactory.requetes(from: json)
           completion(requetes, nil) // fin OK
        }
        task.resume()
    }
    
    class func getHouseholdRequetes(completion: @escaping ([Requete]?, Error?) -> Void) {
            guard let userURL = URL(string: "http://localhost:3000/requetes/type/1") else {
                return
            }
            let task = URLSession.shared.dataTask(with: userURL) { data, res, err in
                guard err == nil, let d = data else {
                    completion(nil, err)
                    return
                }
                guard let json = try? JSONSerialization.jsonObject(with: d) as? [[String: Any]] else {
                    completion(nil, NSError(domain: "com.esgi.requete.household.invalid-json", code: 1))
                    return
                }
                let requetes = RequeteFactory.requetes(from: json)
                completion(requetes, nil)
            }
            task.resume()
        }
    
    class func getNutritionRequetes(completion: @escaping ([Requete]?, Error?) -> Void) {
            guard let userURL = URL(string: "http://localhost:3000/requetes/type/2") else {
                return
            }
            let task = URLSession.shared.dataTask(with: userURL) { data, res, err in
                guard err == nil, let d = data else {
                    completion(nil, err)
                    return
                }
                guard let json = try? JSONSerialization.jsonObject(with: d) as? [[String: Any]] else {
                    completion(nil, NSError(domain: "com.esgi.requete.nutrition.invalid-json", code: 1))
                    return
                }
                let requetes = RequeteFactory.requetes(from: json)
                completion(requetes, nil)
            }
            task.resume()
        }
    
    class func getMedicalRequetes(completion: @escaping ([Requete]?, Error?) -> Void) {
            guard let userURL = URL(string: "http://localhost:3000/requetes/type/3") else {
                return
            }
            let task = URLSession.shared.dataTask(with: userURL) { data, res, err in
                guard err == nil, let d = data else {
                    completion(nil, err)
                    return
                }
                guard let json = try? JSONSerialization.jsonObject(with: d) as? [[String: Any]] else {
                    completion(nil, NSError(domain: "com.esgi.requete.nutrition.invalid-json", code: 1))
                    return
                }
                let requetes = RequeteFactory.requetes(from: json)
                completion(requetes, nil)
            }
            task.resume()
        }
    
    class func getRequeteById(id: Int, completion: @escaping (Requete?, Error?) -> Void) {
           guard let requeteURL = URL(string: "http://localhost:3000/requetes/\(id)") else {
               return
           }
           let task = URLSession.shared.dataTask(with: requeteURL) { data, res, err in
               guard err == nil, let d = data else {
                   completion(nil, err)
                   return
               }
               guard let json = try? JSONSerialization.jsonObject(with: d) as? [String: Any] else {
                   completion(nil, NSError(domain: "com.esgi.requete.invalid-json", code: 1))
                   return
               }
               if let requete = RequeteFactory.requete(from: json) {
                   completion(requete, nil)
               } else {
                   completion(nil, NSError(domain: "com.esgi.requete.invalid-requete-data", code: 2))
               }
           }
           task.resume()
       }
     
    
}
