//
//  AcceptViewController.swift
//  InstagramChallenge
//
//  Created by 강창혁 on 2022/07/30.
//

import UIKit
import DLRadioButton

class AcceptViewController: UIViewController {

    @IBOutlet weak var allArgeeButton: DLRadioButton!
    override func viewDidLoad() {
        super.viewDidLoad()
        allArgeeButton.isMultipleSelectionEnabled = true
    }

    @IBAction func radioButtonTapped(_ sender: DLRadioButton) {
        print(sender.currentTitle)
    }
    @IBAction func nextButtonTapped(_ sender: UIButton) {
        let createNameViewController = UIStoryboard(name: "Main", bundle: nil).instantiateViewController(withIdentifier: "CreateNameViewController") as! CreateNameViewController
        createNameViewController.modalPresentationStyle = .fullScreen
        present(createNameViewController, animated: false)
    }
}
