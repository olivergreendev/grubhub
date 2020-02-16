//
//  CustomMapPin.swift
//  GrubHub
//
//  Created by Oliver Green on 05/02/2020.
//  Copyright © 2020 Oliver Green. All rights reserved.
//

import Foundation
import MapKit

class CustomMapPin: NSObject, MKAnnotation {
    
    var coordinate: CLLocationCoordinate2D
    var title: String?
    var subtitle: String?
    var image: UIImage? = nil
    
    init(pinTitle: String, pinSubTitle: String, location: CLLocationCoordinate2D) {
        self.title = pinTitle
        self.subtitle = pinSubTitle
        self.coordinate = location
        super.init()
    }
}
