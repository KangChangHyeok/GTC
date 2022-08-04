//
//  InputNameViewController.swift
//  InstagramChallenge
//
//  Created by 강창혁 on 2022/07/30.
//

import UIKit

class InputNameViewController: UIViewController {

    @IBOutlet weak var userNameTextField: UITextField!
    @IBOutlet weak var nextButton: UIButton! {
        didSet {
            nextButton.isEnabled = false
            nextButton.alpha = 0.5
        }
    }
    override func viewDidLoad() {
        super.viewDidLoad()
        setUpUserNameTextField()
        
        
    }

    func setUpUserNameTextField() {
        userNameTextField.delegate = self
    }
    
    @IBAction func nextButtonTapped(_ sender: UIButton) {
        guard let userName = userNameTextField.text else {return}
        //일반 회원가입시
        if UserSignUpInfo.shared.loginPattern == .normal {
            //userInfo에 이름 추가
            UserSignUpInfo.shared.userName = userName
            let inputPassWordViewController = UIStoryboard(name: "Main", bundle: nil).instantiateViewController(withIdentifier: "InputPassWordViewController") as! InputPassWordViewController
            inputPassWordViewController.modalPresentationStyle = .fullScreen
            present(inputPassWordViewController, animated: false)
        //소셜 로그인(카카오 로그인)일 경우 -> loginPattern = .kakao
        } else {
            //userInfo에 이름 추가
            UserSignUpInfo.shared.userName = userName
            let inputBirthdayViewController = UIStoryboard(name: "Main", bundle: nil).instantiateViewController(withIdentifier: "InputBirthdayViewController") as! InputBirthdayViewController
            inputBirthdayViewController.modalPresentationStyle = .fullScreen
            present(inputBirthdayViewController, animated: false)
        }
        
    }
    
    @IBAction func loginButtonTapped(_ sender: UIButton) {
        self.view.window?.rootViewController?.dismiss(animated: true, completion: nil)
    }
}

extension InputNameViewController: UITextFieldDelegate {
    func textField(_ textField: UITextField, shouldChangeCharactersIn range: NSRange, replacementString string: String) -> Bool {
        print(range)
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
