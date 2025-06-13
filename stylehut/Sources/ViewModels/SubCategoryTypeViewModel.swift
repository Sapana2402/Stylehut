//
//  SubCategoryTypeViewModel.swift
//  stylehut
//
//  Created by MACM26 on 04/06/25.
//

import Foundation

class SubCategoryTypeViewModel {
    var subCategoryTypeProductData : [SubCategoryTypeProduct] = []
    var brandsData : BrandData?
    
    func getProducts(selectedCategoryId:Int,selectedSubCategoryId: Int,selectedSubCategoryTypeId:Int,compelation: @escaping () -> Void) async {
        let url = "https://stylehut-be.vercel.app/api/product?page=1&pageSize=10&sortBy=create_at&order=desc&minPrice=0&maxPrice=100000&category_id=\(selectedCategoryId)&sub_category_id=\(selectedSubCategoryId)&sub_category_type_id=\(selectedSubCategoryTypeId)&brand_id=0&minDiscount=0&maxDiscount=100"
        
        await NetworkManager.getSubCategoriesTypeList(urlSting: url) { product, error in
           if let products = product {
               self.subCategoryTypeProductData = products
               compelation()
            }
        }
    }
    
    func getBrandsData() async {
        let url = k.urls.brand
        if let brandList = await NetworkManager.getBrand(urlSting: url) {
            self.brandsData = brandList
            print("BrandList", brandList)
        } else {
            print("Failed to load product details")
            self.brandsData = nil
        }
    }
}
