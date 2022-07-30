//
//  EmailJoinContainerViewController.swift
//  InstagramChallenge
//
//  Created by 강창혁 on 2022/07/30.
//

import UIKit

import UIKit
import Tabman
import Pageboy

class EmailJoinContainerViewController: TabmanViewController {
    
    private var viewControllers = [UIViewController]()
    override func viewDidLoad() {
        super.viewDidLoad()
        settingTabMan()
    }

    func settingTabMan() {
        let phoneViewController = UIStoryboard(name: "Main", bundle: nil).instantiateViewController(withIdentifier: "PhoneViewController") as! PhoneViewController
        let emailViewController = UIStoryboard(name: "Main", bundle: nil).instantiateViewController(withIdentifier: "EmailViewController") as! EmailViewController
        viewControllers.append(phoneViewController)
        viewControllers.append(emailViewController)
        self.dataSource = self
        let bar = TMBar.ButtonBar()
        bar.layout.transitionStyle = .snap
        bar.layout.contentMode = .fit
        bar.backgroundView.style = .blur(style: .light)
        
        bar.buttons.customize { button in
            button.tintColor = .init(rgb: 156)
            button.selectedTintColor = .black
            button.font = UIFont.systemFont(ofSize: 27, weight: .semibold)
        }
        bar.indicator.weight = .light
        bar.indicator.tintColor = .black
        addBar(bar, dataSource: self, at: .top)
        
    }
}

extension EmailJoinContainerViewController: PageboyViewControllerDataSource, TMBarDataSource {
    func numberOfViewControllers(in pageboyViewController: PageboyViewController) -> Int {
        return viewControllers.count
    }
    
    func viewController(for pageboyViewController: PageboyViewController, at index: PageboyViewController.PageIndex) -> UIViewController? {
        return viewControllers[index]
    }
    
    func defaultPage(for pageboyViewController: PageboyViewController) -> PageboyViewController.Page? {
        return nil
    }
    func barItem(for bar: TMBar, at index: Int) -> TMBarItemable {
        switch index {
        case 0:
            return TMBarItem(title: "전화번호")
        case 1:
            return TMBarItem(title: "이메일")
        default:
            return TMBarItem(title: "")
        }
    }
    
    
}
