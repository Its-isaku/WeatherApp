//
//  LocationViewModel.swift
//  WeatherApp
//
//  Created by Isai Magdaleno Almeraz Landeros on 28/02/26.
//

import Foundation
import CoreLocation
import Combine

enum LocationViewState {
	case needsPermission
	case loading
	case ready
	case denied
	case failed
}

class LocationViewModel: ObservableObject {
	
	@Published var viewState: LocationViewState = LocationViewState.needsPermission
	
	@Published var latitudeText: String = "--"
	@Published var longitudeText: String = "--"
	
	@Published var errorMessage: String = ""
	@Published var lastCoordinate: CLLocationCoordinate2D? = nil
	@Published var checkIns: [CheckInModel] = []
	
	private let locationManager: LocationHelper = LocationHelper()
	private var cancellables: Set<AnyCancellable> = Set<AnyCancellable>()
	
	init() {
		
		self.locationManager.objectWillChange.sink {
			[weak self] in
			DispatchQueue.main.async {
				if self != nil {
					self!.updateUIfromManager()
				}
			}
		}
		.store(in: &self.cancellables)
		self.updateUIfromManager()
		
	}
	
	func updateUIfromManager () {
		if self.locationManager.isLoading == true {
			self.viewState = LocationViewState.loading
			return
		}
		
		let status: CLAuthorizationStatus = self.locationManager.authStatus
		
		if status == CLAuthorizationStatus.notDetermined {
			self.viewState = LocationViewState.needsPermission
			return
		}
			
		if status == CLAuthorizationStatus.denied || status == CLAuthorizationStatus.restricted {
			self.errorMessage = "Location is OFF, enable it in Settings"
			self.viewState = LocationViewState.denied
			return
		}
		
		if self.locationManager.location != nil {
			let coordinate:CLLocationCoordinate2D = self.locationManager.location!
			
			self.latitudeText = String(format: "%.5f", coordinate.latitude)
			self.longitudeText = String(format: "%.5f", coordinate.longitude)
			self.lastCoordinate = coordinate

			self.viewState = LocationViewState.ready
			return
			
		}
		
		self.errorMessage = "Could not read Location"
		self.viewState = LocationViewState.failed
		
	}
	
	
	func saveCheckIn () {
		if self.locationManager.location == nil {
			return
		}
		
		let coordinate: CLLocationCoordinate2D = self.locationManager.location!
		
		let newCoord: CheckInModel = CheckInModel(
			latitude: coordinate.latitude,
			longitude: coordinate.longitude,
			timestamp: Date()
		)
		
		self.checkIns.insert(newCoord, at: 0)
	}
	
	func clearAll () {
		self.checkIns.removeAll()
	}
	
	func enableLocation () {
		self.errorMessage = ""
		self.viewState = .loading
		self.locationManager.requestPermissionAndLocation()
	}
	
	func refreshBtn () {
		self.errorMessage = ""
		self.viewState = .loading
		self.locationManager.requestPermissionAndLocation()
	}
	
}
