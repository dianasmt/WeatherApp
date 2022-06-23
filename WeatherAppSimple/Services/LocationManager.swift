//
//  LocationManager.swift
//  WeatherAppSimple
//
//  Created by Диана Смахтина on 7.06.22.
//

import Foundation
import CoreLocation


protocol LoacationManagerProtocol {
    func getLocation() -> CLLocationCoordinate2D?
}

class LocationManager: NSObject, LoacationManagerProtocol {
    
    private let locationManager: CLLocationManager = CLLocationManager()
    
    func getLocation() -> CLLocationCoordinate2D? {
        return locationManager.location?.coordinate
    }
}


