//
//  MainTableViewCell.swift
//  InstagramChallenge
//
//  Created by 강창혁 on 2022/08/05.
//

import UIKit
import FSPagerView

class MainTableViewCell: UITableViewCell {

    @IBOutlet weak var userProfileImage: UIImageView!
    @IBOutlet weak var userIdLabel: UILabel!
    @IBOutlet weak var viewMoreButton: UIButton!
    @IBOutlet weak var userSlideImage: FSPagerView!
    @IBOutlet weak var userSlideImageCount: FSPageControl!
    @IBOutlet weak var likesCountLabel: UILabel!
    override func awakeFromNib() {
        super.awakeFromNib()
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
    }
    
}
