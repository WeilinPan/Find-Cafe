//
//  AboutTableViewCell.swift
//  Find-Cafe
//
//  Created by APAN on 2020/1/10.
//  Copyright © 2020 APAN. All rights reserved.
//

import UIKit

class AboutTableViewCell: UITableViewCell {

    @IBOutlet weak var iconImageView: UIImageView!
    @IBOutlet weak var titleLabel: UILabel!
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
