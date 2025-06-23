//
//  ProductListCollectionViewCell.swift
//  stylehut
//
//  Created by MACM26 on 22/05/25.
//

import UIKit
import Kingfisher

class ProductListCollectionViewCell: UICollectionViewCell {

    @IBOutlet weak var productImage: UIImageView!
    @IBOutlet weak var category: UILabel!
    @IBOutlet weak var productPrice: UILabel!
    @IBOutlet weak var productName: UILabel!
    @IBOutlet weak var mainView: UIView!
    @IBOutlet weak var wishList: UIButton!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
        setUpUI()
    }
    
    func setUpUI() {
        wishList.isHidden = true
        mainView.layer.cornerRadius = 12
        mainView.layer.masksToBounds = false
        
        productImage.layer.cornerRadius = 12
        productImage.layer.maskedCorners = [.layerMinXMinYCorner, .layerMaxXMinYCorner]
        productImage.clipsToBounds = true
        
        
    }
    func setProductDetails(model: Product) {
        print("MOdel===",model)
        let url = URL(string: model.image[0])
        productName.text = model.name
        productImage.kf.setImage(with: url)
        category.text = model.category.name
        productPrice.text = model.price
    }

}
