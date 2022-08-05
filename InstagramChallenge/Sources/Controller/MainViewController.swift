//
//  MainViewController.swift
//  InstagramChallenge
//
//  Created by 강창혁 on 2022/07/28.
//

import UIKit

class MainViewController: UIViewController {

    @IBOutlet weak var mainTableView: UITableView!
    override func viewDidLoad() {
        super.viewDidLoad()
        mainTableView.delegate = self
        mainTableView.dataSource = self
        let mainTableViewCell = UINib(nibName: "MainTableViewCell", bundle: nil)
        mainTableView.register(mainTableViewCell, forCellReuseIdentifier: "mainTableViewCell")
        let header = UIView(frame: CGRect(x: 0, y: 0, width: view.frame.width, height: 100))
        header.backgroundColor = .orange
        mainTableView.tableHeaderView = header
    }

}


extension MainViewController: UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 3
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "mainTableViewCell", for: indexPath)
        return cell
    }
    
    
}

extension MainViewController: UITableViewDelegate {
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        print("셀 선택됨")
    }
}
