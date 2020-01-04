//
//  UserCitiesTableViewCell.swift
//  Find-Cafe
//
//  Created by APAN on 2020/1/1.
//  Copyright © 2020 APAN. All rights reserved.
//

import UIKit

class UserCitiesTableViewCell: UITableViewCell {

    @IBOutlet weak var cityImageView: UIImageView!
    @IBOutlet weak var cityHeadline: UILabel!
    @IBOutlet weak var citySubhead: UILabel!
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
