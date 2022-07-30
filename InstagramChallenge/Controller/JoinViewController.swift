//
//  JoinViewController.swift
//  InstagramChallenge
//
//  Created by 강창혁 on 2022/07/29.
//

import UIKit

class JoinViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
    }
    @IBAction func kakaoLoginBUttonTapped(_ sender: UIButton) {
    }
    
    @IBAction func userJoinButtonTapped(_ sender: UIButton) {
        let emailJoinViewController = UIStoryboard(name: "Main", bundle: nil).instantiateViewController(withIdentifier: "EmailJoinViewController") as! EmailJoinViewController
        emailJoinViewController.modalPresentationStyle = .fullScreen
        present(emailJoinViewController, animated: false)
    }
    @IBAction func loginButtonTapped(_ sender: UIButton) {
        self.dismiss(animated: false)
    }
}
