//
//  ProductDetailsViewModel.swift
//  stylehut
//
//  Created by MACM26 on 06/06/25.
//

import Foundation

class ProductDetailsViewModel {
    var productData : ProductDetailsData?
    
    func getProducts(productId:Int,compelation: @escaping () -> Void) async {
        let url = "\(k.urls.baseURL)/product/\(productId)"
        await NetworkManager.getProductDetails(urlSting: url) { product, error in
           if let products = product {
               self.productData = products
               compelation()
            }
            
        }
    }
    
}
