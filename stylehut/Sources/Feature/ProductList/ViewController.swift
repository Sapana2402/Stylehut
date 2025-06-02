//
//  ViewController.swift
//  stylehut
//
//  Created by MACM26 on 21/05/25.
//

import UIKit

class ViewController: UIViewController {

    @IBOutlet weak var trendingProductCollectionView: UICollectionView!
    let product = ProductViewNodel()
    override func viewDidLoad() {
        super.viewDidLoad()
        configure()
        loadData()
      
    }

    @IBAction func handleclick(_ sender: UIButton) {
        
    }
    
    func configure() {
        trendingProductCollectionView.delegate = self
        trendingProductCollectionView.dataSource = self
        trendingProductCollectionView.collectionViewLayout = UICollectionViewFlowLayout()
        trendingProductCollectionView.register(UINib(nibName: k.allProductCellIdentifier, bundle: nil), forCellWithReuseIdentifier: k.allProductCellIdentifier)
    }
    
    func loadData() {
            Task{
                await self.product.getProducts {
                    DispatchQueue.main.async {
                                  self.trendingProductCollectionView.reloadData()
                              }

                }
            }
      
    }
}

extension ViewController : UICollectionViewDelegate, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        product.productsData.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = trendingProductCollectionView.dequeueReusableCell(withReuseIdentifier: k.allProductCellIdentifier, for: indexPath) as! ProductListCollectionViewCell
        cell.setProductDetails(model: product.productsData[indexPath.row])
        return cell
    }
    
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        let padding: CGFloat = 10
        let itemsPerRow: CGFloat = 2
        let totalPadding = padding * (itemsPerRow + 1)
        let availableWidth = trendingProductCollectionView.frame.width - totalPadding
        let itemWidth = availableWidth / itemsPerRow
        let size = trendingProductCollectionView.frame.width
        return CGSize(width: itemWidth, height: itemWidth * 1.5) // Adjust height as needed
    }

    
//    func collectionView(_ collectionView: UICollectionView,
//                        layout collectionViewLayout: UICollectionViewLayout,
//                        minimumLineSpacingForSectionAt section: Int) -> CGFloat {
//        return 5
//    }
//
//    func collectionView(_ collectionView: UICollectionView,
//                        layout collectionViewLayout: UICollectionViewLayout,
//                        minimumInteritemSpacingForSectionAt section: Int) -> CGFloat {
//        return 5
//    }

    func collectionView(_ collectionView: UICollectionView,
                        layout collectionViewLayout: UICollectionViewLayout,
                        insetForSectionAt section: Int) -> UIEdgeInsets {
        return UIEdgeInsets(top: 10, left: 10, bottom: 10, right: 10)
    }

    
}

