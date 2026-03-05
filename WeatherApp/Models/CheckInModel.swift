//
//  CheckInModel.swift
//  WeatherApp
//
//  Created by Isai Magdaleno Almeraz Landeros on 28/02/26.
//

import Foundation
import Combine

struct CheckInModel: Identifiable {
	
	let id: UUID
	let latitude: Double
	let longitude: Double
	let timestamp: Date
	
	init(id: UUID = UUID(), latitude: Double, longitude: Double, timestamp: Date) {
		self.id = id
		self.latitude = latitude
		self.longitude = longitude
		self.timestamp = timestamp
	}	
}
