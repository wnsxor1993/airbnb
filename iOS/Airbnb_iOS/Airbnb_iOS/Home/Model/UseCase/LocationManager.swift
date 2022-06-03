//
//  LocationManager.swift
//  Airbnb_iOS
//
//  Created by juntaek.oh on 2022/06/02.
//

import CoreLocation

final class LocationManager {
    
    let locationManager = CLLocationManager()
    
    enum AceessCase {
        case authorized
        case notDecided
        case denied
        case nothing
    }
    
    func setLocationAccess() -> AceessCase {
        guard CLLocationManager.locationServicesEnabled() else { return .nothing}
        
        self.locationManager.desiredAccuracy = kCLLocationAccuracyHundredMeters
        
        if #available(iOS 14.0, *) {
            switch locationManager.authorizationStatus {
            case .authorizedAlways, .authorizedWhenInUse:
                locationManager.startUpdatingLocation()
                return .authorized
            case .notDetermined, .restricted:
                locationManager.requestWhenInUseAuthorization()
                return .notDecided
            case .denied:
                return .denied
            @unknown default:
                return .nothing
            }
        } else {
            switch CLLocationManager.authorizationStatus() {
            case .authorizedAlways, .authorizedWhenInUse:
                locationManager.startUpdatingLocation()
                return .authorized
            case .notDetermined, .restricted:
                locationManager.requestWhenInUseAuthorization()
                return .notDecided
            case .denied:
                return .denied
            @unknown default:
                return .nothing
            }
        }
    }
}
