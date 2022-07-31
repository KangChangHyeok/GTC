//
//  ViewController.swift
//  InstagramChallenge
//
//  Created by 강창혁 on 2022/07/25.
//

import UIKit
import Foundation
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
    //아이디 유효성 검사
    func checkIdValidation(userId: String) -> Bool{
        let regex = ".{3,20}"
        let isValidUserId = (userId.range(of: regex, options: .regularExpression ) != nil)
        return isValidUserId
    }
    //비밀번호 유효성 검사
    func checkPwValidation(userPw: String) -> Bool{
        let regex = "(?=.*[$@$!%*?&]).{6,20}"
        let isValidUserPw = (userPw.range(of: regex, options: .regularExpression ) != nil)
    
        return isValidUserPw
    }
    @IBAction func passwordShowButtonTapped(_ sender: UIButton) {
        userPwTextField.isSecureTextEntry.toggle()
        if userPwTextField.isSecureTextEntry {
            passWordToggleButton.setImage(UIImage(named: "hidePassWord.png"), for: .normal)
        } else {
            passWordToggleButton.setImage(UIImage(named: "showPassWord.png"), for: .normal)
        }
    }
    @IBAction func loseUserPwButtonTapped(_ sender: UIButton) {
    }
    
    
    @IBAction func LoginButtonTapped(_ sender: UIButton) {
        guard let userIdText = userIdtextField.text else {return}
        guard let userIdPasswordText = userPwTextField.text else {return}
        //아이디와 비밀번호 유효성 검사
        if checkIdValidation(userId: userIdText) && checkPwValidation(userPw: userIdPasswordText) {
            //존재하는 유저인지 서버 확인
            dataManager.postUserSignIn(id: userIdText, password: userIdPasswordText) { UserPostResponse in
                //네트워크 성공시 userdefault에 jwt 키값으로 jwt 토큰 값 저장
                if UserPostResponse.isSuccess == true {
                    UserDefaults.standard.setValue(UserPostResponse.result?.jwt, forKey: "jwt")
                    print(UserDefaults.standard.string(forKey: "jwt")!)
                    let mainViewController = UIStoryboard(name: "Main", bundle: nil).instantiateViewController(withIdentifier: "MainViewController") as! MainViewController
                    //메인화면으로 이동
                    self.view.window?.rootViewController = mainViewController
                } else {
                    //로그인 실패할경우 alret 출력
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
            //유효성 검사 실패시 alret창 출력
        } else {
            let sheet = UIAlertController(title: "계정을 찾을 수 없음", message: "\(userIdText)에 연결된 계정을 찾을 수 없습니다. 다른 전화번호나 이메일 주소를 사용해보세요. Instagram 계정이 없으면 가입할 수 있습니다.", preferredStyle: .alert)
            
            sheet.addAction(UIAlertAction(title: "가입하기", style: .default, handler: { UIAlertAction in
                let joinViewController = UIStoryboard(name: "Main", bundle: nil).instantiateViewController(withIdentifier: "JoinViewController") as! JoinViewController
                joinViewController.modalPresentationStyle = .fullScreen
                self.present(joinViewController, animated: false)
            }))
            sheet.addAction(UIAlertAction(title: "다시 시도", style: .default))
            self.present(sheet, animated: true)        }
        
        
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

