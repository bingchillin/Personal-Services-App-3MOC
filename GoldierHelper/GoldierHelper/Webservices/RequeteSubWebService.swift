//
//  RequeteSubWebService.swift
//  GoldierHelper
//
//  Created by Thanudi Madawala on 27/08/2023.
//

import Foundation

class RequeteSubWebService {
    class func getAllRequeteSub(completion: @escaping ([RequeteSub]?, Error?) -> Void) {
        guard let requetesSubURL = URL(string: "http://localhost:3000/requetesSub/") else {
            return
        }
        let task = URLSession.shared.dataTask(with: requetesSubURL) { data, res, err in
            guard err == nil, let d = data else {
                completion(nil, err)
                return
            }
            guard let json = try? JSONSerialization.jsonObject(with: d) as? [ [String: Any] ] else {
                completion(nil, NSError(domain: "com.esgi.requete.invalid-json", code: 1))
                return
            }
            let requeteSubs = RequeteSubFactory.requeteSubs(from: json)
           completion(requeteSubs, nil) // fin OK
        }
        task.resume()
    }
    
    class func createSubRequest(parameters: String, completion: @escaping (Bool) -> Void) {
        guard let subRequestURL = URL(string: "http://localhost:3000/requetesSub/") else {
            print("Not found SubRequest URL")
            completion(false) // Indicate failure in the completion handler
            return
        }
        
        let postData = parameters.data(using: .utf8)
        
        var request = URLRequest(url: subRequestURL)
        request.addValue("application/json", forHTTPHeaderField: "Content-Type")
        
        request.httpMethod = "POST"
        request.httpBody = postData
        
        let task = URLSession.shared.dataTask(with: request) { data, response, error in
            guard let httpResponse = response as? HTTPURLResponse else {
                print("Invalid HTTP response")
                completion(false)
                return
            }
            
            print("HTTP status code:", httpResponse.statusCode)
            
            if httpResponse.statusCode == 200 {
                completion(true) // Indicate success based on the HTTP status code
            } else {
                completion(false) // Indicate failure based on the HTTP status code
            }
        }
        
        task.resume()
    }
}


