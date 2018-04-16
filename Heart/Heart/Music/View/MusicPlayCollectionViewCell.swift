//
//  MusicPlayCollectionViewCell.swift
//  Heart
//
//  Created by YURENJIE on 2018/4/12.
//  Copyright © 2018年 yurenjie. All rights reserved.
//

import UIKit

class MusicPlayCollectionViewCell: UICollectionViewCell {
    
    
    @IBOutlet weak var imageView: UIImageView!
    @IBOutlet weak var likeButton: UIButton!
    @IBOutlet weak var downLoadButton: UIButton!
    @IBOutlet weak var aboutButton: UIButton!
    
    override func awakeFromNib() {
        super.awakeFromNib()
    }
    
    override init(frame: CGRect) {
        super.init(frame: frame)
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
    }
    
}
