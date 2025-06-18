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
    
    @IBOutlet weak var sizeCollectionviewHeight: NSLayoutConstraint!
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
                
                self.productSize.layoutIfNeeded()
                self.sizeCollectionviewHeight.constant = self.productSize.collectionViewLayout.collectionViewContentSize.height
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
        let sizeLayout = UICollectionViewFlowLayout()
           sizeLayout.scrollDirection = .horizontal // <--- Important!
           productSize.collectionViewLayout = sizeLayout
        
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
            let sizeInfo = productDetails?.size_quantities[indexPath.row]
            cell.label.text = sizeInfo?.size_data.size
            if let quantity = sizeInfo?.quantity, quantity > 0 && quantity < 4 {
                cell.leftItemView.isHidden = false
                cell.leftItem.text = "\(quantity) left"
            } else {
                cell.leftItemView.isHidden = true
            }
            return cell
        }
        return UICollectionViewCell()
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        if collectionView == moreColors{
            return CGSize(width: moreColors.frame.width/5, height: moreColors.frame.height)
        }else if collectionView == productSize{
            return CGSize(width: 50, height: 50)

        }
        return CGSize.zero
    
    }
}
