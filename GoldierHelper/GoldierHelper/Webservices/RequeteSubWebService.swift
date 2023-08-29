//
//  RequeteSubWebService.swift
//  GoldierHelper
//
//  Created by Thanudi Madawala on 27/08/2023.
//

import Foundation

class RequeteSubWebService {
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


