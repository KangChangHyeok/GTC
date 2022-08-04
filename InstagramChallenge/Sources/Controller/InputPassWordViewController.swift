//
//  InputPassWordViewController.swift
//  InstagramChallenge
//
//  Created by 강창혁 on 2022/07/30.
//

import UIKit

class InputPassWordViewController: UIViewController {

    @IBOutlet weak var userPassWordTextField: UITextField!
    @IBOutlet weak var nextButton: UIButton! {
        didSet {
            nextButton.isEnabled = false
            nextButton.alpha = 0.5
        }
    }
    override func viewDidLoad() {
        super.viewDidLoad()
        setUpUSerPassWordTextField()
    }

    func setUpUSerPassWordTextField() {
        userPassWordTextField.delegate = self
    }
    //비밀번호 유효성 검사
    func checkPwValidation(userPw: String) -> Bool{
        let regex = "(?=.*[$@$!%*?&]).{6,20}"
        let isValidUserPw = (userPw.range(of: regex, options: .regularExpression ) != nil)
        return isValidUserPw
    }
    
    @IBAction func nextButtonTapped(_ sender: UIButton) {
        guard let userPassWord = userPassWordTextField.text else {return}
        //userInfo에 비밀번호 추가
        UserSignUpInfo.shared.userPassWord = userPassWord
        if checkPwValidation(userPw: userPassWord) {
            let inputBirthdayViewController = UIStoryboard(name: "Main", bundle: nil).instantiateViewController(withIdentifier: "InputBirthdayViewController") as! InputBirthdayViewController
            inputBirthdayViewController.modalPresentationStyle = .fullScreen
            present(inputBirthdayViewController, animated: false)
        } else {
            let passWordAlert = UIAlertController(title: "비밀번호를 확인해주세요.", message: nil, preferredStyle: .alert)
            passWordAlert.addAction(UIAlertAction(title: "확인", style: .default, handler: nil))
            self.present(passWordAlert, animated: true)
        }
        
    }
    @IBAction func loginButtonTapped(_ sender: UIButton) {
        self.view.window?.rootViewController?.dismiss(animated: true, completion: nil)
    }
}

extension InputPassWordViewController: UITextFieldDelegate {
    func textField(_ textField: UITextField, shouldChangeCharactersIn range: NSRange, replacementString string: String) -> Bool {
        if range.location == 0 && range.length == 1 {
            nextButton.isEnabled = false
            nextButton.alpha = 0.5
        } else {
            nextButton.isEnabled = true
            nextButton.alpha = 1
        }
        guard let currentText = textField.text else {return false}
        guard let stringRange = Range(range, in: currentText) else { return false }
        let updatedText = currentText.replacingCharacters(in: stringRange, with: string)
        return updatedText.count <= 20
    }
}
