//
//  WeatherModel.swift
//  WeatherApp
//
//  Weather data models
//

import Foundation

// Matches the JSON from Open-Meteo API
struct OpenMeteoResponse: Codable {
	let current: CurrentWeatherData
}

struct CurrentWeatherData: Codable {
	let temperature_2m: Double
	let wind_speed_10m: Double
	let weather_code: Int
}

// Our clean app model
struct WeatherModel {
	let temperature: Double
	let windSpeed: Double
	let weatherCode: Int

	var conditionText: String {
		switch weatherCode {
		case 0: return "Clear Sky"
		case 1, 2, 3: return "Partly Cloudy"
		case 45, 48: return "Foggy"
		case 51, 53, 55: return "Drizzle"
		case 61, 63, 65: return "Rainy"
		case 71, 73, 75, 77: return "Snowy"
		case 80, 81, 82: return "Rain Showers"
		case 85, 86: return "Snow Showers"
		case 95, 96, 99: return "Thunderstorm"
		default: return "Unknown"
		}
	}

	var conditionIcon: String {
		switch weatherCode {
		case 0: return "sun.max.fill"
		case 1, 2, 3: return "cloud.sun.fill"
		case 45, 48: return "cloud.fog.fill"
		case 51, 53, 55: return "cloud.drizzle.fill"
		case 61, 63, 65: return "cloud.rain.fill"
		case 71, 73, 75, 77: return "cloud.snow.fill"
		case 80, 81, 82: return "cloud.heavyrain.fill"
		case 85, 86: return "cloud.snow.fill"
		case 95, 96, 99: return "cloud.bolt.fill"
		default: return "questionmark.circle"
		}
	}
}
