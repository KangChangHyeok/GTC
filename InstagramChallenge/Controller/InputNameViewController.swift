//
//  InputNameViewController.swift
//  InstagramChallenge
//
//  Created by 강창혁 on 2022/07/30.
//

import UIKit

class InputNameViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }

    @IBAction func nextButtonTapped(_ sender: UIButton) {
        
        let inputPassWordViewController = UIStoryboard(name: "Main", bundle: nil).instantiateViewController(withIdentifier: "InputPassWordViewController") as! InputPassWordViewController
        inputPassWordViewController.modalPresentationStyle = .fullScreen
        present(inputPassWordViewController, animated: false)
    }
}
