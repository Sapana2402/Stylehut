//
//  SubCategoryTypeListCollectionViewCell.swift
//  stylehut
//
//  Created by MACM26 on 04/06/25.
//

import UIKit

class SubCategoryTypeListCollectionViewCell: UICollectionViewCell {

    
    @IBOutlet weak var posterImage: UIImageView!
    @IBOutlet weak var brandName: UILabel!
    @IBOutlet weak var discount: UILabel!
    @IBOutlet weak var discountPrice: UILabel!
    @IBOutlet weak var originalPrice: UILabel!
    @IBOutlet weak var productName: UILabel!
    @IBOutlet weak var wishListButton: UIButton!
    var wishlistToggleAction: (() -> Void)?
    override func awakeFromNib() {
        super.awakeFromNib()
        posterImage.layer.cornerRadius = 10
        posterImage.layer.maskedCorners = [.layerMinXMinYCorner, .layerMaxXMinYCorner]
        posterImage.clipsToBounds = true
        
    }
    
    func configure(with productData: SubCategoryTypeProduct) {
           productName.text = productData.name
           originalPrice.text = productData.price

           let originalPriceValue = Double(productData.price) ?? 0.0
           let discountPercentage = Double(productData.discount ?? 0)
           let discountAmount = originalPriceValue * (discountPercentage / 100)
           let finalPrice = originalPriceValue - discountAmount

           discountPrice.text = String(format: "%.2f", finalPrice)
           discount.text = "\(productData.discount ?? 0)% OFF"
           brandName.text = productData.brand?.name

           let wishListCount = productData.isInWishlist
           wishListButton.tintColor = wishListCount! ? .red : .white

           if let imageUrl = URL(string: productData.image.first ?? "") {
               posterImage.kf.setImage(with: imageUrl)
           }
       }


    @IBAction func handleWishList(_ sender: Any) {
        wishlistToggleAction?()
    }
}
