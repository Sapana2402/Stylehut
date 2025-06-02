//
//  OTPVerificationViewController.swift
//  stylehut
//
//  Created by MACM26 on 23/05/25.
//

import UIKit

class OTPVerificationViewController: UIViewController,UITextFieldDelegate {

    @IBOutlet weak var otpFieldOne: UITextField!
    @IBOutlet weak var otpFieldTwo: UITextField!
    @IBOutlet weak var otpFieldThree: UITextField!
    @IBOutlet weak var otpFieldFour: UITextField!
    var email: String?
    let viewModel = RegisterViewModel()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        let fields = [otpFieldOne, otpFieldTwo, otpFieldThree, otpFieldFour]
              for (index, field) in fields.enumerated() {
                  field?.delegate = self
                  field?.keyboardType = .numberPad
                  field?.tag = index + 1
              }
        otpFieldOne.becomeFirstResponder()
    }
    
    func textField(_ textField: UITextField, shouldChangeCharactersIn range: NSRange, replacementString string: String) -> Bool {
            guard let text = textField.text else { return false }

            if string.count > 0 {
                textField.text = string
                if let nextField = view.viewWithTag(textField.tag + 1) as? UITextField {
                    nextField.becomeFirstResponder()
                } else {
                    textField.resignFirstResponder()
                    submitOTP()
                }
                return false
            } else {
                textField.text = ""
                if let prevField = view.viewWithTag(textField.tag - 1) as? UITextField {
                    prevField.becomeFirstResponder()
                }
                return false
            }
        }

    func showAlert(title: String,message: String) {
        DispatchQueue.main.async {
            self.present(AuthManager.shared.showAlert(title: title, message: message), animated: true, completion: nil)
        }
    }


    func submitOTP() {
        let otp = "\(otpFieldOne.text ?? "")\(otpFieldTwo.text ?? "")\(otpFieldThree.text ?? "")\(otpFieldFour.text ?? "")"
        Task {
            await viewModel.otpAuthentication(email: email!, otp: String(otp)) { checkResponse in
                if checkResponse == true {
                    NotificationCenter.default.post(name: Notification.Name("UserDidLoginOrRegister"), object: nil)
                    DispatchQueue.main.async {
                        self.view.window?.rootViewController?.dismiss(animated: true, completion: nil)
                    }
                }else{
                    self.showAlert(title: "", message: k.validationMessages.tryAgain)
                }
            }
        }
    }
}
