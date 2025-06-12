//
//  ProductDescriptionViewController.swift
//  stylehut
//
//  Created by MACM26 on 03/06/25.
//

import UIKit

class ProductDescriptionViewController: UIViewController {
    
    var productID: Int?
    let productDetailsViewModel = ProductDetailsViewModel()

    
    @IBOutlet weak var productBrand: UILabel!
    @IBOutlet weak var productName: UILabel!
    @IBOutlet weak var productPrice: UILabel!
    @IBOutlet weak var productDiscountPrice: UILabel!
    @IBOutlet weak var discount: UILabel!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        loadData()
       
    }
    
    func loadData() {
        guard let id = productID else { return }
        
        Task {
            await productDetailsViewModel.getProducts(productId: id)
            DispatchQueue.main.async {
                self.productBrand.text = self.productDetailsViewModel.productData?.brand.name ?? "N/A"
                self.productName.text = self.productDetailsViewModel.productData?.name ?? "N/A"
                self.productPrice.text = self.productDetailsViewModel.productData?.price ?? "N/A"
                self.discount.text = (String(describing: self.productDetailsViewModel.productData?.discount))
            }
        }
    }

    
    @IBAction func handleSizeChart(_ sender: UIButton) {
    
    }
}
