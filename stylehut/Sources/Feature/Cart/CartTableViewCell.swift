//
//  CartTableViewCell.swift
//  stylehut
//
//  Created by MACM26 on 20/06/25.
//

import UIKit

class CartTableViewCell: UITableViewCell {

    @IBOutlet weak var cartImage: UIImageView!
    @IBOutlet weak var labelOne: UILabel!
    @IBOutlet weak var labelTwo: UILabel!
    @IBOutlet weak var discount: UILabel!
    @IBOutlet weak var withDiscountPrice: UILabel!
    @IBOutlet weak var withoutDiscountPrice: UILabel!
    @IBOutlet weak var qty: UIStackView!
    @IBOutlet weak var size: UIButton!
    
    
    override func awakeFromNib() {
        super.awakeFromNib()
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

    }
    
    func configData(productDetails: CartItem) {
        labelOne.text = productDetails.product.brand.name
        labelTwo.text = productDetails.product.name
        discount.text = "\(productDetails.product.discount)%OFF"
        withoutDiscountPrice.text = productDetails.product.price
        cartImage.kf.setImage(with: URL(string: productDetails.product.image[0])!)
//        size.titleLabel?.text = productDetails.product
    }
}
