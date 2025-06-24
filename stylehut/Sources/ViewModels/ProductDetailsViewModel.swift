//
//  ProductDetailsViewModel.swift
//  stylehut
//
//  Created by MACM26 on 06/06/25.
//

import Foundation

class ProductDetailsViewModel {
    var productData: ProductDetailsData?
    
    func getProducts(productId: Int) async {
        let url = "\(k.urls.baseURL)/product/\(productId)"
        if let products = await NetworkManager.getProductDetails(urlString: url) {
            self.productData = products
        } else {
            print("Failed to load product details")
            self.productData = nil
        }
    }
    
}
