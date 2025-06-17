//
//  FilterViewController.swift
//  stylehut
//
//  Created by MACM26 on 13/06/25.
//

import UIKit

class FilterViewController: UIViewController, UITableViewDelegate, UITableViewDataSource {
    let subCategoryTypeViewModel = SubCategoryTypeViewModel()
    @IBOutlet weak var brandTableViewHeightConstraint: NSLayoutConstraint!
    var onDismiss: ((ProductFilter) -> Void)?
    var selectedBrandId: Int?
    var currentFilter: ProductFilter?
    @IBOutlet weak var discountValue: UILabel!
    @IBOutlet weak var brandTableView: UITableView!

    @IBAction func handleDiscountchanges(_ sender: UISlider) {
        discountValue.text = "\(Int(sender.value))%"
    }
    
    @IBAction func handlePrice(_ sender: UISlider) {
        price.text = "\(Int(sender.value))"
    }
    @IBOutlet weak var discount: UISlider!
    @IBOutlet weak var handleMaxPrice: UISlider!
    @IBOutlet weak var price: UILabel!
    @IBAction func maxPrice(_ sender: Any) {
        
    }
    override func viewDidLoad() {
        super.viewDidLoad()
        brandTableView.delegate = self
        brandTableView.dataSource = self
        if let filter = currentFilter {
                 selectedBrandId = filter.selectedBrandId
                 discount.setValue(Float(filter.maxDiscount), animated: false)
                 handleMaxPrice.setValue(Float(filter.maxPrice), animated: false)
                 discountValue.text = "\(filter.maxDiscount)%"
             }
        
        Task{
            await subCategoryTypeViewModel.getBrandsData()
            DispatchQueue.main.async {
                self.brandTableView.reloadData()
                self.brandTableView.layoutIfNeeded()
                self.brandTableViewHeightConstraint.constant = self.brandTableView.contentSize.height
            }
        }
        
    }
    
    func manageProduct() {
        let filter = ProductFilter(
             selectedBrandId: selectedBrandId ?? 0,
             minPrice: 0,
             maxPrice: Int(handleMaxPrice.value),
             minDiscount: 0,
             maxDiscount: Int(discount.value)
         )
         onDismiss?(filter)
        self.dismiss(animated: true, completion: nil)
    }
    
    @IBAction func handleReset(_ sender: Any) {
         selectedBrandId = nil
         discount.setValue(100, animated: true)
         handleMaxPrice.setValue(100000, animated: true)
         discountValue.text = "100%"
         price.text = "100,000"
         manageProduct()
    }
    @IBAction func handleApply(_ sender: Any) {
        manageProduct()
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        subCategoryTypeViewModel.brandsData?.items.count ?? 0
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = brandTableView.dequeueReusableCell(withIdentifier: k.SubCategoryTypeScreen.brandTableViewCell, for: indexPath) as! BrandTableViewCell
        cell.brandName.text = subCategoryTypeViewModel.brandsData?.items[indexPath.row].name ?? ""
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let selectedBrand = subCategoryTypeViewModel.brandsData?.items[indexPath.row]
        selectedBrandId = selectedBrand?.id
    }

}
