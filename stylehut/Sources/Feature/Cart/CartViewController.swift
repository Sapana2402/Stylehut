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
        LoaderView.shared.show()
        if !AuthManager.shared.isUserLoggedIn() {
            LoaderView.shared.hide()
            DispatchQueue.main.async {
                let alert = UIAlertController(title: "Login Required", message: "", preferredStyle: .alert)
                          self.present(alert, animated: true) {
                              alert.addAction(UIAlertAction(title: "OK", style: .default, handler: { _ in
                                  self.dismiss(animated: true, completion: nil)
                              }))
                          }
            }
        } else {
            DispatchQueue.main.async {
                self.configure()
            }
        }
    
    }

    func configure()  {
        self.navigationItem.hidesBackButton = false
        cartListTabelView.register(UINib(nibName: k.cartScreen.cartTableViewCell, bundle: nil), forCellReuseIdentifier: k.cartScreen.cartTableViewCell)
        cartListTabelView.isScrollEnabled = false

        Task {
            await cartViewModels.getCartList()
            DispatchQueue.main.async {
                self.cartListTabelView.reloadData()
                DispatchQueue.main.asyncAfter(deadline: .now() + 0.1) {
                    self.cartListTabelView.layoutIfNeeded()
                    self.cartHeight.constant = self.cartListTabelView.contentSize.height * 1.4
                    LoaderView.shared.hide()
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
