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
    static let autoSliderCollectionViewCell = "AutoSliderCollectionViewCell"
    
    struct urls {
        static let baseURL = "https://stylehut-be.vercel.app/api"
               
               static let privacyPolicyUrl = "https://www.myntra.com/privacypolicy"
               static let register = "\(baseURL)/register"
               static let verifyOTP = "\(baseURL)/verify-otp"
               static let getCategories = "\(baseURL)/category-data"
    }
    
    struct assets {
        struct giftCard {
            static let cashBack = "https://stylehut.vercel.app/assets/Payments-D-xdL-BY.gif"
        }
        
        struct images {
            static let fieldscouponsTextImage = "https://stylehut.vercel.app/assets/coupons-Dxg4FCVa.png"
            static let couponsCodeOne = "https://stylehut.vercel.app/assets/coupon1-zFkVzmcC.png"
            static let couponsCodeSecond = "https://stylehut.vercel.app/assets/coupon2-CyXmHw-q.png"
            static let shopByCategoryImage = "https://stylehut.vercel.app/assets/shoup_by_category-CuvjA852.png"
        }
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
    
    
    struct SliderItem {
        let imageURL: String
    }

    
    struct homeScreen {
        static let autoSliderData: [SliderItem] = [
            SliderItem(imageURL: "https://stylehut.vercel.app/assets/slide1-BHQmvDFI.png"),
            SliderItem(imageURL: "https://stylehut.vercel.app/assets/slide2-TfW4P2cN.png"),
            SliderItem(imageURL: "https://stylehut.vercel.app/assets/slide3-_sHO2rVu.png"),
            SliderItem(imageURL: "https://stylehut.vercel.app/assets/slide4-go2o8uj4.png"),
            SliderItem(imageURL: "https://stylehut.vercel.app/assets/slide5-CmP-icBn.png")
        ]
    }
    
    struct SubCategoryTypeScreen {
        static let subCategoryTypeListCollectionViewCell = "SubCategoryTypeListCollectionViewCell"
    }

}
