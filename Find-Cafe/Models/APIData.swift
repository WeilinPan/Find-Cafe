//
//  APIData.swift
//  Find-Cafe
//
//  Created by APAN on 2019/12/27.
//  Copyright © 2019 APAN. All rights reserved.
//

import Foundation

struct APIData: Codable {
    var name: String
    var city: String
    var tasty: Double
    var address: String
    var mrt: String?
    var url: String?
    var open_time: String?
    var latitude: String
    var longitude: String
}

struct APICities {
    var name: String
    var en_name: String
    var subhead: String
    var image: String
}
