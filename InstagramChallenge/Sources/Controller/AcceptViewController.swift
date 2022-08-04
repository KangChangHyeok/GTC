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
    @IBOutlet weak var ServiceTermsButton: DLRadioButton!
    @IBOutlet weak var dataPolicyButton: DLRadioButton!
    @IBOutlet weak var locationBasedButton: DLRadioButton!
    @IBOutlet weak var nextButton: UIButton! {
        didSet {
            nextButton.isEnabled = false
            nextButton.alpha = 0.5
        }
    }
    override func viewDidLoad() {
        super.viewDidLoad()
        allArgeeButton.isMultipleSelectionEnabled = true
    }

    @IBAction func radioButtonTapped(_ sender: DLRadioButton) {
        switch sender {
        case allArgeeButton:
            if allArgeeButton.isSelected {
                ServiceTermsButton.isSelected = true
                dataPolicyButton.isSelected = true
                locationBasedButton.isSelected = true
                nextButton.isEnabled = true
                nextButton.alpha = 1
            } else {
                ServiceTermsButton.isSelected = false
                dataPolicyButton.isSelected = false
                locationBasedButton.isSelected = false
                nextButton.isEnabled = false
                nextButton.alpha = 0.5
            }
        case ServiceTermsButton:
            if ServiceTermsButton.isSelected && dataPolicyButton.isSelected && locationBasedButton.isSelected {
                nextButton.isEnabled = true
                nextButton.alpha = 1
            } else {
                nextButton.isEnabled = false
                nextButton.alpha = 0.5
            }
        case dataPolicyButton:
            if ServiceTermsButton.isSelected && dataPolicyButton.isSelected && locationBasedButton.isSelected {
                nextButton.isEnabled = true
                nextButton.alpha = 1
            } else {
                nextButton.isEnabled = false
                nextButton.alpha = 0.5
            }
        case locationBasedButton:
            if ServiceTermsButton.isSelected && dataPolicyButton.isSelected && locationBasedButton.isSelected {
                nextButton.isEnabled = true
                nextButton.alpha = 1
            } else {
                nextButton.isEnabled = false
                nextButton.alpha = 0.5
            }
        default:
            break
        }
        
        
    }
    @IBAction func nextButtonTapped(_ sender: UIButton) {
        let createNameViewController = UIStoryboard(name: "Main", bundle: nil).instantiateViewController(withIdentifier: "CreateNameViewController") as! CreateNameViewController
        createNameViewController.modalPresentationStyle = .fullScreen
        present(createNameViewController, animated: false)
    }
}
