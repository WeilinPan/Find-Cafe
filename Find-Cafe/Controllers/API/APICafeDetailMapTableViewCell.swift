//
//  APICafeDetailMapTableViewCell.swift
//  Find-Cafe
//
//  Created by APAN on 2019/12/30.
//  Copyright © 2019 APAN. All rights reserved.
//

import UIKit
import MapKit

class APICafeDetailMapTableViewCell: UITableViewCell {

    @IBOutlet weak var mapView: MKMapView!
    override func awakeFromNib() {
        super.awakeFromNib()
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
    func getLocation(lat: CLLocationDegrees, lon: CLLocationDegrees, name: String){
        let location: CLLocationCoordinate2D = CLLocationCoordinate2D(latitude: lat, longitude: lon)
        let xScale: CLLocationDegrees = 0.0025
        let yScale: CLLocationDegrees = 0.0025
        let span: MKCoordinateSpan = MKCoordinateSpan(latitudeDelta: xScale, longitudeDelta: yScale)
        let region: MKCoordinateRegion = MKCoordinateRegion(center: location, span: span)
        mapView.setRegion(region, animated: true)
        let annotation = MKPointAnnotation()    // 生成大頭針
        annotation.coordinate = location    // 設定大頭針座標
        annotation.title = name   // 加入標題
        mapView.addAnnotation(annotation)   // 在地圖上加入大頭針
    }
    


}
