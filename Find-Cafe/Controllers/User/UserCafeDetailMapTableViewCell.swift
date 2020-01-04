//
//  UserCafeDetailMapTableViewCell.swift
//  Find-Cafe
//
//  Created by APAN on 2020/1/2.
//  Copyright © 2020 APAN. All rights reserved.
//

import UIKit
import MapKit

class UserCafeDetailMapTableViewCell: UITableViewCell {

    @IBOutlet weak var mapView: MKMapView!
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
    func configure(location: String, name: String) {
        // 取得位置
        let geoCoder = CLGeocoder()
 
        geoCoder.geocodeAddressString(location, completionHandler: { placemarks, error in
            if let error = error {
                print(error.localizedDescription)
                return
            }
            if let placemarks = placemarks {
                // 取得第一個地點標記
                let placemark = placemarks[0]
                // 加上標記
                let annotation = MKPointAnnotation()
                annotation.title = name
                if let location = placemark.location {
                    // 顯示標記
                    annotation.coordinate = location.coordinate
                    
                    self.mapView.addAnnotation(annotation)
                    // 設定縮放程度
                    let region = MKCoordinateRegion(center: annotation.coordinate, latitudinalMeters: 250, longitudinalMeters: 250)
                    self.mapView.setRegion(region, animated: false)
                }
            }
        })
    }

}
