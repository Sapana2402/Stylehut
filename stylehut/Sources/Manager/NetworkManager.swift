//
//  NetworkManager.swift
//  stylehut
//
//  Created by MACM26 on 21/05/25.
//

import Foundation

class NetworkManager {

    private static func createRequest(
        urlString: String,
        method: String,
        body: [String: Any]? = nil,
        requiresAuth: Bool = false,
        timeout: TimeInterval = 10
    ) throws -> URLRequest {
        guard let url = URL(string: urlString) else {
            throw URLError(.badURL)
        }

        var request = URLRequest(url: url)
        request.httpMethod = method
        request.timeoutInterval = timeout

        if let body = body {
            request.httpBody = try JSONSerialization.data(withJSONObject: body)
            request.setValue("application/json", forHTTPHeaderField: "Content-Type")
        }

        if requiresAuth, let token = AuthManager.shared.token {
            request.setValue("Bearer \(token)", forHTTPHeaderField: "Authorization")
        }

        return request
    }

    class func getAllProducts(urlString: String, completion: @escaping ([Product]?, String?) -> Void) async {
        do {
            let request = try createRequest(urlString: urlString, method: k.httpMethods.get)
            let (data, _) = try await URLSession.shared.data(for: request)
            let decodedResponse = try JSONDecoder().decode(ProductsResponse.self, from: data)
            completion(decodedResponse.data.items, nil)
        } catch {
            completion(nil, error.localizedDescription)
        }
    }

    class func getCategories(urlString: String, completion: @escaping ([Category]?, String?) -> Void) async {
        do {
            let request = try createRequest(urlString: urlString, method: k.httpMethods.get)
            let (data, _) = try await URLSession.shared.data(for: request)
            let decodedResponse = try JSONDecoder().decode(CategoriesResponse.self, from: data)
            completion(decodedResponse.data.categories, nil)
        } catch {
            completion(nil, error.localizedDescription)
        }
    }

    class func registerUser(email: String, completion: @escaping (Bool, String?) -> Void) async {
        do {
            let request = try createRequest(urlString: k.urls.register, method: k.httpMethods.post, body: ["email": email])
            let (data, response) = try await URLSession.shared.data(for: request)
            if let httpResponse = response as? HTTPURLResponse, httpResponse.statusCode == 200 {
                let decoded = try JSONDecoder().decode(RegisterResponse.self, from: data)
                completion(true, decoded.message)
            } else {
                completion(false, "Failed with status code: \((response as? HTTPURLResponse)?.statusCode ?? 0)")
            }
        } catch {
            completion(false, error.localizedDescription)
        }
    }

    class func otpVerification(email: String, otp: String, completion: @escaping (Bool, String?) -> Void) async {
        do {
            let requestBody = ["email": email, "otp": otp]
            let request = try createRequest(urlString: k.urls.verifyOTP, method: k.httpMethods.post, body: requestBody)
            let (data, response) = try await URLSession.shared.data(for: request)
            if let httpResponse = response as? HTTPURLResponse, httpResponse.statusCode == 200 {
                let decoded = try JSONDecoder().decode(OTPResponse.self, from: data)
                AuthManager.shared.token = decoded.token
                UserDefaults.standard.set(decoded.token, forKey: "userToken")
                UserDefaults.standard.set(email, forKey: "userEmail")
                completion(true, nil)
            } else {
                completion(false, "Failed with status code: \((response as? HTTPURLResponse)?.statusCode ?? 0)")
            }
        } catch {
            completion(false, error.localizedDescription)
        }
    }

    class func getSubCategoriesTypeList(urlString: String, completion: @escaping ([SubCategoryTypeProduct]?, String?) -> Void) async {
        do {
            let request = try createRequest(urlString: urlString, method: k.httpMethods.get, requiresAuth: true, timeout: 20)
            let (data, _) = try await URLSession.shared.data(for: request)
            let decodedResponse = try JSONDecoder().decode(APIResponse.self, from: data)
            completion(decodedResponse.data.items, nil)
        } catch {
            completion(nil, error.localizedDescription)
        }
    }

    class func getProductDetails(urlString: String) async -> ProductDetailsData? {
        do {
            let request = try createRequest(urlString: urlString, method: k.httpMethods.get)
            let (data, _) = try await URLSession.shared.data(for: request)
            let decodedResponse = try JSONDecoder().decode(ProductDetailsAPIResponse.self, from: data)
            return decodedResponse.data
        } catch {
            print("Error fetching product details: \(error)")
            return nil
        }
    }

    class func wishListProduct(product_id: Int) async -> Bool {
        do {
            let request = try createRequest(urlString: k.urls.wishList, method: k.httpMethods.post, body: ["product_id": product_id], requiresAuth: true)
            let (_, response) = try await URLSession.shared.data(for: request)
            return (response as? HTTPURLResponse)?.statusCode == 200
        } catch {
            return false
        }
    }

    class func getBrand(urlString: String) async -> BrandData? {
        do {
            let request = try createRequest(urlString: urlString, method: k.httpMethods.get, requiresAuth: true)
            let (data, _) = try await URLSession.shared.data(for: request)
            let decodedResponse = try JSONDecoder().decode(BrandResponse.self, from: data)
            return decodedResponse.data
        } catch {
            print("Error fetching brand data: \(error)")
            return nil
        }
    }

    class func addToCart(product_id: Int, size_quantity_id: Int) async -> Bool {
        let body = ["product_id": product_id, "quantity": 1, "size_quantity_id": size_quantity_id]
        do {
            let request = try createRequest(urlString: k.urls.addToCart, method: k.httpMethods.post, body: body, requiresAuth: true)
            let (_, response) = try await URLSession.shared.data(for: request)
            return (response as? HTTPURLResponse)?.statusCode == 200
        } catch {
            return false
        }
    }

    class func getWishListedProduct(urlString: String) async -> wishlistData? {
        do {
            let request = try createRequest(urlString: urlString, method: k.httpMethods.get, requiresAuth: true)
            let (data, _) = try await URLSession.shared.data(for: request)
            let decodedResponse = try JSONDecoder().decode(wishlistResponse.self, from: data)
            return decodedResponse.data
        } catch {
            print("Error fetching wishlist: \(error)")
            return nil
        }
    }

    class func removeFromWishList(product_id: Int) async -> Bool {
        do {
            let request = try createRequest(urlString: k.urls.wishList, method: k.httpMethods.post, body: ["product_id": product_id], requiresAuth: true)
            let (_, response) = try await URLSession.shared.data(for: request)
            return (response as? HTTPURLResponse)?.statusCode == 200
        } catch {
            return false
        }
    }

    class func getCartProduct(urlString: String) async -> CartData? {
        do {
            let request = try createRequest(urlString: urlString, method: k.httpMethods.get, requiresAuth: true)
            let (data, _) = try await URLSession.shared.data(for: request)
            let decodedResponse = try JSONDecoder().decode(CartResponse.self, from: data)
            return decodedResponse.data
        } catch {
            print("Error fetching cart data: \(error)")
            return nil
        }
    }
}
