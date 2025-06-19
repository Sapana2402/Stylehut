//
//  ProductDescriptionViewController.swift
//  stylehut
//
//  Created by MACM26 on 03/06/25.
//

import UIKit

class ProductDescriptionViewController: UIViewController {
    var productID: Int?
    var sizeQuantityId: Int?
    let productDetailsViewModel = ProductDetailsViewModel()
    let test = SubCategoryTypeListViewController()
    var productDetails:ProductDetailsData?
    
    var selectedCategoryId: Int?
    var selectedSubCategoryId: Int?
    var selectedSubCategoryTypeId: Int?
    
    @IBOutlet weak var selectSizeView: UIStackView!
    @IBOutlet weak var moreColorView: UIStackView!
    @IBOutlet weak var moreColors: UICollectionView!
    @IBOutlet weak var productBrand: UILabel!
    @IBOutlet weak var productName: UILabel!
    @IBOutlet weak var productPrice: UILabel!
    @IBOutlet weak var productDiscountPrice: UILabel!
    @IBOutlet weak var discount: UILabel!
    @IBOutlet weak var productSize: UICollectionView!
    @IBOutlet weak var productDescription: UILabel!
    @IBOutlet weak var addToCartLabel: UIButton!
    
    @IBOutlet weak var sizeCollectionviewHeight: NSLayoutConstraint!
    @IBOutlet weak var similarProducts: UICollectionView!
    @IBOutlet weak var similarProductsHeight: NSLayoutConstraint!
    @IBOutlet weak var productImageSlider: UICollectionView!
    
    let subCategoryTypeViewModel = SubCategoryTypeViewModel()
    
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
                self.productImageSlider.reloadData()
                self.productBrand.text = self.productDetails?.brand.name ?? "N/A"
                self.productName.text = self.productDetails?.name ?? "N/A"
                self.productPrice.text = self.productDetails?.price ?? "N/A"
                self.productDescription.text = self.productDetails?.description ?? "N/A"
                self.discount.text = (String(describing: self.productDetails?.discount))
                
                self.productSize.layoutIfNeeded()
                self.sizeCollectionviewHeight.constant = self.productSize.collectionViewLayout.collectionViewContentSize.height

                self.moreColorView.isHidden = self.productDetails?.relatedProducts.isEmpty ?? true

                self.selectSizeView.isHidden = self.productDetails?.size_quantities.isEmpty ?? true
                
                
            }
            await subCategoryTypeViewModel.getProducts(selectedCategoryId: selectedCategoryId!,selectedSubCategoryId: selectedSubCategoryId!,selectedSubCategoryTypeId: selectedSubCategoryTypeId!, compelation: {
              
                DispatchQueue.main.async {
                    print("subCategoryTypeViewModel.subCategoryTypeProductData.",self.subCategoryTypeViewModel.subCategoryTypeProductData)
                    self.similarProducts.reloadData()
                    self.similarProducts.layoutIfNeeded()
                    self.similarProductsHeight.constant = self.similarProducts.collectionViewLayout.collectionViewContentSize.height
                }
            })
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
           sizeLayout.scrollDirection = .horizontal
           productSize.collectionViewLayout = sizeLayout
        
        //Similar product
        similarProducts.delegate = self
        similarProducts.dataSource = self
        similarProducts.collectionViewLayout = UICollectionViewFlowLayout()
        similarProducts.register(UINib(nibName: k.SubCategoryTypeScreen.subCategoryTypeListCollectionViewCell, bundle: nil), forCellWithReuseIdentifier: k.SubCategoryTypeScreen.subCategoryTypeListCollectionViewCell)
        
        //Image slider
        productImageSlider.delegate = self
        productImageSlider.dataSource = self
        productImageSlider.collectionViewLayout = UICollectionViewFlowLayout()
        let sizeLayout1 = UICollectionViewFlowLayout()
        sizeLayout1.scrollDirection = .horizontal
        productImageSlider.collectionViewLayout = sizeLayout1
        productImageSlider.showsHorizontalScrollIndicator = false
    }
    
    @IBAction func handleSizeChart(_ sender: UIButton) {
    
    }
    
    
    @IBAction func handleAddToCart(_ sender: UIButton) {
        if !AuthManager.shared.isUserLoggedIn() {
            let alert = AuthManager.shared.showAlert(title: "", message: "Login required to add to cart.")
            self.present(alert, animated: true)
            return
        }
        
        if productDetails?.size_quantities.count != 0 ,sizeQuantityId == nil {
            let alert = AuthManager.shared.showAlert(title: "", message: "Select size")
            self.present(alert, animated: true)
            return
        }
        Task{
            let addToCart = await NetworkManager.addToCart(product_id: productID!, size_quantity_id: sizeQuantityId ?? 0)
            if addToCart {
                addToCartLabel.titleLabel?.text = "AddedToBart"
                print("Added")
            }else{
                let alert = AuthManager.shared.showAlert(title: "", message: "Failed to update cart.")
                self.present(alert, animated: true)
            }
        }
            
       

    }
    
    var filteredSimilarProducts: [SubCategoryTypeProduct] {
        return subCategoryTypeViewModel.subCategoryTypeProductData.filter {
            $0.id != self.productID
        }
    }

}

extension ProductDescriptionViewController: UICollectionViewDelegateFlowLayout, UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        if collectionView == moreColors{
            return productDetails?.relatedProducts.count ?? 0
        }else if collectionView == productSize{
            return productDetails?.size_quantities.count ?? 0
        }else if collectionView == similarProducts{
            return filteredSimilarProducts.count
        }else if collectionView == productImageSlider{
            return productDetails?.image.count ?? 0
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
        }else if collectionView == similarProducts{
            let productData = filteredSimilarProducts[indexPath.row]
            let cell = similarProducts.dequeueReusableCell(withReuseIdentifier: k.SubCategoryTypeScreen.subCategoryTypeListCollectionViewCell, for: indexPath) as! SubCategoryTypeListCollectionViewCell
               cell.configure(with: productData)
               cell.wishListButton.isHidden = true
            return cell
        } else if collectionView == productImageSlider{
            let cell = productImageSlider.dequeueReusableCell(withReuseIdentifier: k.productDetails.imageIndetiifer, for: indexPath) as! ImageIndetiiferCollectionViewCell
            
            cell.sliderImage.kf.setImage(with: URL(string: productDetails?.image[indexPath.row] ?? ""))
            return cell
        }
        return UICollectionViewCell()
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        if collectionView == moreColors{
            return CGSize(width: moreColors.frame.width/5, height: moreColors.frame.height)
        }else if collectionView == productSize{
            return CGSize(width: 50, height: 50)
        }else if collectionView == similarProducts{
            let padding: CGFloat = 10
            let itemsPerRow: CGFloat = 2
            let totalPadding = padding * (itemsPerRow + 1)
            let availableWidth = collectionView.frame.width - totalPadding
            let itemWidth = availableWidth / itemsPerRow
        return CGSize(width: itemWidth, height: itemWidth * 1.7)
        }else if collectionView == productImageSlider{
            return CGSize(width: productImageSlider.frame.width-36, height: productImageSlider.frame.height)
        }
        return CGSize.zero
    
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, insetForSectionAt section: Int) -> UIEdgeInsets {
        if collectionView == similarProducts{
            return UIEdgeInsets(top: 10, left: 0, bottom: 10, right: 10)
        }
        return UIEdgeInsets(top: 0, left: 0, bottom: 0, right: 0)
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        print("dataa====",productDetails?.size_quantities[indexPath.row].id ?? 0)
        if collectionView == productSize{
            sizeQuantityId = productDetails?.size_quantities[indexPath.row].id
        }
    }
}

