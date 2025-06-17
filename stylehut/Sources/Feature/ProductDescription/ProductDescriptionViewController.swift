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
    var productDetails:ProductDetailsData?
    
    @IBOutlet weak var moreColors: UICollectionView!
    @IBOutlet weak var productBrand: UILabel!
    @IBOutlet weak var productName: UILabel!
    @IBOutlet weak var productPrice: UILabel!
    @IBOutlet weak var productDiscountPrice: UILabel!
    @IBOutlet weak var discount: UILabel!
    @IBOutlet weak var productSize: UICollectionView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        loadData()
        configureCollection()
    }
    
    func loadData() {
        guard let id = productID else { return }
        
        Task {
            await productDetailsViewModel.getProducts(productId: id)
            productDetails = self.productDetailsViewModel.productData
            DispatchQueue.main.async {
                self.moreColors.reloadData()
                self.productSize.reloadData()
                self.productBrand.text = self.productDetails?.brand.name ?? "N/A"
                self.productName.text = self.productDetails?.name ?? "N/A"
                self.productPrice.text = self.productDetails?.price ?? "N/A"
                self.discount.text = (String(describing: self.productDetails?.discount))
            }
        }
    }

    func configureCollection() {
        moreColors.delegate = self
        moreColors.dataSource = self
        moreColors.collectionViewLayout = UICollectionViewFlowLayout()
        
        productSize.delegate = self
        productSize.dataSource = self
        productSize.collectionViewLayout = UICollectionViewFlowLayout()
    }
    
    @IBAction func handleSizeChart(_ sender: UIButton) {
    
    }
}

extension ProductDescriptionViewController: UICollectionViewDelegateFlowLayout, UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        if collectionView == moreColors{
            return productDetails?.relatedProducts.count ?? 0
        }else if collectionView == productSize{
            return productDetails?.size_quantities.count ?? 0
        }
        return 0
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        if collectionView == moreColors{
            let cell = moreColors.dequeueReusableCell(withReuseIdentifier: k.productDetails.moreColorsIndetiifer, for: indexPath) as! MoreColorsCollectionViewCell
            let moreProductData = productDetails?.relatedProducts[indexPath.row]
            cell.posterImage.kf.setImage(with: URL(string: moreProductData?.image[0] ?? ""))
            return cell
        }else if collectionView == productSize{
            let cell = productSize.dequeueReusableCell(withReuseIdentifier: k.productDetails.selectSizeIndetiifer, for: indexPath) as! SelectSizeCollectionViewCell
            return cell
        }
        return UICollectionViewCell()
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        if collectionView == moreColors{
            return CGSize(width: moreColors.frame.width/5, height: moreColors.frame.height)
        }else if collectionView == productSize{
            return CGSize(width: 100, height: 100)
        }
        return CGSize.zero
    
    }
}
