//
//  APIHandler.swift
//  WeatherApp
//
//  Created by MAC-Air on 08/09/23.
//

import Foundation
import UIKit


class APIHandler {
    static var shared: APIHandler = APIHandler()
    
    init() {}
    
    func getAPIValues<T:Codable>(type: T.Type, apiUrl: String, method: String, onCompletion: @escaping (Result<T, Error>) -> Void) {
        
        guard let url = URL(string: apiUrl) else {
            let error = NSError(domain: "Invalid URL", code: 0, userInfo: nil)
            onCompletion(.failure(error))
            return
        }
        
        var request = URLRequest(url: url)
        request.httpMethod = "GET"
        
        let task = URLSession.shared.dataTask(with: request) { (data, response, error) in
            if let error = error {
                onCompletion(.failure(error))
                return
            }
            
            guard let data = data else {
                let error = NSError(domain: "No data received", code: 1, userInfo: nil)
                onCompletion(.failure(error))
                return
            }
            
            do {
                let decodedData = try JSONDecoder().decode(type, from: data)
                onCompletion(.success(decodedData))
                //print(decodedData)
            } catch {
                onCompletion(.failure(error))
            }
        }
        
        task.resume()
    }
    
    func postAPIValues<T: Codable>(
        type: T.Type,
        apiUrl: String,
        method: String,
        formData: [String: Any], // Dictionary for form data parameters
        onCompletion: @escaping (Result<T, Error>) -> Void) {
            guard let url = URL(string: apiUrl) else {
            let error = NSError(domain: "Invalid URL", code: 0, userInfo: nil)
            onCompletion(.failure(error))
            return
        }
        
        var request = URLRequest(url: url)
        request.httpMethod = "POST"
        
        // Construct the form data string
        var formDataString = ""
        for (key, value) in formData {
            formDataString += "\(key)=\(value)&"
        }
        formDataString = String(formDataString.dropLast()) // Remove the trailing "&"
        
        // Set the request body
        request.httpBody = formDataString.data(using: .utf8)
        
        // Set the content type to "application/x-www-form-urlencoded"
        request.setValue("application/x-www-form-urlencoded", forHTTPHeaderField: "Content-Type")
        
        let task = URLSession.shared.dataTask(with: request) { (data, response, error) in
            if let error = error {
                onCompletion(.failure(error))
                return
            }
            
            guard let data = data else {
                let error = NSError(domain: "No data received", code: 1, userInfo: nil)
                onCompletion(.failure(error))
                return
            }
            
            do {
                let decodedData = try JSONDecoder().decode(type, from: data)
                onCompletion(.success(decodedData))
                // print(decodedData)
            } catch {
                onCompletion(.failure(error))
            }
        }
        
        task.resume()
    }
    
    
//    func postAPIValues<T: Codable>(
//        type: T.Type,
//        apiUrl: String,
//        method: String,
//        jsonBody: [String: Any], // Use [String: Any] for JSON data
//        onCompletion: @escaping (Result<T, Error>) -> Void
//    ) {
//        guard let url = URL(string: apiUrl) else {
//            let error = NSError(domain: "Invalid URL", code: 0, userInfo: nil)
//            onCompletion(.failure(error))
//            return
//        }
//
//        var request = URLRequest(url: url)
//        request.httpMethod = method
//
//        // Convert the JSON body to Data
//        do {
//            let jsonData = try JSONSerialization.data(withJSONObject: jsonBody)
//            request.httpBody = jsonData
//            request.setValue("application/json", forHTTPHeaderField: "Content-Type")
//        } catch {
//            onCompletion(.failure(error))
//            return
//        }
//
//        let task = URLSession.shared.dataTask(with: request) { (data, response, error) in
//            // Your existing completion handling logic
//        }
//
//        task.resume()
//    }
//
//    
//    
//    
    
    
//    func postAPIValues<T: Codable>(
//        type: T.Type,
//        apiUrl: String,
//        formData: [String: String], // Dictionary for form data parameters
//        onCompletion: @escaping (Result<T, Error>) -> Void
//    ) {
//        guard let url = URL(string: apiUrl) else {
//            let error = NSError(domain: "Invalid URL", code: 0, userInfo: nil)
//            onCompletion(.failure(error))
//            return
//        }
//
//        var components = URLComponents(url: url, resolvingAgainstBaseURL: false)
//        var queryItems = [URLQueryItem]()
//        for (key, value) in formData {
//            queryItems.append(URLQueryItem(name: key, value: value))
//        }
//        components?.queryItems = queryItems
//
//        var request = URLRequest(url: components?.url ?? url)
//        request.httpMethod = "POST"
//
//        let task = URLSession.shared.dataTask(with: request) { (data, response, error) in
//            if let error = error {
//                onCompletion(.failure(error))
//                return
//            }
//
//            guard let data = data else {
//                let error = NSError(domain: "No data received", code: 1, userInfo: nil)
//                onCompletion(.failure(error))
//                return
//            }
//
//            do {
//                let decodedData = try JSONDecoder().decode(type, from: data)
//                onCompletion(.success(decodedData))
//            } catch {
//                onCompletion(.failure(error))
//            }
//        }
//
//        task.resume()
//    }

    func requestDeleteAPI(url: String, method: String, completion: @escaping (Result<[String: Any], Error>) -> Void) {
        guard let apiUrl = URL(string: url) else {
            completion(.failure(NSError(domain: "Invalid URL", code: 0, userInfo: nil)))
            return
        }

        var request = URLRequest(url: apiUrl)
        request.httpMethod = method

        URLSession.shared.dataTask(with: request) { data, response, error in
            if let error = error {
                completion(.failure(error))
                return
            }

            if let data = data,
               let jsonData = try? JSONSerialization.jsonObject(with: data, options: []) as? [String: Any] {
                completion(.success(jsonData))
            } else {
                completion(.failure(NSError(domain: "Invalid JSON", code: 0, userInfo: nil)))
            }
        }.resume()
    }
    
    
    func requestAPI(url: String, method: String, parameters: [String: Any]?, completion: @escaping (Result<[String: Any], Error>) -> Void) {
            guard let apiUrl = URL(string: url) else {
                completion(.failure(NSError(domain: "Invalid URL", code: 0, userInfo: nil)))
                return
            }

            var request = URLRequest(url: apiUrl)
            request.httpMethod = method

            // Add POST request specific configuration
            if method == "POST", let parameters = parameters {
                request.httpBody = try? JSONSerialization.data(withJSONObject: parameters)
                request.setValue("application/json", forHTTPHeaderField: "Content-Type")
            }

            URLSession.shared.dataTask(with: request) { data, response, error in
                if let error = error {
                    completion(.failure(error))
                    return
                }

                if let data = data,
                   let jsonData = try? JSONSerialization.jsonObject(with: data, options: []) as? [String: Any] {
                    completion(.success(jsonData))
                } else {
                    completion(.failure(NSError(domain: "Invalid JSON", code: 0, userInfo: nil)))
                }
            }.resume()
        }

}





        
