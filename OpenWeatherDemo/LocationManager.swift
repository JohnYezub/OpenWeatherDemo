//
//  LocationManager.swift
//  OpenWeatherDemo
//
//  Created by   admin on 18.11.2020.
//

import Foundation
import CoreLocation

class LocationManager: NSObject {
   
    var completeLocation: ((CLLocation?, Error?)->())?
    private var locationManager = CLLocationManager()
    ///we update user location once we get location
    ///use it for placemark
    private var userLocation: CLLocation?
    
    override init() {
        super.init()
        locationManager.delegate = self
        locationManager.desiredAccuracy = kCLLocationAccuracyBest
        locationManager.requestWhenInUseAuthorization()
    }
}

extension LocationManager: CLLocationManagerDelegate {
    
    internal func locationManager(_ manager: CLLocationManager, didChangeAuthorization status: CLAuthorizationStatus) {

        ///once we get auth status - we request location or send nil to completion
        switch status {
        case .authorizedWhenInUse, .authorizedAlways:
            print("authorized, requesting location...")
            //locationManager.requestLocation()
            locationManager.startUpdatingLocation()
        default:
            print("no location access is allowed")
            completeLocation?(nil, nil)
        }
    }
    
    internal func locationManager(_ manager: CLLocationManager, didUpdateLocations locations: [CLLocation]) {
        guard let recentLocation = locations.last else {
            completeLocation?(nil, nil)
            return }
        print(locations)
        locationManager.stopUpdatingLocation()
        userLocation = recentLocation
        print("didUpdateLocations:")
        print(recentLocation as Any)
        completeLocation?(recentLocation, nil)
    }
    
    internal func locationManager(_ manager: CLLocationManager, didFailWithError error: Error) {
        completeLocation?(nil, error)
        print("didFailWithError: \(error.localizedDescription)")
    }
}

