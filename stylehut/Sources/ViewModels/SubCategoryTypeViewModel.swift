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
    var activeFilter = ProductFilter(
        selectedBrandId: 0,
        minPrice: 0,
        maxPrice: 100000,
        minDiscount: 0,
        maxDiscount: 100
    )

    func applyFilter(_ filter: ProductFilter) {
        self.activeFilter = filter
    }

    
    func getProducts(selectedCategoryId:Int,selectedSubCategoryId: Int,selectedSubCategoryTypeId:Int,compelation: @escaping () -> Void) async {
        let url = "\(k.urls.baseURL)/product?page=1&pageSize=10&sortBy=create_at&order=desc&minPrice=0&maxPrice=\(activeFilter.maxPrice)&category_id=\(selectedCategoryId)&sub_category_id=\(selectedSubCategoryId)&sub_category_type_id=\(selectedSubCategoryTypeId)&brand_id=\(activeFilter.selectedBrandId ?? 0)&minDiscount=0&maxDiscount=\(activeFilter.maxDiscount)"
        print("url",url)
        await NetworkManager.getSubCategoriesTypeList(urlString: url) { product, error in
           if let products = product {
               self.subCategoryTypeProductData = products
               print("products",products)
               compelation()
            }
        }
    }
    
    func getBrandsData() async {
        let url = k.urls.brand
        if let brandList = await NetworkManager.getBrand(urlString: url) {
            self.brandsData = brandList
            print("BrandList", brandList)
        } else {
            print("Failed to load product details")
            self.brandsData = nil
        }
    }
}
