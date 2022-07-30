//
//  InputPassWordViewController.swift
//  InstagramChallenge
//
//  Created by 강창혁 on 2022/07/30.
//

import UIKit

class InputPassWordViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
    }

    @IBAction func nextButtonTapped(_ sender: UIButton) {
        let inputBirthdayViewController = UIStoryboard(name: "Main", bundle: nil).instantiateViewController(withIdentifier: "InputBirthdayViewController") as! InputBirthdayViewController
        inputBirthdayViewController.modalPresentationStyle = .fullScreen
        present(inputBirthdayViewController, animated: false)
    }
}
