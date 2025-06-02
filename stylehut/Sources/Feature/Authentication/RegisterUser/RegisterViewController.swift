//
//  RegisterViewController.swift
//  stylehut
//
//  Created by MACM26 on 26/05/25.
//

import UIKit
import SafariServices

class RegisterViewController: UIViewController {
    let viewModel = RegisterViewModel()

    @IBOutlet weak var email: UITextField!
    @IBOutlet weak var activityIndicator: UIActivityIndicatorView!
    override func viewDidLoad() {
        super.viewDidLoad()
        hideLoader()
    }
    
    
    @IBAction func hanblePrivacyPolicy(_ sender: UIButton) {
        if let url = URL(string: k.urls.privacyPolicyUrl) {
              let safariVC = SFSafariViewController(url: url)
              present(safariVC, animated: true, completion: nil)
          }
    }
    
    @IBAction func handleRegisterUser(_ sender: UIButton) {
        if email.text!.isEmpty {
            self.showAlert(title: "", message: k.validationMessages.emailRequired)
            return
        }
        if !AuthManager.shared.isValidEmail(email.text!) {
            self.showAlert(title: "", message: k.validationMessages.emailInvalid)
            return
        }
        showLoader()
        Task {
            await viewModel.register(email: email.text!) { checkResponse in
                self.hideLoader()
                if checkResponse == true {
                    DispatchQueue.main.async {
                        self.performSegue(withIdentifier: k.navigationTitles.navigateToOTP, sender: self)
                    }
                }else{
                    self.showAlert(title: "", message: k.validationMessages.tryAgain)
                }
            }
        }
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == k.navigationTitles.navigateToOTP {
            if let destinationVC = segue.destination as? OTPVerificationViewController {
                destinationVC.email = self.email.text
            }
        }
    }
    
    func showAlert(title: String,message: String) {
        DispatchQueue.main.async {
            self.present(AuthManager.shared.showAlert(title: title, message: message), animated: true, completion: nil)
        }
    }
    
    func showLoader() {
        DispatchQueue.main.async {
            self.activityIndicator.startAnimating()
            self.view.isUserInteractionEnabled = false
            self.activityIndicator.isHidden = false
        }
    }

    func hideLoader() {
        DispatchQueue.main.async {
            self.activityIndicator.stopAnimating()
            self.activityIndicator.isHidden = true
            self.view.isUserInteractionEnabled = true
        }
    }

}
