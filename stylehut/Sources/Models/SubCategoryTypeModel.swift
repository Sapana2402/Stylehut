//
//  SubCategoryTypeModel.swift
//  stylehut
//
//  Created by MACM26 on 04/06/25.
//

import Foundation

struct SubCategoryTypeModel: Codable {
    var items: [SubCategoryTypeProduct]
    let meta: Meta?
}


struct SubCategoryTypeProduct: Codable {
    var id: Int
    var name: String
    var image: [String]
    var price: String
    var discount: Int
    var brand: SubCategoryTypeProductBrand?
}

struct SubCategoryTypeProductBrand: Codable {
    var id : Int
    var name: String
}

struct Meta: Codable {
    let page: Int
    let pageSize: Int
    let total: Int
    let totalPages: Int
}
