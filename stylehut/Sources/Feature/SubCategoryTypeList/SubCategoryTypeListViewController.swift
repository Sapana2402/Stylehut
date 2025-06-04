//
//  SubCategoryTypeListViewController.swift
//  stylehut
//
//  Created by MACM26 on 04/06/25.
//

import UIKit

class SubCategoryTypeListViewController: UIViewController {

    @IBOutlet weak var productCollectionView: UICollectionView!
    let subCategoryTypeViewModel = SubCategoryTypeViewModel()
    override func viewDidLoad() {
        super.viewDidLoad()

        configure()
        loadData()
    }
    
    func configure() {
        productCollectionView.delegate = self
        productCollectionView.dataSource = self
        productCollectionView.register(UINib(nibName: k.SubCategoryTypeScreen.subCategoryTypeListCollectionViewCell, bundle: nil), forCellWithReuseIdentifier: k.SubCategoryTypeScreen.subCategoryTypeListCollectionViewCell)
    }
    
    func loadData() {
        print("Here")
        Task{
            await subCategoryTypeViewModel.getProducts {
                DispatchQueue.main.async {
                    self.productCollectionView.reloadData()
                }
            }
        }
    }
    
    

}

extension SubCategoryTypeListViewController: UICollectionViewDelegate, UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        subCategoryTypeViewModel.subCategoryTypeProductData.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = productCollectionView.dequeueReusableCell(withReuseIdentifier: k.SubCategoryTypeScreen.subCategoryTypeListCollectionViewCell, for: indexPath) as! SubCategoryTypeListCollectionViewCell
        cell.productName.text = subCategoryTypeViewModel.subCategoryTypeProductData[indexPath.row].name
        
        return cell
    }
    
    
}
