//
//  LocationManager.swift
//  HeartbeatSwiftUI Watch App
//
//  Created by Work on 3/5/24.
//

import Foundation
import SwiftUI
import CoreLocation

class LocationManager: NSObject, CLLocationManagerDelegate {
    let locationManager = CLLocationManager()
    
    override init() {
        super.init()
        self.locationManager.requestWhenInUseAuthorization()
        self.locationManager.delegate = self
        self.locationManager.startUpdatingLocation()
    }
}
