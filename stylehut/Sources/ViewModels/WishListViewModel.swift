//
//  WishListViewModel.swift
//  stylehut
//
//  Created by MACM26 on 19/06/25.
//

import Foundation



class WishListViewModel {
    var wishListData : wishlistData?

    func getWishList() async {
        let url = "\(k.urls.baseURL)/wishlist?page=1&pageSize=100"
        if let brandList = await NetworkManager.getWishListedProduct(urlString: url) {
            self.wishListData = brandList
            print("Wishlist data", brandList)
        } else {
            print("Failed to load product details")
            self.wishListData = nil
        }
    }
}
