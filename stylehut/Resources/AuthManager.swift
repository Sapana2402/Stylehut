//
//  AuthManager.swift
//  stylehut
//
//  Created by MACM26 on 26/05/25.
//

import Foundation
import UIKit

class AuthManager{
    static let shared = AuthManager()
    
    //Nobody is allowed to create a new instance of this class outside of this file if I added below line
    private init(){
        token = UserDefaults.standard.string(forKey: "userToken")
    }
    
    var token: String?
    
    func isValidEmail(_ email: String) -> Bool {
        let emailRegEx = "[A-Z0-9a-z._%+-]+@[A-Za-z0-9.-]+\\.[A-Za-z]{2,}"
        let emailPredicate = NSPredicate(format:"SELF MATCHES %@", emailRegEx)
        return emailPredicate.evaluate(with: email)
    }
    
    func showAlert(title: String, message: String) -> UIAlertController {
        let alert = UIAlertController(title: title, message: message, preferredStyle: .alert)
        alert.addAction(UIAlertAction(title: "OK", style: .default))
        return alert
    }
    
    func isUserLoggedIn() -> Bool {
        return token != nil
    }



}
