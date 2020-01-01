//
//  APICafeDetailTableViewCell.swift
//  Find-Cafe
//
//  Created by APAN on 2019/12/30.
//  Copyright © 2019 APAN. All rights reserved.
//

import UIKit

class APICafeDetailTableViewCell: UITableViewCell {
    
    @IBOutlet var iconImageView: UIImageView!
    @IBOutlet weak var infoLabel: UILabel!
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
