//
//  APICityCafeListTableViewCell.swift
//  Find-Cafe
//
//  Created by APAN on 2019/12/28.
//  Copyright © 2019 APAN. All rights reserved.
//

import UIKit

class APICityCafeListTableViewCell: UITableViewCell {
    @IBOutlet weak var cafeImageView: UIImageView!
    @IBOutlet weak var cafeNameLabel: UILabel!
    @IBOutlet weak var cafeAddressLabel: UILabel!
    @IBOutlet weak var cafeOpentimeLabel: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
