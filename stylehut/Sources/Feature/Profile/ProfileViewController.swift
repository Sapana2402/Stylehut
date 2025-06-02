//
//  ProfileViewController.swift
//  stylehut
//
//  Created by MACM26 on 27/05/25.
//

import UIKit

class ProfileViewController: UIViewController {

    
    @IBOutlet weak var registerBtn: UIButton!
    @IBOutlet weak var logOut: UIButton!
    
    @IBOutlet weak var loginView: UIStackView!
    override func viewDidLoad() {
        super.viewDidLoad()

        registerBtn.layer.borderWidth = 1
           registerBtn.layer.borderColor = UIColor(red: 0xDE/255, green: 0xDE/255, blue: 0xDF/255, alpha: 1).cgColor
        registerBtn.layer.cornerRadius = 10
        NotificationCenter.default.addObserver(self, selector: #selector(handleBtnNotification), name: Notification.Name("UserDidLoginOrRegister"), object: nil)
    }
    
    @objc func handleBtnNotification() {
        handleBtn()
    }

    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
           print("Token in viewWillAppear: \(String(describing: AuthManager.shared.token))")
        handleBtn()
    }

    @IBAction func hyandleRegisterUser(_ sender: UIButton) {
    }
    
    
    @IBAction func handleLogOut(_ sender: UIButton) {
        AuthManager.shared.token = nil
        UserDefaults.standard.removeObject(forKey: "userToken")
        UserDefaults.standard.synchronize()
        handleBtn()
    }
    
    func handleBtn() {
        let isLoggedIn = AuthManager.shared.token != nil
        loginView.isHidden = isLoggedIn
        logOut.isHidden = !isLoggedIn

    }
    
}
