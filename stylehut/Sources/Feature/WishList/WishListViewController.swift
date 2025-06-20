//
//  WishListViewController.swift
//  stylehut
//
//  Created by MACM26 on 19/06/25.
//

import UIKit

class WishListViewController: UIViewController, UICollectionViewDelegate,UICollectionViewDataSource,UICollectionViewDelegateFlowLayout {
  
    @IBOutlet weak var wishListCollectionView: UICollectionView!
    var wishListViewModel = WishListViewModel()
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        NotificationCenter.default.addObserver(self,
               selector: #selector(handleLoginSuccess),
               name: Notification.Name("UserDidLoginOrRegister"),
               object: nil)
    }
    
    @objc func handleLoginSuccess() {
        configure()
    }

    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        if !AuthManager.shared.isUserLoggedIn() {
            DispatchQueue.main.async {
                self.performSegue(withIdentifier: k.navigationTitles.wishListToLogin, sender: self)
            }
        } else {
            DispatchQueue.main.async {
                self.configure()
            }
        }
    }

    
    func configure()  {
        DispatchQueue.main.async {
            self.wishListCollectionView.collectionViewLayout = UICollectionViewFlowLayout()
            self.wishListCollectionView.register(UINib(nibName: k.wishListScreen.wishListCollectionViewCellIdentifier, bundle: nil), forCellWithReuseIdentifier: k.wishListScreen.wishListCollectionViewCellIdentifier)
        }
            Task{
            await wishListViewModel.getWishList()
            DispatchQueue.main.async {
                self.wishListCollectionView.reloadData()
            }
        }
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        wishListViewModel.wishListData?.items.count ?? 0
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = wishListCollectionView.dequeueReusableCell(withReuseIdentifier: k.wishListScreen.wishListCollectionViewCellIdentifier, for: indexPath) as! WishListCollectionViewCell
        let wishListProduct = (wishListViewModel.wishListData?.items[indexPath.row])!
        cell.configure(wishListProduct: wishListProduct)
        cell.handleRemoveFromList = { [weak self] in
            guard let self = self else { return }
               print("Removed item with ID: \(wishListProduct.id)")
            Task{
                let response =  await NetworkManager.removeFromWishList(product_id: wishListProduct.products.id)
                if response {
                           DispatchQueue.main.async {
                               if let index = self.wishListViewModel.wishListData?.items.firstIndex(where: {
                                   $0.id == wishListProduct.id
                               }) {
                                   print("index",index)
                                   self.wishListViewModel.wishListData?.items.remove(at: index)
                                   self.wishListCollectionView.performBatchUpdates({
                                       self.wishListCollectionView.deleteItems(at: [IndexPath(row: index, section: 0)])
                                   }, completion: nil)
                               }
                           }
                }else{
                    print("Failed to remove from wishlist.")
                }
            }
           }
        return cell
    }

    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
            let padding: CGFloat = 10
            let itemsPerRow: CGFloat = 2
            let totalPadding = padding * (itemsPerRow + 1)
            let availableWidth = collectionView.frame.width - totalPadding
            let itemWidth = availableWidth / itemsPerRow
        return CGSize(width: itemWidth, height: itemWidth * 1.7)
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, insetForSectionAt section: Int) -> UIEdgeInsets {
            return UIEdgeInsets(top: 10, left: 10, bottom: 10, right: 10)
   
    }

}
