//
//  ProductModel.swift
//  stylehut
//
//  Created by MACM26 on 21/05/25.
//

import Foundation


struct ProductsResponse : Codable{
   var data: ProductData
}

struct ProductData: Codable {
    var items : [Product]
}

struct Product: Codable {
    var name : String
    var price : String
    var image: [String]
    var category: categoryName
}

struct categoryName: Codable {
   var name: String
}

struct RegisterResponse: Codable {
    let message: String
}

struct OTPResponse: Codable {
    let message: String
    let token: String
}




struct CategoriesResponse: Codable {
    let status: Int
    let data: CategoryData
}

struct CategoryData: Codable {
    let categories: [Category]
}

struct Category: Codable {
    let id: Int
    let name: String
    let sub_categories: [SubCategory]
}

struct SubCategory: Codable {
    let id: Int
    let name: String
    let sub_category_types: [SubCategoryType]
}

struct SubCategoryType: Codable {
    let id: Int
    let name: String
}



