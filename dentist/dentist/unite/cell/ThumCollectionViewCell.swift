//
//  ThumCollectionViewCell.swift
//  swifttest3
//
//  Created by feng zhenrong on 2018/11/1.
//  Copyright © 2018年 feng zhenrong. All rights reserved.
//

import UIKit

class ThumCollectionViewCell: BasePageCollectionCell {

    @IBOutlet var backgroundImageView: UIImageView!
    
    @IBOutlet weak var serialLabel: UILabel!
    
    @IBOutlet weak var Archive: UIButton!
    @IBOutlet weak var titleLabel: UILabel!
    @IBOutlet weak var volIssueLabel: UILabel!
    
    @IBOutlet weak var backTitleLabel: UILabel!
    
    @IBOutlet weak var backAuthorLabel: UILabel!
    
    @IBOutlet weak var pushDataLabel: UILabel!
    
    @IBOutlet weak var ArchiiveButton: UIButton!
    override func awakeFromNib() {
        super.awakeFromNib()
        ArchiiveButton.layer.borderColor=UIColor.darkGray.cgColor
        ArchiiveButton.layer.borderWidth=1.0
//        self.backgroundColor=UIColor.red
//        self.backgroundImageView.loadUrl("http://app800.cn/i/p.png", placeholderImage: "school")
    }

}
