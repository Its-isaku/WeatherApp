//
//  WeatherViewModel.swift
//  WeatherApp
//
//  Manages weather state using MVVM pattern
//

import Foundation
import CoreLocation
import Combine

@MainActor
class WeatherViewModel: ObservableObject {

	@Published var isLoading: Bool = false
	@Published var weather: WeatherModel? = nil
	@Published var errorMessage: String = ""
	@Published var lastUpdated: Date? = nil
	@Published var useCelsius: Bool = true

	private let service: WeatherService = WeatherService()

	// Fetch weather for a given coordinate
	func fetchWeather(latitude: Double, longitude: Double) async {

		self.isLoading = true
		self.errorMessage = ""

		do {
			let result = try await self.service.fetchWeather(
				latitude: latitude,
				longitude: longitude
			)
			self.weather = result
			self.lastUpdated = Date()
		} catch let error as WeatherError {
			switch error {
			case .invalidURL:
				self.errorMessage = "Something went wrong (bad URL)"
			case .badResponse:
				self.errorMessage = "Server error, try again later"
			case .decodeFailed:
				self.errorMessage = "Could not read weather data"
			case .noConnection:
				self.errorMessage = "No internet connection"
			}
		} catch {
			self.errorMessage = "Something went wrong"
		}

		self.isLoading = false
	}

	// Shows temperature in C or F depending on toggle
	var displayTemperature: String {
		guard let weather = self.weather else { return "--" }
		if self.useCelsius {
			return String(format: "%.1f°C", weather.temperature)
		} else {
			let fahrenheit: Double = (weather.temperature * 9.0 / 5.0) + 32.0
			return String(format: "%.1f°F", fahrenheit)
		}
	}
}
