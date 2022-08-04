//
//  PhoneViewController.swift
//  InstagramChallenge
//
//  Created by 강창혁 on 2022/07/30.
//

import UIKit
import KakaoSDKAuth
import KakaoSDKUser
class PhoneViewController: UIViewController {
    
    let dataManager = DataManager()
    @IBOutlet weak var userPhoneNumberTextField: UITextField!
    @IBOutlet weak var nextButton: UIButton! {
        didSet {
            nextButton.isEnabled = true
            nextButton.alpha = 0.5
        }
    }
    override func viewDidLoad() {
        super.viewDidLoad()
        userPhoneNumberTextField.delegate = self
    }
    
    @IBAction func nextButtonTapped(_ sender: UIButton) {
        let inputCertificationViewController = UIStoryboard(name: "Main", bundle: nil).instantiateViewController(withIdentifier: "InputCertificationViewController") as! InputCertificationViewController
        

        if let phoneNumber = self.userPhoneNumberTextField.text {
            inputCertificationViewController.phoneNumber = phoneNumber
        }
        inputCertificationViewController.modalPresentationStyle = .fullScreen
        present(inputCertificationViewController, animated: false)
    }
    @IBAction func kakaoLoginButtonTapped(_ sender: UIButton) {
        UserApi.shared.loginWithKakaoAccount {(oauthToken, error) in
            //로그인 실패했을때
            guard let accessToken = oauthToken?.accessToken else {return}
            if let error = error {
                print("로그인 실패", error)
                let kakaoLoginFailAlert = UIAlertController(title: "로그인에 실패하였습니다.", message: nil, preferredStyle: .alert)
                kakaoLoginFailAlert.addAction(UIAlertAction(title: "확인", style: .default, handler: nil))
                self.present(kakaoLoginFailAlert, animated: true)
            }
            //로그인 성공했을때
            else {
                print("카카오 로그인 성공")
                self.dataManager.postUserKakaoSignIn(accessToken: accessToken) { UserPostResponse in
                    //성공
                    if UserPostResponse.isSuccess == true {
                        //성공시
                        
                        UserDefaults.standard.setValue(UserPostResponse.result?.jwt, forKey: "jwt")
                        let mainViewController = UIStoryboard(name: "Main", bundle: nil).instantiateViewController(withIdentifier: "MainViewController") as! MainViewController
                        self.view.window?.rootViewController = mainViewController
                        
                        
                        
                    } else {
                        //카카오 로그인은 정상적으로 성공했으나, 인스타그램 아이디를 생성하지 않았을때.
                        UserSignUpInfo.shared.loginPattern = .kakao
                        var kakaoUserId = ""
                        UserApi.shared.me { user, error in
                            if let result = user?.kakaoAccount?.email {
                                kakaoUserId = result
                            }
                            let sheet = UIAlertController(title: "계정을 찾을 수 없음", message: "\(kakaoUserId)에 연결된 계정을 찾을 수 없습니다. 다른 전화번호나 이메일 주소를 사용해보세요. Instagram 계정이 없으면 가입할 수 있습니다.", preferredStyle: .alert)
                            
                            sheet.addAction(UIAlertAction(title: "가입하기", style: .default, handler: { UIAlertAction in
                                let emailJoinViewController = UIStoryboard(name: "Main", bundle: nil).instantiateViewController(withIdentifier: "EmailJoinViewController") as! EmailJoinViewController
                                emailJoinViewController.modalPresentationStyle = .fullScreen
                                self.present(emailJoinViewController, animated: false)
                            }))
                            sheet.addAction(UIAlertAction(title: "다시 시도", style: .default))
                            self.present(sheet, animated: true)
                        }
                    }
                }
            }
        }
    }
}

extension PhoneViewController: UITextFieldDelegate {
    
    func textField(_ textField: UITextField, shouldChangeCharactersIn range: NSRange, replacementString string: String) -> Bool {
        var userPhoneNumberEmpty = true
        if range.location == 0  {
            userPhoneNumberEmpty.toggle()
        } else {
            userPhoneNumberEmpty = false
        }
        
        if userPhoneNumberEmpty == false {
            
            self.nextButton.isEnabled = true
            nextButton.alpha = 1
        } else {
            self.nextButton.isEnabled = false
            self.nextButton.alpha = 0.5
        }
        guard let currentText = textField.text else {return false}
        guard let stringRange = Range(range, in: currentText) else { return false }
        let updatedText = currentText.replacingCharacters(in: stringRange, with: string)
        return updatedText.count <= 11
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
        userPhoneNumberTextField.resignFirstResponder()
        
    }
}
