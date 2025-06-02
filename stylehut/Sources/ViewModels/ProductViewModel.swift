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
        let url = "https://stylehut-be.vercel.app/api/product?page=1&pageSize=10&sortBy=popularity&order=desc"
        await NetworkManager.getAllProducts(urlSting: url) { product, error in
           if let products = product {
               self.productsData = products
               compelation()
            }
            
        }
    }
    
}
