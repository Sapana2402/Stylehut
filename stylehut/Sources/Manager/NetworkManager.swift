//
//  NetworkManager.swift
//  stylehut
//
//  Created by MACM26 on 21/05/25.
//

import Foundation

class NetworkManager {
    class func getAllProducts(urlSting: String, compelation: @escaping([Product]?, String?)-> Void) async {
        guard let url = URL(string: urlSting) else {
            fatalError("Invalid URL")
        }
        
        var request = URLRequest(url: url)
        request.httpMethod = k.httpMethods.get
        request.timeoutInterval = 10
        
        do{
            let (data,_) = try await URLSession.shared.data(for: request)
            let decodedResponse = try JSONDecoder().decode(ProductsResponse.self, from: data)
            compelation(decodedResponse.data.items, nil)
        }catch {
            compelation(nil, "Something want wrong")
        }
    }
    
    class func getCategories(urlSting: String, compelation: @escaping([Category]?, String?)-> Void) async {
        guard let url = URL(string: urlSting) else {
            fatalError("Invalid URL")
        }
        
        var request = URLRequest(url: url)
        request.httpMethod = k.httpMethods.get
        request.timeoutInterval = 10
        
        do{
            let (data,_) = try await URLSession.shared.data(for: request)
            let decodedResponse = try JSONDecoder().decode(CategoriesResponse.self, from: data)
            compelation(decodedResponse.data.categories, nil)
        }catch {
            compelation(nil, "Something want wrong")
        }
    }
    
    
    
    class func registerUser(email: String, completion: @escaping (Bool, String?) -> Void) async {
        guard let url = URL(string: k.urls.register) else {
            fatalError("Invalid URL")
        }
        
        var request = URLRequest(url: url)
        request.httpMethod = k.httpMethods.post
        request.timeoutInterval = 10
        
        let requestBody = ["email": email]
        
        do{
            let jsonRequest =  try  JSONSerialization.data(withJSONObject: requestBody, options: [])
            request.httpBody = jsonRequest
            let (data, response) = try await URLSession.shared.data(for: request)
            if let httpResponse = response as? HTTPURLResponse{
                if httpResponse.statusCode ==  200{
                    let decoded = try JSONDecoder().decode(RegisterResponse.self, from: data)
                                    completion(true, decoded.message)
                }else{
                    completion(false, "Failed with status code: \(httpResponse.statusCode)")
                }
            }else{
                completion(false, "Invalid server response")
            }

        }catch{
            completion(false, "Something went wrong: \(error.localizedDescription)")
        }
    }
    
    class func otpVerification(email: String,otp: String, completion: @escaping (Bool, String?) -> Void) async {
        guard let url = URL(string: k.urls.verifyOTP) else {
            fatalError("Invalid URL")
        }
        
        var request = URLRequest(url: url)
        request.httpMethod = k.httpMethods.post
        request.timeoutInterval = 10
        
        let requestBody:[String: Any] = ["email": email,"otp": otp]
        do{
            let jsonRequest =  try  JSONSerialization.data(withJSONObject: requestBody, options: [])
            request.httpBody = jsonRequest
            let (data, response) = try await URLSession.shared.data(for: request)
            if let httpResponse = response as? HTTPURLResponse{
                if httpResponse.statusCode ==  200{
                    let decoded = try JSONDecoder().decode(OTPResponse.self, from: data)
                    print("decoded",decoded.token)
                    AuthManager.shared.token = decoded.token
                                    completion(true, "")
                    UserDefaults.standard.set(decoded.token, forKey: "userToken")
                    
                }else{
                    completion(false, "Failed with status code: \(httpResponse.statusCode)")
                }
            }else{
                completion(false, "Invalid server response")
            }

        }catch{
            completion(false, "Something went wrong: \(error.localizedDescription)")
        }
    }
    
    class func getSubCategoriesTypeList(urlSting: String, compelation: @escaping([SubCategoryTypeProduct]?, String?)-> Void) async {
        guard let url = URL(string: urlSting) else {
            fatalError("Invalid URL")
        }
        var request = URLRequest(url: url)
        request.httpMethod = k.httpMethods.get
        request.timeoutInterval = 20
        do{
            let (data,_) = try await URLSession.shared.data(for: request)
            let decodedResponse = try JSONDecoder().decode(APIResponse.self, from: data)
            compelation(decodedResponse.data.items, nil)

        }catch {
            print("Decoding error:", error.localizedDescription)
            compelation(nil, "Something want wrong")
        }
    }
    
    class func getProductDetails(urlSting: String, compelation: @escaping(ProductDetailsData?, String?)-> Void) async {
        guard let url = URL(string: urlSting) else {
            fatalError("Invalid URL")
        }
        
        var request = URLRequest(url: url)
        request.httpMethod = k.httpMethods.get
        request.timeoutInterval = 10
        
        do{
            let (data,_) = try await URLSession.shared.data(for: request)
            let decodedResponse = try JSONDecoder().decode(ProductDetailsAPIResponse.self, from: data)
            compelation(decodedResponse.data, nil)
        }catch {
            compelation(nil, "Something want wrong")
        }
    }
}
