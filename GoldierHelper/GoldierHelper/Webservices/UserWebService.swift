//
//  UserWebService.swift
//  GoldierHelper
//
//  Created by Thanudi Madawala on 18/07/2023.
//

import Foundation

class UserWebService {
    
    //Recuperer tout les users
    class func getAllUsers(completion: @escaping ([User]?, Error?) -> Void) {
        guard let userURL = URL(string: "http://localhost:3000/users/") else {
            return
        }
        let task = URLSession.shared.dataTask(with: userURL) { data, res, err in
            guard err == nil, let d = data else {
                completion(nil, err)
                return
            }
            guard let json = try? JSONSerialization.jsonObject(with: d) as? [ [String: Any] ] else {
                completion(nil, NSError(domain: "com.esgi.user.invalid-json", code: 1))
                return
            }
            let users = UserFactory.users(from: json)
           completion(users, nil) // fin OK
        }
        task.resume()
    }
    
    //Récup 1 user
    class func getUserById(userId: Int, completion: @escaping (User?, Error?) -> Void) {
        guard let userURL = URL(string: "http://localhost:3000/users/\(userId)") else {
            return
        }
        let task = URLSession.shared.dataTask(with: userURL) { data, res, err in
            guard err == nil, let d = data else {
                completion(nil, err)
                return
            }
            guard let json = try? JSONSerialization.jsonObject(with: d) as? [String: Any] else {
                completion(nil, NSError(domain: "com.esgi.user.invalid-json", code: 1))
                return
            }
            if let user = UserFactory.user(from: json) {
                completion(user, nil)
            } else {
                completion(nil, NSError(domain: "com.esgi.user.invalid-user-data", code: 2))
            }
        }
        task.resume()
    }
    
    // Inscription
    class func registerUser(parameters: String) {
            guard let userURL = URL(string: "http://localhost:3000/users/") else {
                        print("Not found RegisterUser URL")
                        return
                    }
            let postData = parameters.data(using: .utf8)
        
            var request = URLRequest(url: userURL)
            request.addValue("application/json", forHTTPHeaderField: "Content-Type")

            request.httpMethod = "POST"
            request.httpBody = postData

            let task = URLSession.shared.dataTask(with: request) { data, response, error in
              guard let data = data else {
                print(String(describing: error))
                return
              }
              print(String(data: data, encoding: .utf8)!)
            }

            task.resume()
        }
    
    class func loginUser(parameters: String, completion: @escaping (User?, Error?) -> Void) {
        guard let userURL = URL(string: "http://localhost:3000/login/") else {
            print("Not found LoginUser URL")
            return
        }
        
        guard let postData = parameters.data(using: .utf8) else {
            print("Erreur lors de la conversion des paramètres en données")
            return
        }
        
        var request = URLRequest(url: userURL)
        request.addValue("application/json", forHTTPHeaderField: "Content-Type")
        request.httpMethod = "POST"
        request.httpBody = postData
        
        let task = URLSession.shared.dataTask(with: request) { data, response, error in
            if let error = error {
                completion(nil, error)
                return
            }
            
            guard let data = data else {
                completion(nil, NSError(domain: "com.esgi.user.no-data", code: 1))
                return
            }
            
            do {
                if let json = try JSONSerialization.jsonObject(with: data, options: []) as? [String: Any] {
                    if let message = json["message"] as? String, message == "Login successful", let userData = json["user"] as? [String: Any] {
                        if let user = UserFactory.user(from: userData) {
                            completion(user, nil)
                        } else {
                            completion(nil, NSError(domain: "com.esgi.user.invalid-data", code: 1))
                        }
                    } else {
                        completion(nil, NSError(domain: "com.esgi.user.login-failed", code: 1))
                    }
                } else {
                    completion(nil, NSError(domain: "com.esgi.user.invalid-json", code: 1))
                }
            } catch {
                completion(nil, error)
            }
        }
        
        task.resume()
    }

    class func logoutUser(parameters: String) {

        guard let userURL = URL(string: "http://localhost:3000/logout/") else {
                    print("Not found LoginOut URL")
                    return
                }
        
        let postData = parameters.data(using: .utf8)
        var request = URLRequest(url: userURL)
        request.addValue("application/json", forHTTPHeaderField: "Content-Type")

        request.httpMethod = "POST"
        request.httpBody = postData

        let task = URLSession.shared.dataTask(with: request) { data, response, error in
          guard let data = data else {
            print(String(describing: error))
            return
          }
          print(String(data: data, encoding: .utf8)!)
        }
        task.resume()
    }
    
}
