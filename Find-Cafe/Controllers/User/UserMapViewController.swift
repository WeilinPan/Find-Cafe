//
//  UserMapViewController.swift
//  Find-Cafe
//
//  Created by APAN on 2020/1/3.
//  Copyright © 2020 APAN. All rights reserved.
//

import UIKit
import MapKit

class UserMapViewController: UIViewController {
    
    var cafeData: UserCafeDatas?
    @IBOutlet weak var mapView: MKMapView!
    override func viewDidLoad() {
        super.viewDidLoad()
        print(cafeData!)
        if let data = cafeData {
            let geoCoder = CLGeocoder()

            geoCoder.geocodeAddressString(data.address, completionHandler: { placemarks, error in
                 if let error = error {
                     print(error.localizedDescription)
                     return
                 }
                 if let placemarks = placemarks {
                     let placemark = placemarks[0]
                   
                     let annotation = MKPointAnnotation()
                     annotation.title = data.name
                     if let location = placemark.location {
                         
                         annotation.coordinate = location.coordinate
                         
                         self.mapView.showAnnotations([annotation], animated: true)
                         self.mapView.selectAnnotation(annotation, animated: true)
                     }
                 }
             })
        }
    }

}
