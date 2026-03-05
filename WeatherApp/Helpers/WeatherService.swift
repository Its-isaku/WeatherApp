//
//  WeatherService.swift
//  WeatherApp
//
//  Networking layer - fetches weather from Open-Meteo API (free, no API key needed)
//

import Foundation

enum WeatherError: Error {
	case invalidURL
	case badResponse
	case decodeFailed
	case noConnection
}

class WeatherService {

	func fetchWeather(latitude: Double, longitude: Double) async throws -> WeatherModel {

		// Build URL safely using URLComponents
		var components: URLComponents = URLComponents()
		components.scheme = "https"
		components.host = "api.open-meteo.com"
		components.path = "/v1/forecast"
		components.queryItems = [
			URLQueryItem(name: "latitude", value: String(latitude)),
			URLQueryItem(name: "longitude", value: String(longitude)),
			URLQueryItem(name: "current", value: "temperature_2m,wind_speed_10m,weather_code")
		]

		// Make sure URL is valid
		guard let url = components.url else {
			throw WeatherError.invalidURL
		}

		// Fetch data from the internet
		let data: Data
		let response: URLResponse

		do {
			(data, response) = try await URLSession.shared.data(from: url)
		} catch {
			throw WeatherError.noConnection
		}

		// Check for good response (200 = OK)
		if let httpResponse = response as? HTTPURLResponse {
			if httpResponse.statusCode != 200 {
				throw WeatherError.badResponse
			}
		}

		// Decode the JSON into our model
		let decoded: OpenMeteoResponse

		do {
			decoded = try JSONDecoder().decode(OpenMeteoResponse.self, from: data)
		} catch {
			throw WeatherError.decodeFailed
		}

		// Return a clean WeatherModel
		let weather: WeatherModel = WeatherModel(
			temperature: decoded.current.temperature_2m,
			windSpeed: decoded.current.wind_speed_10m,
			weatherCode: decoded.current.weather_code
		)

		return weather
	}
}
