//
//  WishListModel.swift
//  stylehut
//
//  Created by MACM26 on 19/06/25.
//

import Foundation

struct wishlistResponse: Codable {
    let status: Int
    let success: Bool
    let message: String
    let data: wishlistData
}

struct wishlistData: Codable {
    var items: [wishlistItem]
    let meta: wishlistMeta
}

struct wishlistItem: Codable {
    let id: Int
    let user_id: Int
    let product_id: Int
    let created_at: String
    let is_deleted: Bool
    let products: wishlistProduct
}

struct wishlistProduct: Codable {
    let id: Int
    let name: String
    let description: String
    let image: [String]
    let price: String
    let discount: Int
    let category: wishlistCategory
    let sub_category: wishlistSubCategory
    let sub_category_type: wishlistSubCategoryType
    let brand: wishlistBrand
    let size_quantities: [wishlistSizeQuantity]
}

struct wishlistCategory: Codable {
    let id: Int
    let name: String
    let description: String
    let create_at: String
    let updated_at: String
    let is_deleted: Bool
}

struct wishlistSubCategory: Codable {
    let id: Int
    let name: String
    let description: String
    let create_at: String
    let updated_at: String
    let is_deleted: Bool
    let category_id: Int
}

struct wishlistSubCategoryType: Codable {
    let id: Int
    let name: String
    let description: String
    let category_id: Int
    let sub_category_id: Int
    let create_at: String
    let updated_at: String
    let is_deleted: Bool
}

struct wishlistBrand: Codable {
    let id: Int
    let name: String
    let description: String
    let create_at: String
    let updated_at: String
    let is_deleted: Bool
}

struct wishlistSizeQuantity: Codable {
    let id: Int
    let quantity: Int
    let price: String
    let discount: String
    let product_id: Int?
    let custom_product_id: String
    let variant_id: Int?
    let size_id: Int
    let create_at: String
    let updated_at: String
    let is_deleted: Bool
    let size_data: wishlistSizeData
}

struct wishlistSizeData: Codable {
    let id: Int
    let size: String
    let name: String
    let has_size_chart: Bool
    let is_cm: Bool
    let type: String
    let custom_size_id: String
    let create_at: String
    let updated_at: String
    let is_deleted: Bool
}

struct wishlistMeta: Codable {
    let page: Int
    let pageSize: Int
    let total: Int
    let totalPages: Int
}

