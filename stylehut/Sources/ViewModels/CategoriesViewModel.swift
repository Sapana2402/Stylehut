//
//  ProductViewModel.swift
//  stylehut
//
//  Created by MACM26 on 21/05/25.
//

import Foundation
import UIKit
import CoreData

class CategoriesViewModel {
    var categoriesData : [Category] = []
    let context = (UIApplication.shared.delegate as! AppDelegate).persistentContainer.viewContext
    
    func getCategories(compelation: @escaping () -> Void) async {
        let url = k.urls.getCategories
        await NetworkManager.getCategories(urlString: url) { product, error in
           if let categories = product {
               self.categoriesData = categories
               print("self.categoriesData",self.categoriesData)
               compelation()
            }
            
        }
    }
}
