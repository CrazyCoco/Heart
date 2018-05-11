//
//  MusicListTableViewCell.swift
//  Heart
//
//  Created by YURENJIE on 2018/5/11.
//  Copyright © 2018年 yurenjie. All rights reserved.
//

import UIKit

class MusicListTableViewCell: UITableViewCell {

    @IBOutlet weak var number: UILabel!
    @IBOutlet weak var name: UILabel!
    @IBOutlet weak var singer: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
