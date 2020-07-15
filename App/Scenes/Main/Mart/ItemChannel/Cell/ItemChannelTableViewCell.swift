//
//  ItemChannelTableViewCell.swift
//  App
//
//  Created by Chuong Vu Duy on 7/15/20.
//  Copyright © 2020 METADIUM. All rights reserved.
//

import UIKit
import Domain
import Kingfisher

class ItemChannelTableViewCell: UITableViewCell {
    @IBOutlet weak var ivMain: UIImageView!
    @IBOutlet weak var lblLikeCount: UILabel!
    @IBOutlet weak var lblCommentCount: UILabel!
    @IBOutlet weak var lblCategory: UILabel!
    @IBOutlet weak var lblName: UILabel!
    @IBOutlet weak var lblDate: UILabel!

    override func awakeFromNib() {
        super.awakeFromNib()

        lblCategory.text = ""
        lblName.text = ""
        lblDate.text = ""
        lblLikeCount.text = ""
        lblCommentCount.text = ""
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
    }

    func bindData(item: ChannelEntity) {
        if let imagePath = item.imgPath {
            ivMain.kf.setImage(with: URL(string: imagePath), placeholder: nil, options: [.transition(.fade(1))])
        }
        if let categoryName = item.category {
            lblCategory.text = categoryName
        }
        if let itemName = item.title {
            lblName.text = itemName
        }
        if let date = item.insDate {
            lblDate.text = date
        }
        if let likeCount = item.likeCnt {
            lblLikeCount.text = likeCount
        }
        if let commentCount = item.replyCnt {
            lblCommentCount.text = commentCount
        }
    }
    
}
