//
//  CreateNameViewController.swift
//  InstagramChallenge
//
//  Created by 강창혁 on 2022/07/30.
//

import UIKit

class CreateNameViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()

    }

    @IBAction func nextButtonTapped(_ sender: UIButton) {
        let lastCheckViewController = UIStoryboard(name: "Main", bundle: nil).instantiateViewController(withIdentifier: "LastCheckViewController") as! LastCheckViewController
        lastCheckViewController.modalPresentationStyle = .fullScreen
        present(lastCheckViewController, animated: false)
    }
}
