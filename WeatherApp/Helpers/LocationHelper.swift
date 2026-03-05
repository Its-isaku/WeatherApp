//
//  LocationHelper.swift
//  WeatherApp
//
//  Created by Isai Magdaleno Almeraz Landeros on 28/02/26.
//

import Foundation
import CoreLocation
import Combine

class LocationHelper: NSObject, ObservableObject, CLLocationManagerDelegate {
	
	// CoreLocation -> API that handles
	private let manager: CLLocationManager = CLLocationManager()
	
	// Location from GPS
	@Published var location: CLLocationCoordinate2D?
	
	// Is Loading -> tracks the status
	@Published var isLoading: Bool = false
	
	// Current Permission state
	@Published var authStatus: CLAuthorizationStatus = .notDetermined
	
	override init() {
		
		super.init()
		
		manager.delegate = self
		manager.desiredAccuracy = kCLLocationAccuracyBest
		authStatus = manager.authorizationStatus
	}
	
	func requestLocation() {
		isLoading = true
		manager.requestLocation()
	}
	
	func requestPermissionAndLocation() {
		authStatus = manager.authorizationStatus
		if authStatus == .notDetermined {
			manager.requestWhenInUseAuthorization()
			return
		}
		
		if authStatus == .authorizedWhenInUse || authStatus == .authorizedAlways {
			requestLocation()
			return
		}
	}
	
	func locationManagerDidChangeAuthorization(_ manager: CLLocationManager) {
		
		authStatus = manager.authorizationStatus
		
		if authStatus == .authorizedWhenInUse || authStatus == .authorizedAlways {
			requestLocation()
		} else {
			isLoading = false
		}
	}
	
	func locationManager(_ manager: CLLocationManager, didUpdateLocations locations: [CLLocation]) {
	
		if let lastLocation = locations.last {
			location = lastLocation.coordinate
		}
		
		isLoading = false
	}
	
	func locationManager(_ manager: CLLocationManager, didFailWithError error: any Error) {
		
		isLoading = false
		
	}
	
}
