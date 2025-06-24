//
//  ProductViewModel.swift
//  stylehut
//
//  Created by MACM26 on 21/05/25.
//

import Foundation

class ProductViewNodel {
    var productsData : [Product] = []
    
    func getProducts(compelation: @escaping () -> Void) async {
        let url = "\(k.urls.baseURL)/product?page=1&pageSize=10&sortBy=popularity&order=desc"
        await NetworkManager.getAllProducts(urlString: url) { product, error in
           if let products = product {
               self.productsData = products
               compelation()
            }
            
        }
    }
    
}
