//
//  GameOverTableViewCell.swift
//  Tiny Dev
//
//  Created by GalvanizeChris on 2/16/17.
//  Copyright © 2017 Crazy Sexy Panda. All rights reserved.
//

import UIKit

class GameOverTableViewCell: UITableViewCell {
    @IBOutlet var name: UILabel!
    @IBOutlet var DevTitle: UILabel!
    @IBOutlet var score: UILabel!
    @IBOutlet var cellImage: UIImageView!

    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
