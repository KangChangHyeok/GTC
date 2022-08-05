//
//  CreateNameViewController.swift
//  InstagramChallenge
//
//  Created by 강창혁 on 2022/07/30.
//

import UIKit

class CreateNameViewController: UIViewController {
    
    @IBOutlet weak var userNickNameTextField: UITextField!
    @IBOutlet weak var nextButton: UIButton!
    @IBOutlet weak var errorMessage: UILabel!
    @IBOutlet weak var checkImage: UIImageView!
    var imageCheck = false
    let dataManger = DataManager()
    override func viewDidLoad() {
        super.viewDidLoad()
        setUpUserNickNameTextField()
    }
    
    func setUpUserNickNameTextField() {
        userNickNameTextField.delegate = self
    }
    //닉네임 유효성 검사 (소문자영어, 숫자, _ , .)
    func checkUserNickNameValidation(userNickName: String) -> Bool{
        let regex = "0-9a-z._-"
        let isValidUserId = (userNickName.range(of: regex, options: .regularExpression ) != nil)
        return isValidUserId
    }
    @IBAction func nextButtonTapped(_ sender: UIButton) {
        guard let userNickName = userNickNameTextField.text else {return}
        dataManger.getConfirmID(userId: userNickName) { UserPostResponse in
            //닉네임이 중복된 경우
            if UserPostResponse.code == 2230 {
                self.errorMessage.text = "사용자 이름 \(userNickName)을 사용할 수 없습니다."
                self.userNickNameTextField.layer.borderColor = .init(red: 0.3, green: 0.3, blue: 0.3, alpha: 1)
                self.imageCheck = false
                //닉네임 유효성 검사 실패한 경우
            } else if self.checkUserNickNameValidation(userNickName: userNickName){
                self.errorMessage.text = "아이디는 영어, 숫자, _ , . 만 사용 가능합니다."
                self.imageCheck = false
                //위 두개의 조건이 아니라면 닉네임을 UserInfo에 저장하고 화면 이동
            } else {
                if self.imageCheck == true {
                    let lastCheckViewController = UIStoryboard(name: "Main", bundle: nil).instantiateViewController(withIdentifier: "LastCheckViewController") as! LastCheckViewController
                    lastCheckViewController.UserNickName = "\(userNickName)님으로 가입하시겠어요?"
                    lastCheckViewController.modalPresentationStyle = .fullScreen
                    self.present(lastCheckViewController, animated: false)
                }
                //UserInfo에 저장
                UserSignUpInfo.shared.userNickName = userNickName
                //checkImage 변경
                self.checkImage.image = UIImage(named: "checkImage.png")
                self.imageCheck = true
                
            }
        }
        
    }
    @IBAction func loginButtonTapped(_ sender: UIButton) {
        self.view.window?.rootViewController?.dismiss(animated: true, completion: nil)
    }
}

extension CreateNameViewController: UITextFieldDelegate {
    func textField(_ textField: UITextField, shouldChangeCharactersIn range: NSRange, replacementString string: String) -> Bool {
        guard let currentText = textField.text else {return false}
        guard let stringRange = Range(range, in: currentText) else { return false }
        let updatedText = currentText.replacingCharacters(in: stringRange, with: string)
        return updatedText.count <= 20
    }
}
