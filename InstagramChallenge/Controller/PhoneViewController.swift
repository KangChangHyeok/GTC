//
//  PhoneViewController.swift
//  InstagramChallenge
//
//  Created by 강창혁 on 2022/07/30.
//

import UIKit

class PhoneViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
    }

    @IBAction func nextButtonTapped(_ sender: UIButton) {
        let inputCertificationViewController = UIStoryboard(name: "Main", bundle: nil).instantiateViewController(withIdentifier: "InputCertificationViewController") as! InputCertificationViewController
        inputCertificationViewController.modalPresentationStyle = .fullScreen
        present(inputCertificationViewController, animated: false)
    }
    @IBAction func kakaoLoginButtonTapped(_ sender: UIButton) {
    }
}
