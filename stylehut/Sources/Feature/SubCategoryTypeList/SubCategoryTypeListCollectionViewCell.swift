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
    
    override func awakeFromNib() {
        super.awakeFromNib()
        posterImage.layer.cornerRadius = 10
        posterImage.layer.maskedCorners = [.layerMinXMinYCorner, .layerMaxXMinYCorner]
        posterImage.clipsToBounds = true
        
    }

}
