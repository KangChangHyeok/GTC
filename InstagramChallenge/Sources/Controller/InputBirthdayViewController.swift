//
//  InputBirthdayViewController.swift
//  InstagramChallenge
//
//  Created by 강창혁 on 2022/07/30.
//

import UIKit

class InputBirthdayViewController: UIViewController {

    @IBOutlet weak var userDateofBirth: UIDatePicker!
    @IBOutlet weak var userBirthDay: UILabel! {
        didSet {
            let formatter = DateFormatter()
            formatter.dateFormat = "yyyy년 MM월 dd일"
            userBirthDay.text = formatter.string(from: Date())
            userBirthDay.textColor = .lightGray
        }
    }
    @IBOutlet weak var userAge: UILabel!
    @IBOutlet weak var nextButton: UIButton!
    override func viewDidLoad() {
        super.viewDidLoad()
    }
    @IBAction func nextButtonTapped(_ sender: UIButton) {
        let acceptViewController = UIStoryboard(name: "Main", bundle: nil).instantiateViewController(withIdentifier: "AcceptViewController") as! AcceptViewController
        acceptViewController.modalPresentationStyle = .fullScreen
        present(acceptViewController, animated: false)
    }
    @IBAction func changeUserBirthDay(_ sender: UIDatePicker) {
        userBirthDay.textColor = .black
        // 유저 나이 구하기
        let dateformatter = DateFormatter()
        dateformatter.dateFormat = "yyyy"
        let userBirth = Int(dateformatter.string(from: sender.date))!
        let now = Int(dateformatter.string(from: Date()))!
        userAge.text = (now - userBirth + 1).description + "세"
        // 유저 생일 표시하기
        dateformatter.dateFormat = "yyyy년 MM월 dd일"
        userBirthDay.text = dateformatter.string(from: sender.date)
        dateformatter.dateFormat = "yyyy.MM.dd"
        UserSignUpInfo.shared.userBirthday = dateformatter.string(from: sender.date)
        // 오늘 이후 날짜 선택시 버튼 비활성화
        dateformatter.dateFormat = "yyyyMMdd"
        let nowYear = Int(dateformatter.string(from: Date()))!
        let selectYear = Int(dateformatter.string(from: sender.date))!
        if nowYear - selectYear < 0 {
            nextButton.isEnabled = false
            nextButton.alpha = 0.5
            userAge.text = ""
        }
    }
}
