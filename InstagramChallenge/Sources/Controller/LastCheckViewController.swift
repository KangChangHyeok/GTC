//
//  LastCheckViewController.swift
//  InstagramChallenge
//
//  Created by 강창혁 on 2022/07/30.
//

import UIKit

class LastCheckViewController: UIViewController {
    
    @IBOutlet weak var titleLabel: UILabel!
    @IBOutlet weak var nextButton: UIButton!
    var UserNickName = ""
    override func viewDidLoad() {
        super.viewDidLoad()
        titleLabel.text = UserNickName
    }
    
    @IBAction func nextButtonTapped(_ sender: UIButton) {
        let dataManger = DataManager()
        //자체 회원가입으로 진행할때
        if UserSignUpInfo.shared.loginPattern == .normal {
            dataManger.postUserSignUp { UserPostResponse in
                print(UserPostResponse)
                let mainTabBarController = UIStoryboard(name: "Main", bundle: nil).instantiateViewController(withIdentifier: "MainTabBarController") as! MainTabBarController
                self.view.window?.rootViewController = mainTabBarController
            }
        // 소셜 로그인으로 가입할때(loginPattern = .kakao)
        } else {
            dataManger.postKakaoUserSignUp(accessToken: UserSignUpInfo.shared.accessToken) { UserPostResponse in
                print("소셜 로그인 회원가입 성공!")
                print(UserPostResponse)
                let mainTabBarController = UIStoryboard(name: "Main", bundle: nil).instantiateViewController(withIdentifier: "MainTabBarController") as! MainTabBarController
                self.view.window?.rootViewController = mainTabBarController
            }
        }
        
        
        
    }
    
    @IBAction func loginButtonTapped(_ sender: UIButton) {
        self.view.window?.rootViewController?.dismiss(animated: true, completion: nil)
    }
}
