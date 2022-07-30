//
//  InputCertificationViewController.swift
//  InstagramChallenge
//
//  Created by 강창혁 on 2022/07/30.
//

import UIKit

class InputCertificationViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()

     
    }

    @IBAction func nextButtonTapped(_ sender: UIButton) {
        let inputNameViewController = UIStoryboard(name: "Main", bundle: nil).instantiateViewController(withIdentifier: "InputNameViewController") as! InputNameViewController
        inputNameViewController.modalPresentationStyle = .fullScreen
        present(inputNameViewController, animated: false)
    }
}
