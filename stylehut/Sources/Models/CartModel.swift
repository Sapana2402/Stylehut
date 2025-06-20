//
//  CartModel.swift
//  stylehut
//
//  Created by MACM26 on 20/06/25.
//

import Foundation

struct CartResponse: Codable {
    let status: Int
    let success: Bool
    let message: String
    let data: CartData
}

struct CartData: Codable {
    let user: CartUser
    let defaultAddress: CartDefaultAddress
    let items: [CartItem]
    let total: Int
    let totalAmount: Double
}

struct CartUser: Codable {
    let id: Int
    let first_name: String
    let last_name: String
    let email: String
    let mobile: String
}

struct CartDefaultAddress: Codable {
    let id: Int
    let full_name: String
    let phone: String
    let address_line1: String
    let address_line2: String
    let city: String
    let state: String
    let postal_code: String
    let address_type: String
    let is_open_saturday: Bool
    let is_open_sunday: Bool
}

struct CartItem: Codable {
    let id: Int
    let cart_id: Int
    let product_id: Int
    let quantity: Int
    let size_quantity_id: Int
    let color: String?
    let created_at: String
    let updated_at: String
    let is_deleted: Bool
    let product: CartProduct
    let size_quantity: CartSizeQuantity
}

struct CartProduct: Codable {
    let id: Int
    let name: String
    let description: String
    let image: [String]
    let price: String
    let discount: Int
    let custom_product_id: String
    let category_id: Int
    let sub_category_id: Int
    let sub_category_type_id: Int
    let brand_id: Int
    let size_quantity_id: Int
    let create_at: String
    let updated_at: String
    let is_deleted: Bool
    let is_featured: Bool
    let views_count: Int
    let variant_id: String
    let is_main_product: Bool
    let category: CartCategory
    let sub_category: CartSubCategory
    let sub_category_type: CartSubCategoryType
    let brand: CartBrand
}

struct CartCategory: Codable {
    let id: Int
    let name: String
    let description: String
    let create_at: String
    let updated_at: String
    let is_deleted: Bool
}

struct CartSubCategory: Codable {
    let id: Int
    let name: String
    let description: String
    let create_at: String
    let updated_at: String
    let is_deleted: Bool
    let category_id: Int
}

struct CartSubCategoryType: Codable {
    let id: Int
    let name: String
    let description: String
    let category_id: Int
    let sub_category_id: Int
    let create_at: String
    let updated_at: String
    let is_deleted: Bool
}

struct CartBrand: Codable {
    let id: Int
    let name: String
    let description: String
    let create_at: String
    let updated_at: String
    let is_deleted: Bool
}

struct CartSizeQuantity: Codable {
    let id: Int
    let quantity: Int
    let price: String
    let discount: String
    let product_id: Int?
    let custom_product_id: String
    let variant_id: String?
    let size_id: Int
    let create_at: String
    let updated_at: String
    let is_deleted: Bool
    let size_data: CartSizeData
}

struct CartSizeData: Codable {
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
    let size_chart_data: [CartSizeChartData]
}

struct CartSizeChartData: Codable {
    let id: Int
    let custom_size_id: String
    let size_field_name: String
    let size_field_value: String
    let size_data_id: Int?
}

