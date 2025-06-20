//
//  WishListCollectionViewCell.swift
//  stylehut
//
//  Created by MACM26 on 19/06/25.
//

import UIKit

class WishListCollectionViewCell: UICollectionViewCell {
    
    @IBOutlet weak var mainView: UIView!
    @IBOutlet weak var image: UIImageView!
    @IBOutlet weak var productName: UILabel!
    @IBOutlet weak var withoutDiscountPrice: UILabel!
    @IBOutlet weak var discount: UILabel!
    @IBOutlet weak var withDiscountPrice: UILabel!
    var handleRemoveFromList: (() -> Void)?
    
    override func awakeFromNib() {
        super.awakeFromNib()
        mainView.layer.borderWidth = 1
        mainView.layer.borderColor = UIColor.lightGray.cgColor
    }

    func configure(wishListProduct:wishlistItem) {
        if let imageUrl = URL(string: wishListProduct.products.image.first ?? "") {
            image.kf.setImage(with: imageUrl)
        }
        productName.text = wishListProduct.products.name
        discount.text = String(wishListProduct.products.discount) + "%"
        
    }
    @IBAction func handleAddToBag(_ sender: UIButton) {
    }
    
    @IBAction func handleRemoveFromWishList(_ sender: Any) {
        handleRemoveFromList?()
    }
    
}
