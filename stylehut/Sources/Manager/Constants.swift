//
//  Constants.swift
//  stylehut
//
//  Created by MACM26 on 22/05/25.
//

import Foundation

struct k {
    static let allProductCellIdentifier = "ProductListCollectionViewCell"
    static let noDataFound = "No data found"
    
    struct urls {
        static let privacyPolicyUrl = "https://www.myntra.com/privacypolicy"
        static let register = "https://stylehut-be.vercel.app/api/register"
        static let verifyOTP = "https://stylehut-be.vercel.app/api/verify-otp"
        static let getCategories = "https://stylehut-be.vercel.app/api/category-data"
    }
    
    struct httpMethods {
        static let get = "GET"
        static let post = "POST"
    }
    
    struct validationMessages {
        static let emailRequired = "Please enter email"
        static let emailInvalid = "Please enter valid email"
        static let tryAgain = "Please try again"
    }
    
    struct navigationTitles {
        static let navigateToOTP = "navigateToOTP"
        static let otpToHome = "otpToHome"
    }
    
    struct categoriesScreen {
        static let mainCategoryCellIdentifier = "CategoriesTableViewCell"
        static let subCategoriesCollectionViewCell = "CategoriesCollectionViewCell"
        static let subCategoriesType = "subCategoriesType"
    }
    
    struct subCategoryScreen {
        static let subCategoryTableViewCell = "SubCategoryTableViewCell"
    }
    
    struct productDescriptionScreen {
        
    }
}
