//
//  SubCategoryTypeModel.swift
//  stylehut
//
//  Created by MACM26 on 04/06/25.
//

import Foundation
//
//struct SubCategoryTypeModel: Codable {
//    var items: [SubCategoryTypeProduct]
//    let meta: Meta?
//}
//
//
//struct SubCategoryTypeProduct: Codable {
//    var id: Int
//    var name: String
//    var image: [String]
//    var price: String
//    var discount: Int
//    var brand: SubCategoryTypeProductBrand?
//}
//
//struct SubCategoryTypeProductBrand: Codable {
//    var id : Int
//    var name: String
//}
//
//struct Meta: Codable {
//    let page: Int
//    let pageSize: Int
//    let total: Int
//    let totalPages: Int
//}

struct APIResponse: Codable {
    let status: Int
    let success: Bool
    let message: String
    let data: SubCategoryTypeModel
}


// MARK: - Root Model
struct SubCategoryTypeModel: Codable {
    let items: [SubCategoryTypeProduct]
    let meta: Meta?
}

// MARK: - Product
struct SubCategoryTypeProduct: Codable {
    let id: Int
    let name: String
    let image: [String]
    let price: String
    let discount: Int?
    let brand: SubCategoryTypeProductBrand?
}

// MARK: - Brand
struct SubCategoryTypeProductBrand: Codable {
    let id: Int
    let name: String
}

// MARK: - Pagination Meta
struct Meta: Codable {
    let page: Int
    let pageSize: Int
    let total: Int
    let totalPages: Int
}
