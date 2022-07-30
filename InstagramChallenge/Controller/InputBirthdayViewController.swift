//
//  InputBirthdayViewController.swift
//  InstagramChallenge
//
//  Created by 강창혁 on 2022/07/30.
//

import UIKit

class InputBirthdayViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
    }
    @IBAction func nextButtonTapped(_ sender: UIButton) {
        let acceptViewController = UIStoryboard(name: "Main", bundle: nil).instantiateViewController(withIdentifier: "AcceptViewController") as! AcceptViewController
        acceptViewController.modalPresentationStyle = .fullScreen
        present(acceptViewController, animated: false)
    }
}
