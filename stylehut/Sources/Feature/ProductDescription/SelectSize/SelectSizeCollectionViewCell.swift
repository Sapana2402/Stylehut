//
//  SelectSizeCollectionViewCell.swift
//  stylehut
//
//  Created by MACM26 on 17/06/25.
//

import UIKit

class SelectSizeCollectionViewCell: UICollectionViewCell {
    
    @IBOutlet weak var circularView: UIView!
    @IBOutlet weak var label: UILabel!
    @IBOutlet weak var leftItem: UILabel!
    @IBOutlet weak var leftItemView: UIView!
    
    override func awakeFromNib() {
        super.awakeFromNib()
    }

    override func layoutSubviews() {
        super.layoutSubviews()
        circularView.layoutIfNeeded()

        circularView.layer.cornerRadius = circularView.frame.width / 2
        circularView.layer.borderColor = UIColor.gray.cgColor
        circularView.layer.borderWidth = 1.0
        circularView.clipsToBounds = true
    }
}
