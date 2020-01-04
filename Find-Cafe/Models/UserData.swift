//
//  UserData.swift
//  Find-Cafe
//
//  Created by APAN on 2020/1/1.
//  Copyright © 2020 APAN. All rights reserved.
//

import Foundation

struct UserCities {
    var name: String
    var en_name: String
    var subhead: String
    var image: String
}

struct UserCafeDatas {
    var name: String
    var city: String
    var tasty: Double?
    var address: String
    var mrt: String?
    var url: String?
    var open_time: String?
    var note: String?
    var image: Data?
}
