//
//  CycleCell.swift
//  RRDouyuTV
//
//  Created by 丁瑞瑞 on 16/10/16.
//  Copyright © 2016年 Rochester. All rights reserved.
//

import UIKit

class CycleCell: UICollectionViewCell {
    // MARK:- 空间属性
    // 名字
    @IBOutlet weak var titleLabel: UILabel!
    // 图片
    @IBOutlet weak var iconImage: UIImageView!
    var cycelModel : String?{
        didSet {
            guard let cycelModel : String = cycelModel else {return}
            guard let url = URL(string: cycelModel) else {return}
            iconImage.kf.setImage(with: url)
        }
    }
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

}
