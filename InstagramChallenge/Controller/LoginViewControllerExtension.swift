//
//  LoginViewControllerExtension.swift
//  InstagramChallenge
//
//  Created by 강창혁 on 2022/07/27.
//

import Foundation
import UIKit

extension LoginViewController: UITextFieldDelegate {
    
    func textField(_ textField: UITextField, shouldChangeCharactersIn range: NSRange, replacementString string: String) -> Bool  {
        var userIdEmpty = true
        var userPwEmpty = true
        if textField == userIdtextField {
            print(range.location)
            if range.location == 0  {
                userIdEmpty.toggle()
            } else {
                userIdEmpty = false
            }
        } else if textField == userPwTextField  {
            if range.location == 0  {
                userPwEmpty.toggle()
            } else {
                userPwEmpty = false
            }
        }
        if userIdEmpty == false || userIdEmpty == false {
                self.loginButton.isEnabled = false
            self.loginButton.alpha = 0.5
            } else {
                self.loginButton.isEnabled = true
                loginButton.alpha = 1
            }
        // get the current text, or use an empty string if that failed
        guard let currentText = textField.text else {return false}
        guard let stringRange = Range(range, in: currentText) else { return false }
        let updatedText = currentText.replacingCharacters(in: stringRange, with: string)
        return updatedText.count <= 20
    }
    //    func textField(_ textField: UITextField, shouldChangeCharactersIn range: NSRange, replacementString string: String) -> Bool {
    //        guard let text = textField.text?.count else {return false}
    //        if text <= 20 {
    //            return true
    //        } else {
    //            return false
    //        }
    //    }
}
