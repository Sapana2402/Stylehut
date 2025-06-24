//
//  CartViewModels.swift
//  stylehut
//
//  Created by MACM26 on 20/06/25.
//

import Foundation

class CartViewModels {
    var cartDetails:CartData?
    
    func getCartList() async {
        let url = "\(k.urls.baseURL)/cart/user?page=1&pageSize=100"
        
        if let handleResponse = await NetworkManager.getCartProduct(urlString: url){
            cartDetails = handleResponse
        }else{
            cartDetails = nil
        }
    }
}
