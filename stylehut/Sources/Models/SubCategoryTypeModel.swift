//
//  SubCategoryTypeModel.swift
//  stylehut
//
//  Created by MACM26 on 04/06/25.
//

import Foundation

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
    let wishlist: [SubCategoryTypeIsWishListed]?
    var isInWishlist: Bool?
}

struct SubCategoryTypeIsWishListed: Codable {
    let product_id: Int

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


//Brand response

// MARK: - Root API Response
struct BrandResponse: Codable {
    let status: Int
    let success: Bool
    let data: BrandData
}

// MARK: - Data Container
struct BrandData: Codable {
    let items: [BrandItem]
}

// MARK: - Brand Item
struct BrandItem: Codable {
    let id: Int
    let name: String
}

struct ProductFilter {
    var selectedBrandId: Int? 
    var minPrice: Int
    var maxPrice: Int
    var minDiscount: Int
    var maxDiscount: Int
}
