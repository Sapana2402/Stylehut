//
//  SelectSizeCollectionViewCell.swift
//  stylehut
//
//  Created by MACM26 on 17/06/25.
//

import UIKit

class SelectSizeCollectionViewCell: UICollectionViewCell {
    
    @IBOutlet weak var circularView: UIView!
    
    override func layoutSubviews() {
        super.layoutSubviews()
        
        circularView.layer.cornerRadius = circularView.frame.size.width / 2
        circularView.layer.borderColor = UIColor.gray.cgColor
        circularView.layer.borderWidth = 1.0
        circularView.clipsToBounds = true
    }
}
