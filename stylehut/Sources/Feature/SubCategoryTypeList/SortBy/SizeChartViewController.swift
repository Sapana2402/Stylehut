//
//  SizeChartViewController.swift
//  stylehut
//
//  Created by MACM26 on 12/06/25.
//

import UIKit

class SizeChartViewController: UIViewController, UITableViewDataSource, UITableViewDelegate {

    @IBOutlet weak var sortByList: UITableView!
    override func viewDidLoad() {
        super.viewDidLoad()
        sortByList.dataSource = self
        sortByList.delegate = self
//        sortByList.isHidden = true
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        k.SubCategoryTypeScreen.sortOptions.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = sortByList.dequeueReusableCell(withIdentifier: k.SubCategoryTypeScreen.sortByCellIdentifier, for: indexPath) as! SortByCell
        cell.sortByTitle.text = k.SubCategoryTypeScreen.sortOptions[indexPath.row].title
        return cell
    }


}
