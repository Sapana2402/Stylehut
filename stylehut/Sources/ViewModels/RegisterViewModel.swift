//
//  RegisterViewModel.swift
//  stylehut
//
//  Created by MACM26 on 26/05/25.
//

import Foundation
class RegisterViewModel {
    func register(email: String, completion: @escaping (Bool?) -> Void) async {
        await NetworkManager.registerUser(email: email) { success, message in
            completion(success)
        }
    }
    
    func otpAuthentication(email: String,otp: String, completion: @escaping (Bool?) -> Void) async {
        await NetworkManager.otpVerification(email: email, otp: otp) { success, message in
            completion(success)
        }
    }
}
