//
//  LoginViewControllerExtension.swift
//  InstagramChallenge
//
//  Created by 강창혁 on 2022/07/27.
//

import Foundation
import UIKit

extension LoginViewController: UITextFieldDelegate {
    //텍스트필드에 글자가 입력되어있지 않을 경우 버튼 비활성화.
    func textField(_ textField: UITextField, shouldChangeCharactersIn range: NSRange, replacementString string: String) -> Bool  {
        guard let userId = userIdtextField.text else {return false}
        guard let userPw = userPwTextField.text else {return false}
        var userIdEmpty = true
        var userPwEmpty = true
        //텍스트필드 입력이 아이디일때
        if textField == userIdtextField {
            //텍스트필드가 비어있다면
            if range.location == 0  {
                userIdEmpty = true
                //비밀번호 텍스트필드 검사하기
                if userPw.isEmpty {
                    userPwEmpty = true
                } else {
                    userPwEmpty = false
                }
                
            } else {
                userIdEmpty = false
                if userPw.isEmpty {
                    userPwEmpty = true
                } else {
                    userPwEmpty = false
                }
            }
            //텍스트필드 입력이 패스워드 일때
        } else if textField == userPwTextField  {
            //텍스트필드가 비어있다면
            if range.location == 0  {
                userPwEmpty = true
                if userId.isEmpty {
                    userIdEmpty = true
                } else {
                    userIdEmpty = false
                }
            } else {
                userPwEmpty = false
                if userId.isEmpty {
                    userIdEmpty = true
                } else {
                    userIdEmpty = false
                }
            }
        }
        if userIdEmpty == true || userPwEmpty == true {
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
    
    func textFieldDidBeginEditing(_ textField: UITextField) {
        textField.becomeFirstResponder()
    }
    
    func textFieldDidEndEditing(_ textField: UITextField) {
        textField.resignFirstResponder()
    }
    
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        self.view.endEditing(true)
    }
}
