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

}
