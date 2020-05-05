//
//  InfoViewTableViewCell.swift
//  HeartApp
//
//  Created by Tareq Rahman Joy on 5/5/20.
//  Copyright © 2020 Tareq Rahman Joy. All rights reserved.
//

import UIKit

class InfoViewTableViewCell: UITableViewCell {

    @IBOutlet weak var ageLabel: UILabel!
    @IBOutlet weak var nameLabel: UILabel!
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
}
