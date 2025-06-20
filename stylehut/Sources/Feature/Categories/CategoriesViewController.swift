//
//  CategoriesViewController.swift
//  stylehut
//
//  Created by MACM26 on 29/05/25.
//

import UIKit

class CategoriesViewController: UIViewController {
    
    @IBOutlet weak var sideCategoriesList: UITableView!
    @IBOutlet weak var posterImage: UIImageView!
    @IBOutlet weak var subCategoriesList: UICollectionView!
    var selectedIndex: Int?
    var subCategoreisTypeData : [SubCategory] = []
    
    let categorisViewModel = CategoriesViewModel()
    override func viewDidLoad() {
        super.viewDidLoad()
        LoaderView.shared.show()
        sideCategoriesList.dataSource = self
        sideCategoriesList.delegate = self
        subCategoriesList.delegate = self
        subCategoriesList.dataSource = self
        posterImage.transform = CGAffineTransform(scaleX: 0.5, y: 0.5)
        
        if let layout = subCategoriesList.collectionViewLayout as? UICollectionViewFlowLayout {
            layout.estimatedItemSize = .zero
        }
        
        Task{
            await categorisViewModel.getCategories {
                self.selectedIndex = 0
                self.subCategoreisTypeData = self.categorisViewModel.categoriesData[0].sub_categories

                DispatchQueue.main.async {
                    self.sideCategoriesList.reloadData()
                    self.subCategoriesList.reloadData()
                    self.updateCollectionViewBackground()
                    LoaderView.shared.hide()
                    UIView.animate(withDuration: 0.6,
                                   delay: 0,
                                   usingSpringWithDamping: 0.6,
                                   initialSpringVelocity: 0.5,
                                   options: [.curveEaseInOut],
                                   animations: {
                        self.posterImage.transform = CGAffineTransform.identity},completion: nil)
                }
                
            }
        }
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)

  
    }

    
    private func updateCollectionViewBackground() {
        if subCategoreisTypeData.isEmpty {
            let noDataLabel = UILabel()
            noDataLabel.text = k.noDataFound
            noDataLabel.textAlignment = .center
            noDataLabel.textColor = .lightGray
            noDataLabel.font = UIFont.systemFont(ofSize: 16)
            subCategoriesList.backgroundView = noDataLabel
        } else {
            subCategoriesList.backgroundView = nil
        }
    }

}

extension CategoriesViewController : UITableViewDataSource,UITableViewDelegate{
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        categorisViewModel.categoriesData.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = sideCategoriesList.dequeueReusableCell(withIdentifier: k.categoriesScreen.mainCategoryCellIdentifier, for: indexPath) as! CategoriesTableViewCell
        cell.categoriesName.text = categorisViewModel.categoriesData[indexPath.row].name
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let selectedCategory = categorisViewModel.categoriesData[indexPath.row]
          selectedIndex = indexPath.row
          subCategoreisTypeData = selectedCategory.sub_categories
          
          DispatchQueue.main.async {
              self.subCategoriesList.reloadData()
              self.updateCollectionViewBackground()
          }
    }
}


extension CategoriesViewController : UICollectionViewDataSource,UICollectionViewDelegate,UICollectionViewDelegateFlowLayout{
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        subCategoreisTypeData.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = subCategoriesList.dequeueReusableCell(withReuseIdentifier: k.categoriesScreen.subCategoriesCollectionViewCell, for: indexPath) as! CategoriesCollectionViewCell
        cell.subCategoriesName.text = subCategoreisTypeData.count > 0 ? subCategoreisTypeData[indexPath.row].name : ""
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        let numberOfColumns: CGFloat = 3
          let spacing: CGFloat = 8
          guard let layout = collectionViewLayout as? UICollectionViewFlowLayout else {
              return CGSize(width: 100, height: 200)
          }

          let totalSpacing = (numberOfColumns - 1) * spacing + layout.sectionInset.left + layout.sectionInset.right

          let itemWidth = (collectionView.bounds.width - totalSpacing) / numberOfColumns
          return CGSize(width: floor(itemWidth), height: floor(itemWidth))
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumLineSpacingForSectionAt section: Int) -> CGFloat {
        return 0
    }

    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumInteritemSpacingForSectionAt section: Int) -> CGFloat {
        return 0
    }

    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, insetForSectionAt section: Int) -> UIEdgeInsets {
        return UIEdgeInsets(top: 8, left: 8, bottom: 8, right: 8)
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        performSegue(withIdentifier: k.categoriesScreen.subCategoriesType, sender: self)
    }
    
//    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
//        if segue.identifier == k.categoriesScreen.subCategoriesType,
//           let indexPath = subCategoriesList.indexPathsForSelectedItems?.first,
//           let destinationVC = segue.destination as? SubCategoryViewController {
//            let selectedSubCategory = subCategoreisTypeData[indexPath.row]
////            destinationVC.subCategoryTypeData = selectedSubCategory.sub_category_types
//            let selectedIndex = selectedIndex {
//
//             let selectedCategory = categorisViewModel.categoriesData[selectedIndex]
//             let selectedSubCategory = subCategoreisTypeData[indexPath.row]
//
//             destinationVC.selectedCategoryId = selectedCategory.id
//             destinationVC.selectedSubCategoryId = selectedSubCategory.id
//             destinationVC.subCategoryTypeData = selectedSubCategory.sub_category_types
//         }
//        }
//    }
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == k.categoriesScreen.subCategoriesType,
           let indexPath = subCategoriesList.indexPathsForSelectedItems?.first,
           let destinationVC = segue.destination as? SubCategoryViewController,
           let selectedIndex = selectedIndex { // ✅ Safe unwrapping of optional

            let selectedCategory = categorisViewModel.categoriesData[selectedIndex]
            let selectedSubCategory = subCategoreisTypeData[indexPath.row]

            destinationVC.selectedCategoryId = selectedCategory.id
            destinationVC.selectedSubCategoryId = selectedSubCategory.id
            destinationVC.subCategoryTypeData = selectedSubCategory.sub_category_types
        }
    }


}



