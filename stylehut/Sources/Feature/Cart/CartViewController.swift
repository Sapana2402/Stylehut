//
//  CartViewController.swift
//  stylehut
//
//  Created by MACM26 on 20/06/25.
//

import UIKit

class CartViewController: UIViewController, UITableViewDelegate,UITableViewDataSource {
    @IBOutlet weak var cartListTabelView: UITableView!
    let cartViewModels = CartViewModels()
    
    @IBOutlet weak var cartHeight: NSLayoutConstraint!
    override func viewDidLoad() {
        super.viewDidLoad()
        cartListTabelView.register(UINib(nibName: k.cartScreen.cartTableViewCell, bundle: nil), forCellReuseIdentifier: k.cartScreen.cartTableViewCell)
        cartListTabelView.isScrollEnabled = false

        Task {
            await cartViewModels.getCartList()
            DispatchQueue.main.async {
                self.cartListTabelView.reloadData()
                DispatchQueue.main.asyncAfter(deadline: .now() + 0.1) {
                    self.cartListTabelView.layoutIfNeeded()
                    self.cartHeight.constant = self.cartListTabelView.contentSize.height 
                }
            }
        }
    }

    
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        cartViewModels.cartDetails?.items.count ?? 0
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = cartListTabelView.dequeueReusableCell(withIdentifier: k.cartScreen.cartTableViewCell, for: indexPath) as! CartTableViewCell
        let cartList = cartViewModels.cartDetails?.items[indexPath.row]
        cell.configData(productDetails: cartList!)
        return cell
    }

    

}
