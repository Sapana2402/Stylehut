//
//  SubCategoryTypeViewModel.swift
//  stylehut
//
//  Created by MACM26 on 04/06/25.
//

import Foundation

class SubCategoryTypeViewModel {
    var subCategoryTypeProductData : [SubCategoryTypeProduct] = []
    
    func getProducts(compelation: @escaping () -> Void) async {
        print("INside model")
        let url = "https://stylehut-be.vercel.app/api/product?page=1&pageSize=10&sortBy=create_at&order=desc&minPrice=0&maxPrice=100000&category_id=1&sub_category_id=1&sub_category_type_id=1&brand_id=0&minDiscount=0&maxDiscount=100"
        await NetworkManager.getSubCategoriesTypeList(urlSting: url) { product, error in
           if let products = product {
               print("Data====",products)
               self.subCategoryTypeProductData = products
               compelation()
            }
            
        }
    }
    
}
