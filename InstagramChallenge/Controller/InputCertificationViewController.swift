//
//  InputCertificationViewController.swift
//  InstagramChallenge
//
//  Created by 강창혁 on 2022/07/30.
//

import UIKit

class InputCertificationViewController: UIViewController {
    
    @IBOutlet weak var userCertificationTextField: UITextField!
    @IBOutlet weak var phoneNumberLabel: UILabel!
    @IBOutlet weak var nextButton: UIButton! {
        didSet {
            nextButton.isEnabled = true
            nextButton.alpha = 0.5
        }
    }
    
    var phoneNumber = ""
    override func viewDidLoad() {
        super.viewDidLoad()
        setUpPhoneNumberLabel()
        setUPUserCertificationTextField()
    }
    
    func setUpPhoneNumberLabel() {
        phoneNumberLabel.text = "+82\(phoneNumber)번으로 전송된 인증 코드를 입력하세요."
    }
    func setUPUserCertificationTextField() {
        userCertificationTextField.delegate = self
    }
    @IBAction func ReSendMessageButtonTapped(_ sender: UIButton) {
        self.dismiss(animated: false)
    }
    @IBAction func phoneNuberChnageButtonTapped(_ sender: UIButton) {
        self.dismiss(animated: false)
    }
    @IBAction func nextButtonTapped(_ sender: UIButton) {
        let inputNameViewController = UIStoryboard(name: "Main", bundle: nil).instantiateViewController(withIdentifier: "InputNameViewController") as! InputNameViewController
        inputNameViewController.modalPresentationStyle = .fullScreen
        present(inputNameViewController, animated: false)
    }
    @IBAction func returnButtonTapped(_ sender: UIButton) {
        self.dismiss(animated: false)
    }
}

extension InputCertificationViewController: UITextFieldDelegate {
    
    func textField(_ textField: UITextField, shouldChangeCharactersIn range: NSRange, replacementString string: String) -> Bool {
        if range.location == 5 && range.length == 0 {
            nextButton.isEnabled = false
            nextButton.alpha = 1
        } else if range.location == 6 && range.length == 0 {
            nextButton.isEnabled = false
            nextButton.alpha = 1
        } else {
            nextButton.isEnabled = true
            nextButton.alpha = 0.5
        }
        guard let currentText = textField.text else {return false}
        guard let stringRange = Range(range, in: currentText) else { return false }
        let updatedText = currentText.replacingCharacters(in: stringRange, with: string)
        return updatedText.count <= 6
    }
    
    func textFieldDidBeginEditing(_ textField: UITextField) {
        textField.becomeFirstResponder()
        
    }
    
    func textFieldDidEndEditing(_ textField: UITextField) {
        guard let buttonEnabled = textField.text?.isEmpty else {return}
        if buttonEnabled == true {
            nextButton.isEnabled = true
            nextButton.alpha = 0.5
        }
    }
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        userCertificationTextField.resignFirstResponder()
        
    }
}
