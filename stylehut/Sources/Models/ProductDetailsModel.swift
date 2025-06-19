//
//  ProductDetailsModel.swift
//  stylehut
//
//  Created by MACM26 on 06/06/25.
//

import Foundation

// MARK: - Main API Response
struct ProductDetailsAPIResponse: Codable {
    let message: String
    let data: ProductDetailsData
}

// MARK: - Product Data
struct ProductDetailsData: Codable {
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
    let category: ProductDetailsCategory
    let sub_category: ProductDetailsSubCategory
    let sub_category_type: ProductDetailsSubCategoryType
    let brand: ProductDetailsBrand
    let ratings: [ProductDetailsRating]
    let size_quantities: [ProductDetailsSizeQuantity]
    let ratingStats: ProductDetailsRatingStats
    let relatedProducts: [ProductDetailsRelatedProduct]
}

// MARK: - Category
struct ProductDetailsCategory: Codable {
    let id: Int
    let name: String
    let description: String
    let create_at: String
    let updated_at: String
    let is_deleted: Bool
}

// MARK: - Sub Category
struct ProductDetailsSubCategory: Codable {
    let id: Int
    let name: String
    let description: String
    let create_at: String
    let updated_at: String
    let is_deleted: Bool
    let category_id: Int
}

// MARK: - Sub Category Type
struct ProductDetailsSubCategoryType: Codable {
    let id: Int
    let name: String
    let description: String
    let category_id: Int
    let sub_category_id: Int
    let create_at: String
    let updated_at: String
    let is_deleted: Bool
}

// MARK: - Brand
struct ProductDetailsBrand: Codable {
    let id: Int
    let name: String
    let description: String
    let create_at: String
    let updated_at: String
    let is_deleted: Bool
}

// MARK: - Rating (Empty array in response, but structured for future use)
struct ProductDetailsRating: Codable {
    let id: Int?
    let rating: Int?
    let review: String?
    let user_id: Int?
    let product_id: String?
    let create_at: String?
    let updated_at: String?
}

// MARK: - Size Quantity
struct ProductDetailsSizeQuantity: Codable {
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
    let size_data: ProductDetailsSizeData
}

// MARK: - Size Data
struct ProductDetailsSizeData: Codable {
    let id: Int
    let size: String
    let name: String
    let has_size_chart: Bool
    let is_cm: Bool
    let type: String?
    let custom_size_id: String
    let create_at: String
    let updated_at: String
    let is_deleted: Bool
    let size_chart_data: [ProductDetailsSizeChartData]
}

// MARK: - Size Chart Data
struct ProductDetailsSizeChartData: Codable {
    let id: Int
    let custom_size_id: String
    let size_field_name: String
    let size_field_value: String
    let size_data_id: Int?
}

// MARK: - Rating Stats
struct ProductDetailsRatingStats: Codable {
    let averageRating: Int
    let totalRatings: Int
}

// MARK: - Related Product
struct ProductDetailsRelatedProduct: Codable {
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
    let size_quantities: [ProductDetailsSizeQuantity]
    let brand: ProductDetailsBrand
    let category: ProductDetailsCategory
    let sub_category: ProductDetailsSubCategory
    let sub_category_type: ProductDetailsSubCategoryType
}
