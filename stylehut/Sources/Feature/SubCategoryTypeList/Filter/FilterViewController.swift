//
//  FilterViewController.swift
//  stylehut
//
//  Created by MACM26 on 13/06/25.
//

import UIKit

class FilterViewController: UIViewController, UITableViewDelegate, UITableViewDataSource {

    @IBOutlet weak var brandTableViewHeightConstraint: NSLayoutConstraint!
    
    @IBOutlet weak var brandTableView: UITableView!
    
    let subCategoryTypeViewModel = SubCategoryTypeViewModel()
    override func viewDidLoad() {
        super.viewDidLoad()
        brandTableView.delegate = self
        brandTableView.dataSource = self
        Task{
            await subCategoryTypeViewModel.getBrandsData()
            DispatchQueue.main.async {
                self.brandTableView.reloadData()
                self.brandTableView.layoutIfNeeded()
                self.brandTableViewHeightConstraint.constant = self.brandTableView.contentSize.height
            }
        }
        
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        subCategoryTypeViewModel.brandsData?.items.count ?? 0
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = brandTableView.dequeueReusableCell(withIdentifier: k.SubCategoryTypeScreen.brandTableViewCell, for: indexPath) as! BrandTableViewCell
        cell.brandName.text = subCategoryTypeViewModel.brandsData?.items[indexPath.row].name ?? ""
        return cell
    }

}
