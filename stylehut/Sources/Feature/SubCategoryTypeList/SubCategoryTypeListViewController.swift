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
        
        
        let cell = productCollectionView.dequeueReusableCell(withReuseIdentifier: k.SubCategoryTypeScreen.subCategoryTypeListCollectionViewCell, for: indexPath) as! SubCategoryTypeListCollectionViewCell
        cell.configure(with: productData)
        cell.wishlistToggleAction = { [weak self] in
            guard let self = self else { return }

            var product = self.subCategoryTypeViewModel.subCategoryTypeProductData[indexPath.row]
            let productID = product.id

            Task {
                let isAdded = await NetworkManager.wishListProduct(product_id: productID)
                if isAdded {
                    product.isInWishlist = !(product.isInWishlist ?? false)
                    self.subCategoryTypeViewModel.subCategoryTypeProductData[indexPath.row] = product

                    DispatchQueue.main.async {
                        collectionView.reloadItems(at: [indexPath])
                    }
                } else {
                    DispatchQueue.main.async {
                        self.present(AuthManager.shared.showAlert(title: "", message: "Failed to update wishlist."), animated: true, completion: nil)
                    }
                }
            }
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
