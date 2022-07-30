//
//  ViewController.swift
//  InstagramChallenge
//
//  Created by 강창혁 on 2022/07/25.
//

import UIKit
import Alamofire
class LoginViewController: UIViewController {
    
    let dataManager = DataManager()
    @IBOutlet weak var userIdtextField: UITextField!
    @IBOutlet weak var userPwTextField: UITextField!
    @IBOutlet weak var loginButton: UIButton! {
        didSet {
            loginButton.isEnabled = false
            loginButton.alpha = 0.5
        }
    }
    @IBOutlet weak var passWordToggleButton: UIButton!
    @IBOutlet var line: [UIView]!
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        settingLoginViewControllerUI()
        settingDelegate()
    }
    func settingLoginViewControllerUI() {
        userIdtextField.backgroundColor = .init(rgb: 249)
        userPwTextField.backgroundColor = .init(rgb: 249)
        for i in line {
            i.backgroundColor = .init(rgb: 233)
        }
        loginButton.layer.cornerRadius = 4
    }
    
    func settingDelegate() {
        userIdtextField.delegate = self
        userPwTextField.delegate = self
    }
    @IBAction func passwordShowButtonTapped(_ sender: UIButton) {
        userPwTextField.isSecureTextEntry.toggle()
        if userPwTextField.isSecureTextEntry {
            passWordToggleButton.backgroundColor = .blue
        } else {
            passWordToggleButton.backgroundColor = .red
        }
    }
    @IBAction func loseUserPwButtonTapped(_ sender: UIButton) {
    }
    
    
    @IBAction func LoginButtonTapped(_ sender: UIButton) {
        guard let userIdText = userIdtextField.text else {return}
        guard let userIdPasswordText = userPwTextField.text else {return}
        dataManager.postUserSignIn(id: userIdText, password: userIdPasswordText) { UserPostResponse in
            if UserPostResponse.isSuccess == true {
                UserDefaults.standard.setValue(UserPostResponse.result?.jwt, forKey: "jwt")
                print(UserDefaults.standard.string(forKey: "jwt")!)
                let mainViewController = UIStoryboard(name: "Main", bundle: nil).instantiateViewController(withIdentifier: "MainViewController") as! MainViewController
                self.view.window?.rootViewController = mainViewController
            } else {
                let sheet = UIAlertController(title: "계정을 찾을 수 없음", message: "\(userIdText)에 연결된 계정을 찾을 수 없습니다. 다른 전화번호나 이메일 주소를 사용해보세요. Instagram 계정이 없으면 가입할 수 있습니다.", preferredStyle: .alert)
                
                sheet.addAction(UIAlertAction(title: "가입하기", style: .default, handler: { UIAlertAction in
                    let joinViewController = UIStoryboard(name: "Main", bundle: nil).instantiateViewController(withIdentifier: "JoinViewController") as! JoinViewController
                    joinViewController.modalPresentationStyle = .fullScreen
                    self.present(joinViewController, animated: false)
                }))
                sheet.addAction(UIAlertAction(title: "다시 시도", style: .default))
                self.present(sheet, animated: true)
            }
        }
    }
    @IBAction func KakaoLoginButtonTapped(_ sender: UIButton) {
        dataManager.postUserKakaoSignIn { UserPostResponse in
            if UserPostResponse.isSuccess == true {
                UserDefaults.standard.setValue(UserPostResponse.result?.jwt, forKey: "jwt")
                let mainViewController = UIStoryboard(name: "Main", bundle: nil).instantiateViewController(withIdentifier: "MainViewController") as! MainViewController
                self.view.window?.rootViewController = mainViewController
            } else {
                let kakaoLoginFailAlert = UIAlertController(title: "로그인에 실패하였습니다.", message: nil, preferredStyle: .alert)
                kakaoLoginFailAlert.addAction(UIAlertAction(title: "확인", style: .default, handler: nil))
                self.present(kakaoLoginFailAlert, animated: true)
            }
        }
    }
    @IBAction func joinUserButtonTapped(_ sender: UIButton) {
        let joinViewController = UIStoryboard(name: "Main", bundle: nil).instantiateViewController(withIdentifier: "JoinViewController") as! JoinViewController
        joinViewController.modalPresentationStyle = .fullScreen
        self.present(joinViewController, animated: false)
        
    }
    
}

