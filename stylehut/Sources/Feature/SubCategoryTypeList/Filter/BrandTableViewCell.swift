//
//  BrandTableViewCell.swift
//  stylehut
//
//  Created by MACM26 on 13/06/25.
//

import UIKit

class BrandTableViewCell: UITableViewCell {

    @IBOutlet weak var brandName: UILabel!
    @IBOutlet weak var checkBox: UIButton!
    
    override func awakeFromNib() {
        super.awakeFromNib()
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

    }

}
