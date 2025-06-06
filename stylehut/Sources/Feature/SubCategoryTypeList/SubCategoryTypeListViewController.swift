//
//  SubCategoryTypeListViewController.swift
//  stylehut
//
//  Created by MACM26 on 04/06/25.
//

import UIKit
import Kingfisher

class SubCategoryTypeListViewController: UIViewController {

    @IBOutlet weak var productCollectionView: UICollectionView!
    let subCategoryTypeViewModel = SubCategoryTypeViewModel()
    var selectedCategoryId: Int?
    var selectedSubCategoryId: Int?
    var selectedSubCategoryTypeId: Int?
    var selectedProduct: Int = 0
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        configure()
        loadData()
    }
    
    func configure() {
        productCollectionView.delegate = self
        productCollectionView.dataSource = self
        productCollectionView.collectionViewLayout = UICollectionViewFlowLayout()
        productCollectionView.register(UINib(nibName: k.SubCategoryTypeScreen.subCategoryTypeListCollectionViewCell, bundle: nil), forCellWithReuseIdentifier: k.SubCategoryTypeScreen.subCategoryTypeListCollectionViewCell)
    }
    
    func loadData() {
        print("Here")
        Task{
            await subCategoryTypeViewModel.getProducts(selectedCategoryId: selectedCategoryId!,selectedSubCategoryId: selectedSubCategoryId!,selectedSubCategoryTypeId: selectedSubCategoryTypeId!, compelation: {
                DispatchQueue.main.async {
                    self.productCollectionView.reloadData()
                }
            })
        }
    }

    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == k.navigationTitles.navigateToProductDescription,
           let destinationVC = segue.destination as? ProductDescriptionViewController{
            
            destinationVC.productID = selectedProduct
        }
         
    }

}

extension SubCategoryTypeListViewController: UICollectionViewDelegate, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        subCategoryTypeViewModel.subCategoryTypeProductData.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let productData = subCategoryTypeViewModel.subCategoryTypeProductData[indexPath.row]
        
        let originalPrice = Double(productData.price) ?? 0.0
        let discountPercentage = Double(productData.discount ??  Int(0.0))
        let discountAmount = originalPrice * (discountPercentage / 100)
        let finalPrice = originalPrice - discountAmount
        
        let cell = productCollectionView.dequeueReusableCell(withReuseIdentifier: k.SubCategoryTypeScreen.subCategoryTypeListCollectionViewCell, for: indexPath) as! SubCategoryTypeListCollectionViewCell
        cell.productName.text = productData.name
        cell.originalPrice.text = productData.price
        cell.discountPrice.text =  String(format: "%.2f", finalPrice)
        cell.discount.text = "\(productData.discount ?? Int(0.0))% OFF"
        cell.brandName.text = productData.brand?.name
        if let imageUrl = URL(string: productData.image[0]) {
            cell.posterImage.kf.setImage(with: imageUrl)
        }
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        selectedProduct = subCategoryTypeViewModel.subCategoryTypeProductData[indexPath.row].id
        performSegue(withIdentifier: k.navigationTitles.navigateToProductDescription, sender: self)
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
            let padding: CGFloat = 10
            let itemsPerRow: CGFloat = 2
            let totalPadding = padding * (itemsPerRow + 1)
            let availableWidth = collectionView.frame.width - totalPadding
            let itemWidth = availableWidth / itemsPerRow
        return CGSize(width: itemWidth, height: itemWidth * 1.7)
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, insetForSectionAt section: Int) -> UIEdgeInsets {
     
            return UIEdgeInsets(top: 10, left: 10, bottom: 10, right: 10)
        
   
    }
    
}
