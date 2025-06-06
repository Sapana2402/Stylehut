//
//  SubCategoryViewController.swift
//  stylehut
//
//  Created by MACM26 on 30/05/25.
//

import UIKit

class SubCategoryViewController: UIViewController, UITableViewDataSource, UITableViewDelegate {
    
    @IBOutlet weak var subCategoryTypeList: UITableView!
    var subCategoryTypeData: [SubCategoryType] = []
    var selectedCategoryId: Int?
    var selectedSubCategoryId: Int?

    override func viewDidLoad() {
        super.viewDidLoad()
        subCategoryTypeList.dataSource = self
        subCategoryTypeList.delegate = self
        subCategoryTypeList.reloadData()
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        subCategoryTypeData.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = subCategoryTypeList.dequeueReusableCell(withIdentifier: k.subCategoryScreen.subCategoryTableViewCell, for: indexPath) as! SubCategoryTableViewCell
        cell.SubCategoryTypeName.text = subCategoryTypeData[indexPath.row].name
        return cell
    }

    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        performSegue(withIdentifier: k.navigationTitles.navigateToSubCategoriesTypeList, sender: self)
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == k.navigationTitles.navigateToSubCategoriesTypeList {
            if let destination = segue.destination as? SubCategoryTypeListViewController,
               let indexPath = subCategoryTypeList.indexPathForSelectedRow {
                
                destination.selectedCategoryId = self.selectedCategoryId
                destination.selectedSubCategoryId = self.selectedSubCategoryId
                destination.selectedSubCategoryTypeId = self.subCategoryTypeData[indexPath.row].id
            }
        }
    }

}
